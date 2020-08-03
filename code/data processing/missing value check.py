# -*- coding: utf-8 -*-
"""
Created on Thu Mar 12 21:11:50 2020

@author: wills
"""

#%% To start
import pandas as pd
import numpy as np
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/')


#%%
location1='C:/Users/wills/Documents/data/Zillow data AZ/'
HeatAZ=pd.read_stata(location1+'heating change.dta')

df=HeatAZ
c=df['ImportParcelID'].count()

df.rename(columns={'Heating20180805':'T6', 'Heating20160322':'T1','Heating20170203':'T2', 'Heating20170731':'T3',
                       'Heating20171102':'T4','Heating20180107':'T5'}, inplace=True)
df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] == ''),'mark'] = '1'
df=df[df.mark!='1']
df.loc[(df['T1'] != '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark'] = '1'
df=df[df.mark!='1']
df.loc[(df['T1'] == '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark1'] = '1'
df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark2'] = '2'
df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark3'] = '3'
df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] != '')&(df['T6'] != ''),'mark4'] = '4'
df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] != ''),'mark5'] = '5'
df=df[(df.mark1=='1')|(df.mark2=='2')|(df.mark3=='3')|(df.mark4=='4')|(df.mark5=='5')]

a=df[df.T6=='HP']['ImportParcelID'].count()
b=df[df.T6!='HP']['ImportParcelID'].count()

Heating = pd.DataFrame(
    {'state': ['AZ'],
     'HP': [a],
     'others': [b],
     'All':[c]
    })

#%%
National_df=pd.read_stata('C:/Users/wills/Desktop/Heat Pump Paper/Data/National/treatment and mixed control group-same county-drop remodel after 2000-only 2 periods-drop EL-Remodel_AGE.dta')
states_in_drive=National_df.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive['index']

#%%
for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/'
    df=pd.read_stata(location2+'heating change.dta')
    c=df['ImportParcelID'].count()
    df.rename(columns={'Heating20180805':'T6', 'Heating20160322':'T1','Heating20170203':'T2', 'Heating20170731':'T3',
                           'Heating20171102':'T4','Heating20180107':'T5'}, inplace=True)
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] == ''),'mark'] = '1'
    df=df[df.mark!='1']
    df.loc[(df['T1'] != '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark'] = '1'
    df=df[df.mark!='1']
    df.loc[(df['T1'] == '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark1'] = '1'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark2'] = '2'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark3'] = '3'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] != '')&(df['T6'] != ''),'mark4'] = '4'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] != ''),'mark5'] = '5'
    df=df[(df.mark1=='1')|(df.mark2=='2')|(df.mark3=='3')|(df.mark4=='4')|(df.mark5=='5')]
    
    a=df[df.T6=='HP']['ImportParcelID'].count()
    b=df[df.T6!='HP']['ImportParcelID'].count()
    
    Heating2 = pd.DataFrame(
        {'state': [i],
         'HP': [a],
         'others': [b],
         'All':[c]
        })
    Heating=pd.concat([Heating,Heating2],sort=False)

Heating.to_csv('C:/Users/wills/Desktop/missing_value_check.csv')




#%% three states  VA SC NC
for i in ['SC','NC','VA']:
    location2='D:/Zillow data/Zillow data '+i+'/'
    df=pd.read_stata(location2+'heating change.dta')
    df.rename(columns={'Heating20180805':'T6', 'Heating20160322':'T1','Heating20170203':'T2', 'Heating20170731':'T3',
                           'Heating20171102':'T4','Heating20180107':'T5'}, inplace=True)
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] == ''),'mark'] = '1'
    df=df[df.mark!='1']
    df.loc[(df['T1'] != '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark'] = '1'
    df=df[df.mark!='1']
    df.loc[(df['T1'] == '') & (df['T2'] != '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark1'] = '1'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] != '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark2'] = '2'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] != '')&(df['T5'] != '')&(df['T6'] != ''),'mark3'] = '3'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] != '')&(df['T6'] != ''),'mark4'] = '4'
    df.loc[(df['T1'] == '') & (df['T2'] == '') & (df['T3'] == '')&(df['T4'] == '')&(df['T5'] == '')&(df['T6'] != ''),'mark5'] = '5'
    df=df[(df.mark1=='1')|(df.mark2=='2')|(df.mark3=='3')|(df.mark4=='4')|(df.mark5=='5')]
    
    location3='D:/Zillow data/Zillow data '+i+'/20180805/ZAsmt/'
    main=pd.read_csv(location3+'main.txt',usecols=[1,81,82],sep='|',header=None)
    main.rename(columns={1:'ImportParcelID',81:'latitude',82:'longitude'}, inplace=True)
    
    df=pd.merge(df,main,on=['ImportParcelID'],how='left')
    
    a=df[df.T6=='HP'][['ImportParcelID','latitude','longitude']]
    b=df[df.T6!='HP'][['ImportParcelID','latitude','longitude']]
    
    a.to_csv(i+'_HP.csv')
    b.to_csv(i+'_others.csv')
 



