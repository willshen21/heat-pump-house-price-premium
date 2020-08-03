# -*- coding: utf-8 -*-
"""
Created on Mon Mar  2 10:23:55 2020

@author: wills
"""

#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/IF on premium/')
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#%%
df1=pd.read_stata('xtplfc result1-opinion.dta')
df2=pd.read_stata('xtplfc result4-HPbyPOP.dta')
df3=pd.read_stata('xtplfc result5-htdd60.dta')
df4=pd.read_stata('xtplfc result6-cldd60.dta')
df5=pd.read_stata('xtplfc result2-incomePC county.dta')
df6=pd.read_stata('C:/Users/wills/Desktop/Heat Pump Paper/Data/IF on premium/absolute price/xtplfc result2-incomePC county.dta')

df1=df1[df1['happening']>56][df1['happening']<81]
df2=df2[df2.HPbyPop<300000]
df2['HPbyPop_PC']=df2['HPbyPop']/1000000
df3=df3[df3['htdd60']<5645]
df4=df4[df4['cldd60']<4656]
df5=df5[df5['income_c_adjusted']<85000][df5['income_c_adjusted']>29000]
df6=df6[df6['income_c_adjusted']<85000][df6['income_c_adjusted']>29000]

#%%
%matplotlib

#%%

fig, ax = plt.subplots(3,2,figsize=(18,12))
ax[0,0].plot(df1['happening'].astype(float),df1['coef_1'].astype(float),"k-",lw=2)
ax[0,0].fill_between(df1['happening'].astype(float), df1['coef_1'].astype(float) - 1.96*df1['coef_1_sd'].astype(float), df1['coef_1'].astype(float) + 1.96*df1['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[0,0].axhline(y=0, color='gray', linestyle='--')
ax[0,0].set_ylabel('Price Premium (log)',fontsize=15)
ax[0,0].set_xlabel('Environmnental Awareness (global warming is happening %)',fontsize=15)
ax[0,0].spines['top'].set_visible(False)
ax[0,0].spines['right'].set_visible(False)
ax[0,0].tick_params(axis='both', which='major', labelsize=13)
ax[0,0].tick_params(axis='both', which='minor', labelsize=11)
ax[0,0].axvline(x=69, color='gray', linestyle='--') 
ax[0,0].axvline(x=63.78, color='gray', linestyle='--') 

ax[0,1].plot(df2['HPbyPop_PC'].astype(float),df2['coef_1'].astype(float),"k-",lw=2)
ax[0,1].fill_between(df2['HPbyPop_PC'].astype(float), df2['coef_1'].astype(float) - 1.96*df2['coef_1_sd'].astype(float), df2['coef_1'].astype(float) + 1.96*df2['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[0,1].axhline(y=0, color='gray', linestyle='--')
ax[0,1].set_ylabel('Price Premium(log)',fontsize=15)
ax[0,1].set_xlabel('Heat Pump Density (N/person)',fontsize=15)
ax[0,1].spines['top'].set_visible(False)
ax[0,1].spines['right'].set_visible(False)
ax[0,1].tick_params(axis='both', which='major', labelsize=13)
ax[0,1].tick_params(axis='both', which='minor', labelsize=11) 
ax[0,1].axvline(x=0.08, color='gray', linestyle='--') 

ax[1,0].plot(df3['htdd60'].astype(float),df3['coef_1'].astype(float),"k-",lw=2)
ax[1,0].fill_between(df3['htdd60'].astype(float), df3['coef_1'].astype(float) - 1.96*df3['coef_1_sd'].astype(float), df3['coef_1'].astype(float) + 1.96*df3['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[1,0].axhline(y=0, color='gray', linestyle='--')
ax[1,0].set_ylabel('Price Premium(log)',fontsize=15)
ax[1,0].set_xlabel('Annual Heating Degree Days',fontsize=15)
ax[1,0].spines['top'].set_visible(False)
ax[1,0].spines['right'].set_visible(False)
ax[1,0].tick_params(axis='both', which='major', labelsize=13)
ax[1,0].tick_params(axis='both', which='minor', labelsize=11) 
ax[1,0].axvline(x=3253, color='gray', linestyle='--') 
ax[1,0].axvline(x=4287, color='gray', linestyle='--') 

ax[1,1].plot(df4['cldd60'].astype(float),df4['coef_1'].astype(float),"k-",lw=2)
ax[1,1].fill_between(df4['cldd60'].astype(float), df4['coef_1'].astype(float) - 1.96*df4['coef_1_sd'].astype(float), df4['coef_1'].astype(float) + 1.96*df4['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[1,1].axhline(y=0, color='gray', linestyle='--')
ax[1,1].set_ylabel('Price Premium(log)',fontsize=15)
ax[1,1].set_xlabel('Annual Cooling Degree Days',fontsize=15)
ax[1,1].spines['top'].set_visible(False)
ax[1,1].spines['right'].set_visible(False)
ax[1,1].tick_params(axis='both', which='major', labelsize=13)
ax[1,1].tick_params(axis='both', which='minor', labelsize=11) 
ax[1,1].axvline(x=2037, color='gray', linestyle='--') 
ax[1,1].axvline(x=1802, color='gray', linestyle='--') 


ax[2,0].plot(df5['income_c_adjusted'].astype(float),df5['coef_1'].astype(float),"k-",lw=2)
ax[2,0].fill_between(df5['income_c_adjusted'].astype(float), df5['coef_1'].astype(float) - 1.96*df5['coef_1_sd'].astype(float), df5['coef_1'].astype(float) + 1.96*df5['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[2,0].axhline(y=0, color='gray', linestyle='--')
ax[2,0].set_ylabel('Price Premium(log)',fontsize=15)
ax[2,0].set_xlabel('Personal Income Per Capita (2018$)',fontsize=15)
ax[2,0].spines['top'].set_visible(False)
ax[2,0].spines['right'].set_visible(False)
ax[2,0].tick_params(axis='both', which='major', labelsize=13)
ax[2,0].tick_params(axis='both', which='minor', labelsize=11) 
ax[2,0].axvline(x=48019, color='gray', linestyle='--') 
ax[2,0].axvline(x=53820, color='gray', linestyle='--') 
ax[2,0].axvline(x=32555, color='gray', linestyle='--') 


ax[2,1].plot(df6['income_c_adjusted'].astype(float),df6['coef_1'].astype(float),"k-",lw=2)
ax[2,1].fill_between(df6['income_c_adjusted'].astype(float), df6['coef_1'].astype(float) - 1.96*df6['coef_1_sd'].astype(float), df6['coef_1'].astype(float) + 1.96*df6['coef_1_sd'].astype(float),color="gray", alpha=0.35)
ax[2,1].axhline(y=0, color='gray', linestyle='--')
ax[2,1].set_ylabel('Price Premium(2018$)',fontsize=15)
ax[2,1].set_xlabel('Personal Income Per Capita (2018$)',fontsize=15)
ax[2,1].spines['top'].set_visible(False)
ax[2,1].spines['right'].set_visible(False)
ax[2,1].tick_params(axis='both', which='major', labelsize=13)
ax[2,1].tick_params(axis='both', which='minor', labelsize=11) 
ax[2,1].axvline(x=48019, color='gray', linestyle='--') 
ax[2,1].axvline(x=53820, color='gray', linestyle='--') 
ax[2,1].axvline(x=32555, color='gray', linestyle='--') 


plt.subplots_adjust(left=None, bottom=None, right=None, top=None, wspace=0.2, hspace=0.7)
plt.legend()
plt.show() 

fig.savefig('myimage.pdf', format='pdf')

#%%% matrix of scatter
df=pd.read_stata('data for xtplfc-with HDD CDD.dta')
df['HPbyPop_PC']=df['HPbyPop']/1000000
df=df[['happening','HPbyPop_PC','IncomePC_county','cldd60','htdd60']]
df=df.rename(columns={"happening": "Awareness", "HPbyPop_PC": "HP density","IncomePC_county":"Income","cldd60":"CDD",
                      "htdd60":"HDD"})


from pandas.plotting import scatter_matrix
scatter_matrix(df, alpha = 0.2, figsize = (13, 13), diagonal = 'kde')













