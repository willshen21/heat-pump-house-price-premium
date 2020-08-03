# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 11:18:57 2019

@author: wills
"""
#%%
import os
os.chdir('C:/Users/wills/Documents/data/Analysis/matching by county level')
import pandas as pd
import numpy as np

#%% sort out counties that had both treatment and control
location='C:/Users/wills/Documents/data/Analysis/matching8/'
data=pd.read_stata(location+'treatment and mixed control group-for regression.dta')

treatment_county=data.groupby('FIPS')['treatment'].value_counts()
treatment_county.rename(columns={'treatment':'count'}, inplace=True)
treatment_county=treatment_county.reset_index()
treatment_county['treatment']=treatment_county['treatment'].astype(int)
county=treatment_county[treatment_county['treatment']==1]['FIPS']
county=county.to_frame()
county['treatment_in_the_county']='in'
data['FIPS']=data['FIPS'].astype('object')
county['FIPS']=county['FIPS'].astype('object')
data=pd.merge(data,county,on=['FIPS'],how='left')
data['treatment_in_the_county'].value_counts()
data2=data[data['treatment_in_the_county']=='in']
data2['FIPS'].value_counts()

 
print(*county['FIPS'].astype(int))

county.to_csv(location+'county.csv')

#county FIPS that had treatment
'1073 4003 4015 4019 4021 4023 5063 8025 9003 9007 9009 9011 9015 10003 12017 12081 13011 13013 13029 13051 13057 13067 13137 13139 13195 13223 13233 13241 13311 21001 21007 21061 21065 21069 21073 21075 21079 21115 21119 21155 21173 21175 21177 21179 21187 21191 21197 21203 21211 21217 21231 24001 24003 24005 24009 24011 24013 24015 24017 24019 24021 24029 24035 24037 24041 24043 24045 24047 24510 26005 26021 26039 26075 26077 26081 26115 26121 26139 27015 27057 27119 27171 31019 31025 31043 31047 31055 31079 31093 31095 31101 31107 31109 31141 31145 31157 31169 31175 31177 31179 32003 37005 37011 37019 37023 37025 37027 37031 37033 37035 37039 37045 37049 37057 37059 37063 37067 37073 37075 37079 37081 37085 37089 37093 37097 37101 37105 37109 37115 37119 37123 37125 37129 37137 37141 37143 37145 37147 37151 37157 37161 37163 37165 37171 37173 37179 37189 37191 37195 37197 39007 39009 39013 39015 39019 39039 39045 39053 39059 39079 39087 39095 39105 39129 39131 39145 39149 39165 39167 39169 40009 40017 40031 40041 40079 40083 40121 41003 41007 41009 41015 41019 41021 41033 41035 41039 41041 41051 41053 41057 41059 41065 41067 41071 42001 42007 42017 42027 42029 42041 42043 42071 42075 42081 42095 42103 42107 42113 42133 45003 45013 45019 45027 45035 45039 45043 45063 45073 45077 45079 45083 46059 46127 51003 51009 51015 51019 51023 51027 51031 51033 51041 51043 51047 51059 51061 51065 51067 51069 51073 51075 51077 51081 51085 51087 51095 51099 51115 51119 51125 51127 51137 51143 51153 51157 51161 51165 51167 51169 51171 51177 51179 51185 51187 51191 51195 51199 51520 51530 51540 51570 51620 51630 51650 51660 51670 51700 51710 51760 51810 53001 53005 53007 53011 53015 53017 53027 53029 53033 53035 53037 53039 53045 53047 53049 53053 53055 53057 53059 53061 53063 53065 53067 53071 53073 53077'
#

#%% Matching on county level - county weights
location='C:/Users/wills/Documents/data/Analysis/matching8/'
data=pd.read_stata(location+'treatment and mixed control group-after CEM(county)for regression.dta')
data=data[data['timeid']==1]
CT=data['treatment'].value_counts()
W1=CT[0]/CT[1]
CTS=data.groupby('FIPS')['treatment'].value_counts().to_frame()
CTS.rename(columns={'treatment':'n'}, inplace=True)
CTS=CTS.reset_index()
CTS=CTS.pivot(index='FIPS', columns='treatment', values='n')
CTS['W2']=CTS[1.0]/CTS[0.0]
CTS['W3']=CTS['W2']*W1
CTS.to_csv(location+'county_weights.csv')


#%% Matching on state level - state weights

location='C:/Users/wills/Documents/data/Analysis/matching8/'
data=pd.read_stata(location+'treatment and mixed control group-after CEM for regression.dta')
data=data[data['timeid']==1]
CT=data['treatment'].value_counts()
W1=CT[0]/CT[1]
CTS=data.groupby('state')['treatment'].value_counts().to_frame()
CTS.rename(columns={'treatment':'n'}, inplace=True)
CTS=CTS.reset_index()
CTS=CTS.pivot(index='state', columns='treatment', values='n')
CTS['W2']=CTS[1.0]/CTS[0.0]
CTS['W3']=CTS['W2']*W1
CTS.to_csv(location+'state_weights.csv')


#%% To check the citys NA
#AZ
location='C:/Users/wills/Documents/data/Zillow data AZ/20180805/ZAsmt/'
main=pd.read_csv(location+'main.txt',usecols=[1,27,29],sep='|',header=None)
main.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)
main['city'].value_counts()
main['city'].isna().sum()

#%% To check the citys NA
#In the hard drive
location='D:/Zillow data/Zillow data MD/20180805/ZAsmt/'
main=pd.read_csv(location+'main.txt',usecols=[1,27,29],sep='|',header=None)
main.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)
main['city'].value_counts()
main['city'].isna().sum()


#%% Add city and Zip into dataset &  sort out cities that had both treatment and control

#Add city and Zip into dataset

import pandas as pd
import numpy as np

location1='C:/Users/wills/Documents/data/Zillow data AZ/20180805/ZAsmt/'
mainAZ=pd.read_csv(location1+'main.txt',usecols=[1,27,29],sep='|',header=None)
mainAZ.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)

#states that treatment and control are in the same county
states_in_drive=['WA','VA','NV','NE','NC','PA','SC','OH','MD','OK','OR','GA','CT','KY','DE','MN','MI','AR','FL','SD','CO','AL']

location2='C:/Users/wills/Documents/data/Analysis/matching8/'
data=pd.read_stata(location2+'treatment and mixed control group-same county.dta')

for i in states_in_drive:
    location3='D:/Zillow data/Zillow data '+i+'/20180805/ZAsmt/'
    main=pd.read_csv(location3+'main.txt',usecols=[1,27,29],sep='|',header=None)
    main.rename(columns={1:'ImportParcelID',27:'city',29:'zip'}, inplace=True)
    mainAZ=pd.concat([mainAZ,main],sort=False)

All_city_zip=mainAZ

data=pd.merge(data,All_city_zip,on=['ImportParcelID'],how='left')
data.to_stata('C:/Users/wills/Documents/data/Analysis/matching9/treatment and mixed control group-same county-with city zip.dta')

#sort out cities that had both treatment and control
treatment_city=data.groupby('city')['treatment'].value_counts().to_frame()
treatment_city.rename(columns={'treatment':'count'}, inplace=True)
treatment_city=treatment_city.reset_index()
treatment_city['treatment']=treatment_city['treatment'].astype(int)

treatment_city=treatment_city.pivot(index='city', columns='treatment', values='count')
treatment_city=treatment_city.dropna()
treatment_city=treatment_city.reset_index()
treatment_city['CT_in_same_city']='in'
city=treatment_city[['city','CT_in_same_city']]
data=pd.merge(data,city,on=['city'],how='left')

#to see which state that CT_in_same_city
data[data['CT_in_same_city']=='in']['state'].value_counts()

data2=data[data['CT_in_same_city']=='in']
data2.to_stata('C:/Users/wills/Documents/data/Analysis/matching9/treatment and mixed control group-CT in same city.dta')



#%% Matching on city level - city weights
location='C:/Users/wills/Documents/data/Analysis/matching9/'
data=pd.read_stata(location+'treatment and mixed control group-after CEM(city)for regression.dta')
data=data[data['timeid']==1]
CT=data['treatment'].value_counts()
W1=CT[0]/CT[1]
CTS=data.groupby('city_ID')['treatment'].value_counts().to_frame()
CTS.rename(columns={'treatment':'n'}, inplace=True)
CTS=CTS.reset_index()
CTS=CTS.pivot(index='city_ID', columns='treatment', values='n')
CTS['W2']=CTS[1.0]/CTS[0.0]
CTS['W3']=CTS['W2']*W1
CTS.to_csv(location+'city_weights.csv')


#%% Exact matching on city - city weights

location='C:/Users/wills/Documents/data/Analysis/matching9/'
data=pd.read_stata(location+'treatment and mixed control group-CT in same city.dta')
data=data[data['timeid']==1]
CT=data['treatment'].value_counts()
W1=CT[0]/CT[1]
CTS=data.groupby('city_ID')['treatment'].value_counts().to_frame()
CTS.rename(columns={'treatment':'n'}, inplace=True)
CTS=CTS.reset_index()
CTS=CTS.pivot(index='city_ID', columns='treatment', values='n')
CTS['W2']=CTS[1.0]/CTS[0.0]
CTS['W3']=CTS['W2']*W1
CTS.to_csv(location+'city_weights_exactmatchoncity.csv')



#%% Exact match on county level - county weights
location='C:/Users/wills/Documents/data/Analysis/matching8/'
data=pd.read_stata(location+'treatment and mixed control group-same county-drop remodel after 2000-only 2 periods.dta')
data=data[data['timeid']==1]
CT=data['treatment'].value_counts()
W1=CT[0]/CT[1]
CTS=data.groupby('FIPS')['treatment'].value_counts().to_frame()
CTS.rename(columns={'treatment':'n'}, inplace=True)
CTS=CTS.reset_index()
CTS=CTS.pivot(index='FIPS', columns='treatment', values='n')
CTS['W2']=CTS[1.0]/CTS[0.0]
CTS['W3']=CTS['W2']*W1
CTS.to_csv(location+'county_weights2.csv')




