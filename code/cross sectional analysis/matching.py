# -*- coding: utf-8 -*-
"""
Created on Mon Sep 30 10:50:54 2019

@author: wills
"""

#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data-Post-treatment')
import pandas as pd
import numpy as np
import warnings
warnings.filterwarnings('ignore')
from pymatch.Matcher import Matcher


#%% merge city into the data
data=pd.read_stata('treatment and control group-mixed control-2016-2018.dta')

location1='C:/Users/wills/Documents/data/Zillow data AZ/20180805/ZAsmt/'
mainAZ=pd.read_csv(location1+'main.txt',usecols=[1,27,29],sep='|',header=None)
mainAZ.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)

states_in_drive=data.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive['index']

for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/20180805/ZAsmt/'
    main=pd.read_csv(location2+'main.txt',usecols=[1,27,29],sep='|',header=None)
    main.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)
    mainAZ=pd.concat([mainAZ,main],sort=False)

All_city_zip=mainAZ

data=pd.merge(data,All_city_zip,on=['ImportParcelID'],how='left')

All_city_zip.to_csv('All_city_zip.csv')
data.to_stata('treatment and control group-mixed control-2016-2018-with city.dta')


#%% sort out CT in same city
data=pd.read_stata('treatment and control group-mixed control-2016-2018-with city.dta')
data['city_ID'] = data.groupby(['state','city']).grouper.group_info[0]
treatment_city=data.groupby('city_ID')['treatment'].value_counts().to_frame()
treatment_city.rename(columns={'treatment':'count'}, inplace=True)
treatment_city=treatment_city.reset_index()
treatment_city['treatment']=treatment_city['treatment'].astype(int)

treatment_city=treatment_city.pivot(index='city_ID', columns='treatment', values='count')
treatment_city=treatment_city.dropna()
treatment_city=treatment_city.reset_index()
treatment_city['CT_in_same_city']='in'
city=treatment_city[['city_ID','CT_in_same_city']]
data=pd.merge(data,city,on=['city_ID'],how='left')

data2=data[data['CT_in_same_city']=='in']
data2.to_stata('treatment and control group-mixed control-2016-2018-CT same city.dta')

del treatment_city

#%% start matching
data2=pd.read_stata('treatment and control group-mixed control-2016-2018-CT same city.dta')
del data2['index']
data2=data2.reset_index()
data2.rename(columns={'index':'Unique_Index'}, inplace=True)

city=data2['city_ID'].value_counts().to_frame().reset_index()


Matched=pd.DataFrame(
        {'record_id': [],
         'weight': [],
         'Unique_Index': [],
         'state': [],
         'city_ID':[],
         'year':[],
         'logprice_adjusted':[],
         'ImportParcelID':[],
         'timeid':[],
         'treatment':[],
         'YearBuilt':[],
         'NoOfStories':[],
         'TotalRooms':[],
         'TotalBedrooms':[],
         'area':[],
         'LandAssessedValue_persqft':[],
         'scores':[],
         'match_id':[]
        })


for i in [2016,2017,2018]:
    for j in city['index']:
        try:
            data3=data2[data2['city_ID']==j][data2['year']==i]
            treated=data3[data3['treatment']==1][['Unique_Index','state','city_ID','year','logprice_adjusted',
                                                  'ImportParcelID','timeid','treatment',
                                                  'YearBuilt','NoOfStories','TotalRooms','TotalBedrooms','area','LandAssessedValue_persqft']]
            treated=treated.fillna(treated.mean())
            control=data3[data3['treatment']==0][['Unique_Index','state','city_ID','year','logprice_adjusted',
                                                  'ImportParcelID','timeid','treatment',
                                                  'YearBuilt','NoOfStories','TotalRooms','TotalBedrooms','area','LandAssessedValue_persqft']]
            control=control.fillna(control.mean())
            m = Matcher(treated, control, yvar="treatment", exclude=['Unique_Index','state','city_ID','year','ImportParcelID','timeid','logprice_adjusted'])
            m.fit_scores(balance=True, nmodels=50)
            m.predict_scores()
            m.match(method="min", nmatches=3, threshold=0.0001)
            m.assign_weight_vector()
            Matched=pd.concat([Matched,m.matched_data ],sort=False)       
        except:
            pass
        




#%% sort out cities that have both CT
Matched=pd.read_csv('Matched4-1to3-add landvaluepersqft-balance false.csv')
treatment_city=Matched.groupby('city')['treatment'].value_counts().to_frame()
treatment_city.rename(columns={'treatment':'count'}, inplace=True)
treatment_city=treatment_city.reset_index()
treatment_city['treatment']=treatment_city['treatment'].astype(int)

treatment_city=treatment_city.pivot(index='city', columns='treatment', values='count')
treatment_city=treatment_city.dropna()
treatment_city=treatment_city.reset_index()
treatment_city['CT_in_same_city']='in'
city=treatment_city[['city','CT_in_same_city']]
Matched=pd.merge(Matched,city,on=['city'],how='left')
Matched=Matched[Matched['CT_in_same_city']=='in']



