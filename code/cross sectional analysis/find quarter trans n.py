# -*- coding: utf-8 -*-
"""
Created on Mon Mar  9 15:20:22 2020

@author: wills
"""

#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data-Post-treatment')
import pandas as pd
import numpy as np

#%% Tran
data=pd.read_stata('matched data-with n_hp_sale.dta')
states_in_drive=data.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive[states_in_drive['index']!='FL']
states_in_drive=states_in_drive[states_in_drive['index']!='IN']
states_in_drive=states_in_drive['index']

#%%
location1='C:/Users/wills/Documents/data/Zillow data AZ/'
TranAZ=pd.read_stata(location1+'ZTrans sale with dates.dta')
TranAZ['year'] = pd.DatetimeIndex(TranAZ['RecordingDate']).year
TranAZ=TranAZ[TranAZ.year>=2016]
TranAZ['quarter'] = pd.DatetimeIndex(TranAZ['RecordingDate']).quarter
TranAZ=TranAZ[['PropertyCity','PropertyState','year', 'quarter']]
TranAZ['n']='Y'
TranAZ=TranAZ.groupby(['year','quarter','PropertyState','PropertyCity']).count().reset_index()

#%%
for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/'
    Tran=pd.read_stata(location2+'ZTrans sale with dates.dta')
    Tran['year'] = pd.DatetimeIndex(Tran['RecordingDate']).year
    Tran=Tran[Tran.year>=2016]
    Tran['quarter'] = pd.DatetimeIndex(Tran['RecordingDate']).quarter
    Tran=Tran[['PropertyCity','PropertyState','year', 'quarter']]
    Tran['n']='Y'
    Tran=Tran.groupby(['year','quarter','PropertyState','PropertyCity']).count().reset_index()
    TranAZ=pd.concat([TranAZ,Tran],sort=False)

All_Tran=TranAZ
All_Tran.to_stata('All_Tran_N.dta')

#%% sale
data=pd.read_stata('matched data-with n_hp_sale.dta')
states_in_drive=data.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive[states_in_drive['index']!='OK']
states_in_drive=states_in_drive[states_in_drive['index']!='IL']
states_in_drive=states_in_drive['index']

#%%
location1='C:/Users/wills/Documents/data/Zillow data AZ/'
SaleAZ=pd.read_stata(location1+'saledata with importparcelID.dta')
SaleAZ['year'] = pd.DatetimeIndex(SaleAZ['RecordingDate']).year
SaleAZ=SaleAZ[SaleAZ.year>=2016]
SaleAZ['quarter'] = pd.DatetimeIndex(SaleAZ['RecordingDate']).quarter
SaleAZ=SaleAZ[['year','quarter','ImportParcelID']]
SaleAZ['state']='AZ'

location11='C:/Users/wills/Documents/data/Zillow data AZ/20180805/ZAsmt/'
mainAZ=pd.read_csv(location11+'main.txt',usecols=[1,27],sep='|',header=None)
mainAZ.rename(columns={1:'ImportParcelID',27:'city'}, inplace=True)

SaleAZ=pd.merge(SaleAZ,mainAZ,on=['ImportParcelID'],how='left')
SaleAZ=SaleAZ.groupby(['year','quarter','state','city']).count().reset_index()
SaleAZ.rename(columns={'ImportParcelID':'n'}, inplace=True)

#%%
for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/'
    Sale=pd.read_stata(location2+'saledata with importparcelID.dta')
    Sale['year'] = pd.DatetimeIndex(Sale['RecordingDate']).year
    Sale=Sale[Sale.year>=2016]
    Sale['quarter'] = pd.DatetimeIndex(Sale['RecordingDate']).quarter
    Sale=Sale[['year','quarter','ImportParcelID']]
    Sale['state']=i
    
    location21='D:/Zillow data/Zillow data '+i+'/20180805/ZAsmt/'
    main=pd.read_csv(location21+'main.txt',usecols=[1,27],sep='|',header=None)
    main.rename(columns={1:'ImportParcelID',27:'city'}, inplace=True)
    
    Sale=pd.merge(Sale,main,on=['ImportParcelID'],how='left')
    Sale=Sale.groupby(['year','quarter','state','city']).count().reset_index()
    Sale.rename(columns={'ImportParcelID':'n'}, inplace=True)
    SaleAZ=pd.concat([SaleAZ,Sale],sort=False)

All_Sale=SaleAZ
All_Sale.to_stata('All_Sale_N.dta')












