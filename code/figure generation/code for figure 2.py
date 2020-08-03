# -*- coding: utf-8 -*-
"""
Created on Wed Feb  5 20:42:18 2020

@author: wills
"""

#%% To start
import os
os.chdir('C:/Users/wills/Documents/data/Validation')
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


#%%
%matplotlib

#%%
xls = pd.ExcelFile('Robustness Check by 2015 RECS Data.xlsx')
df1 = pd.read_excel(xls, 'Probit')

xls2 = pd.ExcelFile('building feature change result.xlsx')
df2 = pd.read_excel(xls2, 'impact')


#%%
fig, ax = plt.subplots(2,1)
y_pos=np.arange(len(df1['Energy Retrofits ']))
ax[0].barh(y_pos, df1['Pr(%)'], xerr=df1['Std. Err.']*196, align='center', alpha=0.5, ecolor='black', capsize=10)
ax[0].set_xlabel('Marginal increased probability(%) of adopting energy-efficiency measures',fontsize=18)
ax[0].set_yticks(y_pos)
ax[0].set_yticklabels(df1['Energy Retrofits '], fontsize=18)
ax[0].xaxis.grid(True)
ax[0].spines['top'].set_visible(False)
ax[0].spines['right'].set_visible(False)
ax[0].axvline(x=0, color='gray', linestyle='--')
ax[0].tick_params(labelsize=15)

y_pos2=np.arange(len(df2['feature']))
ax[1].barh(y_pos2, df2['coef'], xerr=df2['StdErr']*1.96, align='center', alpha=0.5, ecolor='black', capsize=10)
ax[1].set_xlabel('Building feature changes induced by adopting an air-source heat pump',fontsize=18)
ax[1].set_yticks(y_pos2)
ax[1].set_yticklabels(df2['feature'], fontsize=18)
ax[1].xaxis.grid(True)
ax[1].spines['top'].set_visible(False)
ax[1].spines['right'].set_visible(False)
ax[1].axvline(x=0, color='gray', linestyle='--')
ax[1].tick_params(labelsize=15)

plt.subplots_adjust(left=0.3,hspace = 0.3)
plt.legend()
plt.show()
#%%

fig.savefig('figure2.pdf', format='pdf')

