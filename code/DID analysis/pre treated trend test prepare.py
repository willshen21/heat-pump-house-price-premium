# -*- coding: utf-8 -*-
"""
Created on Fri Nov 22 14:25:51 2019

@author: wills
"""
#%%
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/National')
import pandas as pd
import numpy as np
from datetime import datetime

#%%
df=pd.read_stata('treatment and mixed control group.dta')
df=df[df['treatment']==1]
df=df.drop_duplicates(subset=['ImportParcelID'], keep='first')
df=df[['ImportParcelID','beforetime','state']]


#%% For AZ
location1='C:/Users/wills/Documents/data/Zillow data AZ/'
saledata=pd.read_stata(location1+'saledata with importparcelID.dta',columns=['ImportParcelID','RecordingDate','SalesPriceAmount'])
saledata=pd.merge(saledata,df,on=['ImportParcelID'],how='left')
saledata =saledata[pd.notnull(saledata['beforetime'])]
saledata['beforetime'] = pd.to_datetime(saledata['beforetime'],format='%Y-%m-%d')
saledata['RecordingDate'] = pd.to_datetime(saledata['RecordingDate'],format='%Y-%m-%d')
saledata=saledata[saledata['beforetime']>saledata['RecordingDate']]

trandata=pd.read_stata(location1+'ZTrans sale with dates.dta',columns=['ImportParcelID','RecordingDate','SalesPriceAmount'])
trandata=pd.merge(trandata,df,on=['ImportParcelID'],how='left')
trandata =trandata[pd.notnull(trandata['beforetime'])]
trandata['beforetime'] = pd.to_datetime(trandata['beforetime'],format='%Y-%m-%d')
trandata['RecordingDate'] = pd.to_datetime(trandata['RecordingDate'],format='%Y-%m-%d')
trandata=trandata[trandata['beforetime']>trandata['RecordingDate']]

predf=pd.concat([saledata,trandata],sort=False)

#%%
# FL no tran
states_in_drive=df.state.value_counts().reset_index()
states_in_drive=states_in_drive[states_in_drive['index']!='AZ']
states_in_drive=states_in_drive[states_in_drive['index']!='FL']
states_in_drive=states_in_drive['index']

#%% 
for i in states_in_drive:
    location2='D:/Zillow data/Zillow data '+i+'/'
    saledata=pd.read_stata(location2+'saledata with importparcelID.dta',columns=['ImportParcelID','RecordingDate','SalesPriceAmount'])
    saledata=pd.merge(saledata,df,on=['ImportParcelID'],how='left')
    saledata =saledata[pd.notnull(saledata['beforetime'])]
    saledata['beforetime'] = pd.to_datetime(saledata['beforetime'],format='%Y-%m-%d')
    saledata['RecordingDate'] = pd.to_datetime(saledata['RecordingDate'],format='%Y-%m-%d')
    saledata=saledata[saledata['beforetime']>saledata['RecordingDate']]
    
    trandata=pd.read_stata(location2+'ZTrans sale with dates.dta',columns=['ImportParcelID','RecordingDate','SalesPriceAmount'])
    trandata=pd.merge(trandata,df,on=['ImportParcelID'],how='left')
    trandata =trandata[pd.notnull(trandata['beforetime'])]
    trandata['beforetime'] = pd.to_datetime(trandata['beforetime'],format='%Y-%m-%d')
    trandata['RecordingDate'] = pd.to_datetime(trandata['RecordingDate'],format='%Y-%m-%d')
    trandata=trandata[trandata['beforetime']>trandata['RecordingDate']]
    
    predf=pd.concat([predf,saledata,trandata],sort=False)

#%% for FL
location3='D:/Zillow data/Zillow data FL/'
saledata=pd.read_stata(location3+'saledata with importparcelID.dta',columns=['ImportParcelID','RecordingDate','SalesPriceAmount'])
saledata=pd.merge(saledata,df,on=['ImportParcelID'],how='left')
saledata =saledata[pd.notnull(saledata['beforetime'])]
saledata['beforetime'] = pd.to_datetime(saledata['beforetime'],format='%Y-%m-%d')
saledata['RecordingDate'] = pd.to_datetime(saledata['RecordingDate'],format='%Y-%m-%d')
saledata=saledata[saledata['beforetime']>saledata['RecordingDate']]

predf=pd.concat([predf,saledata],sort=False)

#%%
df2=pd.read_stata('treatment and mixed control group.dta')
df2=df2[df2['treatment']==1]
df2=df2.drop_duplicates(subset=['ImportParcelID'], keep='first')
df2=df2[['ImportParcelID','YearBuilt', 'YearRemodeled','FIPS']]
predf=pd.merge(predf,df2,on=['ImportParcelID'],how='left')

predf['year'] = pd.DatetimeIndex(predf['RecordingDate']).year
predf['month'] = pd.DatetimeIndex(predf['RecordingDate']).month
predf['day'] = pd.DatetimeIndex(predf['RecordingDate']).day

predf.to_stata('predf.dta')

#%%gragh

import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/National')
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


#%%
%matplotlib

#%%
df=pd.read_excel('pre trend test result.xlsx')

fig, ax = plt.subplots(figsize=(10,8))

a=df['coef'].astype(float)
b=df['StdErr'].astype(float)
ax.errorbar(range(2000,2017),a,yerr=b*1.96,fmt='ks-',ecolor='g',elinewidth=1.5,capsize=7,capthick=1)
ax.axhline(y=0, color='gray', linestyle='--')
ax.set_ylabel('Coef of the interaction terms',fontsize=14)
ax.set_xlabel('Year',fontsize=14)
ax.set_title('Pre-treated parallel time trend test',fontsize=14)
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

plt.legend()
plt.show()   









