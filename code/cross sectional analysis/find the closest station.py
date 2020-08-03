# -*- coding: utf-8 -*-
"""
Created on Thu Oct 10 16:26:01 2019

@author: wills
"""
#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data-Post-treatment/')
import pandas as pd
import numpy as np

#%%
National_df=pd.read_stata('matched data.dta')
Cost_df=pd.read_csv('Heat Pump 6_aef_2010.csv')

#%% get all the lontiude and latitude
location1='C:/Users/wills/Documents/data/Zillow data AZ/20180805/ZAsmt/'
mainAZ=pd.read_csv(location1+'main.txt',usecols=[1,81,82],sep='|',header=None)
mainAZ.rename(columns={1:'ImportParcelID',81:'latitude',82:'longitude'}, inplace=True)

states_in_drive=National_df.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive['index']

for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/20180805/ZAsmt/'
    main=pd.read_csv(location2+'main.txt',usecols=[1,81,82],sep='|',header=None)
    main.rename(columns={1:'ImportParcelID',81:'latitude',82:'longitude'}, inplace=True)
    mainAZ=pd.concat([mainAZ,main],sort=False)

All_lat_long=mainAZ

National_df=pd.merge(National_df,All_lat_long,on=['ImportParcelID'],how='left')

#%% prepare the data for matching
data1=National_df[['ImportParcelID','latitude','longitude']].drop_duplicates()

Cost_df=Cost_df.reset_index()
Cost_df.rename(columns={'index':'StationID'}, inplace=True)
data2=Cost_df[['StationID','latitude','longitude']]

#clean data
data1 = data1.dropna()
data2 = data2.dropna()

data1.latitude=data1.latitude.astype(float)
data1.longitude=data1.longitude.astype(float)
data2.latitude=data2.latitude.astype(float)
data2.longitude=data2.longitude.astype(float)

#%% define the function
import math
def distance(origin, destination):
    
    lat1, lon1 = origin
    lat2, lon2 = destination
    radius = 6371000  # m

    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = (math.sin(dlat / 2) * math.sin(dlat / 2) +
         math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) *
         math.sin(dlon / 2) * math.sin(dlon / 2))
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    d = radius * c

    return d
#%% start matching
data4 = pd.DataFrame([], columns=['ImportParcelID','StationID','Distance'])

for index1,row1 in data1.iterrows():
    origin = (row1.latitude, row1.longitude)
    data3 = pd.DataFrame([], columns=['ImportParcelID','StationID','Distance'])
    margin = 0.5    
    
    for index2,row2 in (data2[data2.latitude >= origin[0] - margin]
        [data2.latitude <= origin[0] + margin][data2.longitude >= origin[1] - margin]
        [data2.longitude <= origin[1] + margin].iterrows()):
        
        destination=(row2.latitude,row2.longitude)
        D=distance(origin, destination)
        matched=pd.DataFrame([[row1.ImportParcelID,row2.StationID,D]], columns=['ImportParcelID','StationID','Distance'])
        data3=data3.append(matched,ignore_index=True)
    data3=data3.loc[data3.groupby("ImportParcelID")["Distance"].idxmin()]
    data4=data4.append(data3,ignore_index=True)

data4.to_csv('matched IDs.csv')


#%% match cost data to national_df
data4=pd.read_csv('matched IDs.csv')
National_df=pd.read_stata('matched data.dta')
Cost_df=pd.read_csv('Heat Pump 6_aef_2010.csv')

Cost_df['costsaving_hpng']= Cost_df['ng.fuelcost']-Cost_df['hpng.fuelcost']
Cost_df['costsaving_hper']= Cost_df['er.fuelcost']-Cost_df['hper.fuelcost']
mask=(Cost_df['total.er.btu']==0)
Cost_df['costsaving']=Cost_df['costsaving_hper']
Cost_df['costsaving'][mask]=Cost_df['costsaving_hpng'][mask]

Cost_df['enviro_hpng']= Cost_df['total.ng.damage']-Cost_df['total.hpng.damage']
Cost_df['enviro_hper']= Cost_df['total.er.damage']-Cost_df['total.hper.damage']
Cost_df['enviro']=Cost_df['enviro_hper']
Cost_df['enviro'][mask]=Cost_df['enviro_hpng'][mask]

Cost_df=Cost_df.reset_index()
Cost_df.rename(columns={'index':'StationID'}, inplace=True)
Cost_df=Cost_df[['StationID','costsaving','enviro']]

National_df=pd.merge(National_df,data4,on=['ImportParcelID'],how='left')
National_df=pd.merge(National_df,Cost_df,on=['StationID'],how='left')

National_df.to_stata('matched data-with cost.dta')