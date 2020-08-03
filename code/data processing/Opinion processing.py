# -*- coding: utf-8 -*-
"""
Created on Tue Jun  4 10:20:00 2019

@author: wills
"""
#%%
import os
os.chdir('C:\\Users\wills\Desktop\Heat Pump Paper')
import pandas as pd

data=pd.read_csv('YCOM_2018_Data.csv')

data1=data.loc[data['GeoType']=='County']
county=data1['GeoName'].str.split(' County, ',n=2,expand=True)
data1['county']=county[0]
data1['state']=county[1]

data2=pd.read_stata('C:\\Users\wills\Documents\data\state county FIPS.dta')



data3=pd.merge(data1,data2,on=['county','state'],how='left')

data4=data3[['county', 'state', 'FIPS', 'TotalPop', 'happening', 'happeningOppose',
       'human', 'humanOppose', 'consensus', 'consensusOppose', 'affectweather',
       'affectweatherOppose', 'worried', 'worriedOppose', 'harmplants',
       'harmplantsOppose', 'futuregen', 'futuregenOppose', 'devharm',
       'devharmOppose', 'harmUS', 'harmUSOppose', 'personal', 'personalOppose',
       'timing', 'timingOppose', 'fundrenewables', 'fundrenewablesOppose',
       'regulate', 'regulateOppose', 'CO2limits', 'CO2limitsOppose',
       'reducetax', 'reducetaxOppose', 'supportRPS', 'supportRPSOppose',
       'rebates', 'rebatesOppose', 'drillANWR', 'drillANWROppose',
       'drilloffshore', 'drilloffshoreOppose', 'teachGW', 'teachGWOppose',
       'corporations', 'corporationsOppose', 'citizens', 'citizensOppose',
       'congress', 'congressOppose', 'governor', 'governorOppose',
       'localofficials', 'localofficialsOppose', 'prienv', 'prienvOppose',
       'discuss', 'discussOppose', 'mediaweekly', 'mediaweeklyOppose']]

data4.to_csv('Opinion by FIPS.csv')

#%%
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#%%
%matplotlib
#%%
x = np.linspace(49,84,200)
y = (-4.435431+0.133511*x+(-0.0009851*x*x))*100

x_max=67.76520150238554
y_max=(-4.435431+0.133511*x_max+(-0.0009851*x_max*x_max))*100
y_min=(-4.435431+0.133511*49+(-0.0009851*49*49))*100

x_avg=69.01936
y_avg=(-4.435431+0.133511*x_avg+(-0.0009851*x_avg*x_avg))*100

plt.plot(x, y, '-g', label='price premium',linewidth=3)
plt.title('The heterogeneity of price premium of adopting a heat pump',fontsize=18)
plt.xlabel('Environmental awareness', color='#1C2833',fontsize=18)
plt.ylabel('Price premium of heat pump (%)', color='#1C2833',fontsize=18)
plt.hlines(y_max,49,x_max,color='k', linestyle='--')
plt.vlines(x_max,y_min,y_max,color='k', linestyle='--')
plt.legend(loc='upper left')
plt.ylim(y_min, 15)
plt.xlim(49, 84)
plt.grid()
plt.show()


#%%
x = np.linspace(-1400,600,2500)
y = (0.0378975+(4.63*10**(-7)*x*x))*100

x_max=565
y_max=(0.0378975+(4.63*10**(-7)*x_max*x_max))*100


x_avg=-44.34618 
y_avg=(0.0378975+(4.63*10**(-7)*x_avg*x_avg))*100

plt.plot(x, y, '-g', label='price premium',linewidth=3)
plt.title('The heterogeneity of price premium of adopting a heat pump',fontsize=18)
plt.xlabel('Net social benefit (2010$/year)', color='#1C2833',fontsize=18)
plt.ylabel('Price premium of heat pump (%)', color='#1C2833',fontsize=18)
plt.hlines(y_avg,0,x_avg,color='k', linestyle='--')
plt.vlines(x_avg,0,y_avg,color='k', linestyle='--')
plt.legend(loc='upper left')
plt.grid()
plt.show()





