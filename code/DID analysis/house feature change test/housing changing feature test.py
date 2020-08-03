# -*- coding: utf-8 -*-
"""
Created on Tue Feb 25 19:43:42 2020

@author: wills
"""

#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/National/housing changing feature test/')
import pandas as pd
import numpy as np

#%%
treated=pd.read_stata('treated houses.dta')

states_in_drive=treated.state.value_counts().reset_index()
states_in_drive=states_in_drive['index']
time=['20160322','20170203','20170731','20171102','20180107','20180805']

#%%

treated_feature=pd.DataFrame(columns = None)

for i in time:
    for j in states_in_drive:
        building = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Building.txt',
                               sep="|",usecols=[0,10,12,13,14,16,17,18,19,20,25,29,30,31,32],header=None,
                               dtype={10:'object',12:'object',13:'object',29:'object',30:'object',31:'object',32:'object'})
        building.rename(columns={0:'RowID',10:'BuildingQualityStndCode',12:'BuildingConditionStndCode',13:'ArchitecturalStyleStndCode',
                                 14:'YearBuilt',16:'YearRemodeled',17:'NoOfStories',18:'TotalRooms',
                                 19:'TotalBedrooms',20:'TotalKitchens',25:'TotalCalculatedBathCount',
                                 29:'RoofCoverStndCode',30:'RoofStructureTypeStndCode',
                                 31:'HeatingTypeorSystemStndCode',32:'AirConditioningType'}, inplace=True)
        RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
        building=pd.merge(building,RowIDImportParcelID, on=['RowID'],how='left')
        feature=pd.merge(treated,building,on=['ImportParcelID'],how='inner')
        feature['time']=i
        treated_feature=pd.concat([treated_feature,feature],sort=False)
      
        
treated_feature.to_stata('treated_feature.dta')




#%% for control houses
control=pd.read_stata('control houses.dta')

states_in_drive=control.state.value_counts().reset_index()
states_in_drive=states_in_drive['index']
time=['20160322','20170203','20170731','20171102','20180107','20180805']
#%%
control_feature=pd.DataFrame(columns = None)

for i in time:
    for j in states_in_drive:
        building = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Building.txt',
                               sep="|",usecols=[0,10,12,13,14,16,17,18,19,20,25,29,30,31,32],header=None,
                               dtype={10:'object',12:'object',13:'object',29:'object',30:'object',31:'object',32:'object'})
        building.rename(columns={0:'RowID',10:'BuildingQualityStndCode',12:'BuildingConditionStndCode',13:'ArchitecturalStyleStndCode',
                                 14:'YearBuilt',16:'YearRemodeled',17:'NoOfStories',18:'TotalRooms',
                                 19:'TotalBedrooms',20:'TotalKitchens',25:'TotalCalculatedBathCount',
                                 29:'RoofCoverStndCode',30:'RoofStructureTypeStndCode',
                                 31:'HeatingTypeorSystemStndCode',32:'AirConditioningType'}, inplace=True)
        RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
        building=pd.merge(building,RowIDImportParcelID, on=['RowID'],how='left')
        feature=pd.merge(control,building,on=['ImportParcelID'],how='inner')
        feature['time']=i
        control_feature=pd.concat([control_feature,feature],sort=False)
      
        
control_feature.to_stata('control_feature.dta')




#%% 6/8/2020 2nd R&R adding more building features
#%% To start
import os
os.chdir('C:/Users/wills/Desktop/Heat Pump Paper/Data/National/housing changing feature test/')
import pandas as pd
import numpy as np

#%%
treatedcontrol=pd.read_stata('treated and control houses.dta')

states_in_drive=treatedcontrol.state.value_counts().reset_index()
states_in_drive=states_in_drive['index']
time=['20160322','20170203','20170731','20171102','20180107','20180805']

#%%  ExteriorWall
AllEwall=pd.DataFrame(columns = None)

for i in time:
    for j in states_in_drive:
        ExteriorWall = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/ExteriorWall.txt',
                               sep="|",usecols=[0,2],header=None,
                               dtype={2:'object'})
        ExteriorWall.rename(columns={0:'RowID',2:'ExteriorWallStndCode'}, inplace=True)
        RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
        ExteriorWall=pd.merge(ExteriorWall,RowIDImportParcelID, on=['RowID'],how='left')
        Ewall=pd.merge(treatedcontrol,ExteriorWall,on=['ImportParcelID'],how='inner')
        Ewall['time']=i
        AllEwall=pd.concat([AllEwall,Ewall],sort=False)
      
        
AllEwall.to_stata('Ewall.dta')

#%% Garage No of cars
AllGarage=pd.DataFrame(columns = None)

for i in time:
    for j in states_in_drive:
        Garage = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Garage.txt',
                               sep="|",usecols=[0,5],header=None)
        Garage.rename(columns={0:'RowID',5:'GarageNoOfCars'}, inplace=True)
        Garage['GarageNoOfCars']=Garage['GarageNoOfCars'].astype(float)
        RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
        Garage=pd.merge(Garage,RowIDImportParcelID, on=['RowID'],how='left')
        Garage=Garage[['ImportParcelID','GarageNoOfCars']]
        Garage=Garage.groupby(['ImportParcelID'])['GarageNoOfCars'].sum().reset_index()
        Garage2=pd.merge(treatedcontrol,Garage,on=['ImportParcelID'],how='inner')
        Garage2['time']=i
        AllGarage=pd.concat([AllGarage,Garage2],sort=False)
      
        
AllGarage.to_stata('Garage.dta')

#%%Pool
AllPool=pd.DataFrame(columns = None)

for i in time:
    for j in states_in_drive:
        Pool = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Pool.txt',
                               sep="|",usecols=[0,2],header=None,
                               dtype={2:'object'})
        Pool.rename(columns={0:'RowID',2:'PoolStndCode'}, inplace=True)
        Pool=Pool[Pool['PoolStndCode']!='SHO']
        Pool=Pool[Pool['PoolStndCode']!='CMP']
        RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
        Pool=pd.merge(Pool,RowIDImportParcelID, on=['RowID'],how='left')
        Pool=Pool[['ImportParcelID','PoolStndCode']]
        Pool=Pool.groupby('ImportParcelID').first().reset_index()
        Pool2=pd.merge(treatedcontrol,Pool,on=['ImportParcelID'],how='inner')
        Pool2['time']=i
        AllPool=pd.concat([AllPool,Pool2],sort=False)
      
        
AllPool.to_stata('Pool.dta')


#%%  InteriorWall
AllIwall=pd.DataFrame(columns = None)
for i in time:
    for j in states_in_drive:
        try:
            InteriorWall = pd.read_csv('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/InteriorWall.txt',
                                   sep="|",usecols=[0,2],header=None,
                                   dtype={2:'object'})
            InteriorWall.rename(columns={0:'RowID',2:'InteriorWallStndCode'}, inplace=True)
            RowIDImportParcelID=pd.read_stata('E:/Backup data/Zillow data '+j+'/'+i+'/ZAsmt/Row ID ImportParcelID.dta')
            InteriorWall=pd.merge(InteriorWall,RowIDImportParcelID, on=['RowID'],how='left')
            Iwall=pd.merge(treatedcontrol,InteriorWall,on=['ImportParcelID'],how='inner')
            Iwall['time']=i
            AllIwall=pd.concat([AllIwall,Iwall],sort=False)
        except:
            pass
      
        
AllIwall.to_stata('Iwall.dta')

