use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\housing changing feature test\treated and control_feature.dta"
xtset ImportParcelID timeid

foreach n in NoOfStories TotalRooms TotalBedrooms TotalCalculatedBathCount{
replace `n'=. if `n'==0
}

foreach n in NoOfStories TotalRooms TotalBedrooms TotalCalculatedBathCount{
gen `n'_diff=D.`n'
}

//1.number variable
//1.1 number of rooms
reg HP_diff NoOfStories_diff TotalRooms_diff TotalBedrooms_diff TotalCalculatedBathCount_diff
reg NoOfStories_diff HP_diff
reg TotalRooms_diff HP_diff
reg TotalBedrooms_diff HP_diff
reg TotalCalculatedBathCount_diff HP_diff

//1.2 Building Condition
reg Condition_diff HP_diff


//1.3 Building Quality
gen Quality=1 if BuildingQualityStndCode=="E-"
replace Quality=2 if BuildingQualityStndCode=="E"
replace Quality=3 if BuildingQualityStndCode=="E+"
replace Quality=4 if BuildingQualityStndCode=="D-"
replace Quality=5 if BuildingQualityStndCode=="D"
replace Quality=6 if BuildingQualityStndCode=="D+"
replace Quality=7 if BuildingQualityStndCode=="C-"
replace Quality=8 if BuildingQualityStndCode=="C"
replace Quality=9 if BuildingQualityStndCode=="C+"
replace Quality=10 if BuildingQualityStndCode=="B-"
replace Quality=11 if BuildingQualityStndCode=="B"
replace Quality=12 if BuildingQualityStndCode=="B+"
replace Quality=13 if BuildingQualityStndCode=="A-"
replace Quality=14 if BuildingQualityStndCode=="A"
replace Quality=15 if BuildingQualityStndCode=="A+"
xtset ImportParcelID timeid
gen Quality_diff=D.Quality
reg Quality_diff HP_diff




//code
//2.Roof Cover
gen RoofCover=1 if RoofCoverStndCode=="AL"
replace RoofCover=2 if RoofCoverStndCode=="AP"
replace RoofCover=3 if RoofCoverStndCode=="AS"
replace RoofCover=4 if RoofCoverStndCode=="BU"
replace RoofCover=5 if RoofCoverStndCode=="CN"
replace RoofCover=6 if RoofCoverStndCode=="CS"
replace RoofCover=7 if RoofCoverStndCode=="FG"
replace RoofCover=8 if RoofCoverStndCode=="ME"
replace RoofCover=9 if RoofCoverStndCode=="MS"
replace RoofCover=10 if RoofCoverStndCode=="OT"
replace RoofCover=11 if RoofCoverStndCode=="RC"
replace RoofCover=12 if RoofCoverStndCode=="SH"
replace RoofCover=13 if RoofCoverStndCode=="SL"
replace RoofCover=14 if RoofCoverStndCode=="ST"
replace RoofCover=15 if RoofCoverStndCode=="TG"
replace RoofCover=16 if RoofCoverStndCode=="TL"
replace RoofCover=17 if RoofCoverStndCode=="WD"
replace RoofCover=18 if RoofCoverStndCode=="WS"
replace RoofCover=19 if RoofCoverStndCode=="BR"
replace RoofCover=20 if RoofCoverStndCode=="GR"
replace RoofCover=21 if RoofCoverStndCode=="UR"
xtset ImportParcelID timeid
gen RoofCover_diff=D.RoofCover
gen RoofCover_change=0 if RoofCover_diff==0
replace RoofCover_change=1 if (RoofCover_diff!=0)&(RoofCover_diff!=.)
reg RoofCover_change HP_diff


//3. Roof Structure
gen RoofStructure=1 if RoofStructureTypeStndCode=="CNP"
replace RoofStructure=2 if RoofStructureTypeStndCode=="CNR"
replace RoofStructure=3 if RoofStructureTypeStndCode=="CTH"
replace RoofStructure=4 if RoofStructureTypeStndCode=="FLT"
replace RoofStructure=5 if RoofStructureTypeStndCode=="GBL"
replace RoofStructure=6 if RoofStructureTypeStndCode=="GHP"
replace RoofStructure=7 if RoofStructureTypeStndCode=="GMB"
replace RoofStructure=8 if RoofStructureTypeStndCode=="HIP"
replace RoofStructure=9 if RoofStructureTypeStndCode=="MAN"
replace RoofStructure=10 if RoofStructureTypeStndCode=="RFB"
replace RoofStructure=11 if RoofStructureTypeStndCode=="SFT"
replace RoofStructure=12 if RoofStructureTypeStndCode=="SHD"
replace RoofStructure=13 if RoofStructureTypeStndCode=="SWT"
replace RoofStructure=14 if RoofStructureTypeStndCode=="WDT"
replace RoofStructure=15 if RoofStructureTypeStndCode=="DOM"
replace RoofStructure=16 if RoofStructureTypeStndCode=="TRB"
xtset ImportParcelID timeid
gen RoofStructure_diff=D.RoofStructure
gen RoofStructure_change=0 if RoofStructure_diff==0
replace RoofStructure_change=1 if (RoofStructure_diff!=0)&(RoofStructure_diff!=.)
reg RoofStructure_change HP_diff
tab timeid,gen(timeid_)
foreach n in 2 3 4 5 6{
gen T_time`n'=treatment*timeid_`n'
}
gen T_time1=treatment*timeid_1
reg NoOfStories_diff T_time2 T_time3 T_time4 T_time5 T_time6
reg TotalRooms_diff T_time2 T_time3 T_time4 T_time5 T_time6
reg TotalBedrooms_diff T_time2 T_time3 T_time4 T_time5 T_time6
reg TotalCalculatedBathCount_diff T_time2 T_time3 T_time4 T_time5 T_time6



//balance
foreach n in NoOfStories TotalRooms TotalBedrooms TotalCalculatedBathCount BuildingCondition Quality{
reg `n' treatment control,noconstant
}
foreach n in NoOfStories TotalRooms TotalBedrooms TotalCalculatedBathCount BuildingCondition Quality{
ttest `n',by(treatment)
}

//hedonic mdoel
cd "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\housing changing feature test"
use "hedonic model.dta"
areg price_adjusted NoOfStories TotalRooms TotalBedrooms TotalCalculatedBathCount BuildingCondition area Pool goodview Remodel_Age Quality i.year,absorb(FIPS)

