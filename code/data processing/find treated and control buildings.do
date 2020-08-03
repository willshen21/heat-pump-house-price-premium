clear all
cd "C:\Users\wills\Documents\data"
global dta1 "C:\Users\wills\Documents\data\Zillow data"


foreach n in 20160322 20170203 20170731 20171102 20180107 20180805 {
capture import delimited "$dta1\\`n'\ZAsmt\main.txt", delimiter("|") clear
ren v1 RowID
ren v2 ImportParcelID
keep RowID ImportParcelID
sort RowID
save "$dta1\\`n'\ZAsmt\Row ID ImportParcelID.dta",replace

capture import delimited "$dta1\\`n'\ZAsmt\building.txt", delimiter("|") clear
//rename variable names
ren v1 RowID
ren v2 NoOfUnits
ren v3 OccupancyStatusStndCode
ren v4 PropertyCountyLandUseDescription
ren v5 PropertyCountyLandUseCode
ren v6 PropertyLandUseStndCode
ren v7 PropertyStateLandUseDescription
ren v8 PropertyStateLandUseCode
ren v9 BuildingOrImprovementNumber
ren v10 BuildingClassStndCode
ren v11 BuildingQualityStndCode
ren v12 BuildingQualityStndCodeOriginal
ren v13 BuildingConditionStndCode
ren v14 ArchitecturalStyleStndCode
ren v15 YearBuilt
ren v16 EffectiveYearBuilt
ren v17 YearRemodeled
ren v18 NoOfStories
ren v19 TotalRooms
ren v20 TotalBedrooms
ren v21 TotalKitchens
ren v22 FullBath
ren v23 ThreeQuarterBath
ren v24 HalfBath
ren v25 QuarterBath
ren v26 TotalCalculatedBathCount
ren v27 TotalActualBathCount
ren v28 BathSourceStndCode
ren v29 TotalBathPlumbingFixtures
ren v30 RoofCoverStndCode
ren v31 RoofStructureTypeStndCode
ren v32 HeatingTypeorSystemStndCode
ren v33 AirConditioningStndCode
ren v34 FoundationTypeStndCode
ren v35 ElevatorStndCode
ren v36 FireplaceFlag
ren v37 FirePlaceTypeStndCode
ren v38 FireplaceNumber
ren v39 WaterStndCode
ren v40 SewerStndCode
ren v41 MortgageLenderName
ren v42 TimeshareStndCode
ren v43 Comments
ren v44 LoadID
ren v45 StoryTypeStndCode
ren v46 FIPS
ren v47 BatchID
save "$dta1\\`n'\ZAsmt\building.dta",replace
keep RowID HeatingTypeorSystemStndCode
sort RowID
merge 1:1 RowID using"$dta1\\`n'\ZAsmt\Row ID ImportParcelID.dta"
drop _merge
save "$dta1\\`n'\ZAsmt\heating with RowID ImportParcelID.dta",replace
}

clear all
foreach n in 20160322 20170203 20170731 20171102 20180107 20180805 {
use "$dta1\\`n'\ZAsmt\heating with RowID ImportParcelID.dta"
drop RowID
order ImportParcelID
sort ImportParcelID
ren HeatingTypeorSystemStndCode Heating`n'
save "$dta1\\`n'\ZAsmt\heating with ImportParcelID.dta",replace
}

//putting all the years of heating type together
foreach n in 20160322 20170203 20170731 20171102 20180107 {
merge 1:1 ImportParcelID using "$dta1\\`n'\ZAsmt\heating with ImportParcelID.dta"
drop _merge
}
save "$dta1\\heating change.dta",replace

//to find new installment of HP
keep if Heating20180805 =="HP"| Heating20180107=="HP"| Heating20171102=="HP"| Heating20170731=="HP"| Heating20170203=="HP"| Heating20160322=="HP"
keep if (Heating20180805!= Heating20180107 & Heating20180805=="HP")|( Heating20180107!= Heating20171102& Heating20180107=="HP")|(Heating20171102!= Heating20170731& Heating20171102=="HP")|( Heating20170731!= Heating20170203& Heating20170731=="HP")| (Heating20170203!= Heating20160322& Heating20170203=="HP")
order Heating20160322 Heating20170203 Heating20170731 Heating20171102 Heating20180107 Heating20180805
//gen variable aftertime beforetime
gen aftertime= "2018-08-05" if Heating20180805!= Heating20180107 & Heating20180805=="HP"
replace aftertime="2018-01-07" if Heating20180107!= Heating20171102&Heating20180107=="HP"
replace aftertime="2017-11-02" if Heating20171102!= Heating20170731&Heating20171102=="HP"
replace aftertime="2017-07-31" if Heating20170731!= Heating20170203&Heating20170731=="HP"
replace aftertime="2017-02-03" if Heating20170203!= Heating20160322&Heating20170203=="HP"
destring aftertime,replace
gen beforetime= "2018-01-07" if Heating20180805!= Heating20180107 & Heating20180805=="HP"
replace beforetime="2017-11-02" if Heating20180107!= Heating20171102&Heating20180107=="HP"
replace beforetime="2017-07-31" if Heating20171102!= Heating20170731&Heating20171102=="HP"
replace beforetime="2017-02-03" if Heating20170731!= Heating20170203&Heating20170731=="HP"
replace beforetime="2016-03-22" if Heating20170203!= Heating20160322&Heating20170203=="HP"
destring beforetime,replace
order ImportParcelID aftertime beforetime Heating20160322 Heating20170203 Heating20170731 Heating20171102 Heating20180107 Heating20180805
sort ImportParcelID
save "$dta1\\HP new installment time.dta",replace

//to find treatment group
capture import delimited "$dta1\\20180805\ZAsmt\SaleData.txt", delimiter("|") clear
//rename variable name
ren v1 RowID
ren v2 SaleSeqNum
ren v3 SellerFullName
ren v4 BuyerFullName
ren v5 RecordingDate
ren v6 DocumentDate
ren v7 RecordingDocumentNumber
ren v8 RecordingBookNumber
ren v9 RecordingPageNumber
ren v10 DocumentTypeCountyDescription
ren v11 DocumentTypeStndCode
ren v12 SalesPriceAmount
ren v13 SalesPriceAmountStndCode
ren v14 FIPS
ren v15 BatchID
sort RowID
merge m:1 RowID using"$dta1\\20180805\ZAsmt\Row ID ImportParcelID.dta"
order ImportParcelID
sort ImportParcelID
save "$dta1\\saledata with importparcelID.dta",replace
drop if SaleSeqNum==.
drop _merge
merge m:1 ImportParcelID using "$dta1\\HP new installment time.dta"
keep if _merge==3
keep if (SaleSeqNum==1 & RecordingDate>aftertime)|(SaleSeqNum==2 &RecordingDate<beforetime)
order ImportParcelID SaleSeqNum RecordingDate aftertime beforetime SalesPriceAmount
drop if SalesPriceAmount==.
drop if SalesPriceAmount==0
duplicates t ImportParcelID ,g(tag)
drop if tag==0
save "$dta1\\treatment group.dta",replace

clear all
// to find control group of FA
use "$dta1\\heating change.dta" 
keep if Heating20180805=="FA"& Heating20160322=="FA"& Heating20170203=="FA"& Heating20170731=="FA"& Heating20171102=="FA"& Heating20180107=="FA"
sort ImportParcelID
save "$dta1\\houses with FA all the time.dta",replace
clear all
use "$dta1\\saledata with importparcelID.dta"
drop if SaleSeqNum==.
drop _merge
merge m:1 ImportParcelID using "$dta1\\houses with FA all the time.dta"
keep if _merge==3
order ImportParcelID SaleSeqNum RecordingDate SalesPriceAmount
drop if SalesPriceAmount==.
duplicates t ImportParcelID ,g(tag)
drop if tag==0
save "$dta1\\control group.dta",replace

clear all
//extract info from the tran data
capture import delimited "$dta1\\20180805\\ZTrans\PropertyInfo.txt", delimiter("|") clear
ren v1 TransId
ren v17 PropertyCity
ren v18 PropertyState
ren v19 PropertyZip
ren v20 PropertyZip4
ren v65 ImportParcelID
keep TransId PropertyCity PropertyState PropertyZip PropertyZip4 ImportParcelID
sort TransId
save "$dta1\\ZTrans TransId ImportParcelID.dta",replace
clear all
import delimited "$dta1\\20180805\ZTrans\Main.txt", delimiter("|")
ren v1 TransId
ren v7 RecordingDate
ren v25 SalesPriceAmount
keep TransId RecordingDate SalesPriceAmount
sort TransId
merge m:m TransId using "$dta1\ZTrans TransId ImportParcelID.dta"
drop if ImportParcelID==.
sort ImportParcelID
drop if SalesPriceAmount==.
drop if SalesPriceAmount==0
duplicates t ImportParcelID ,g(tag)
drop if tag==0
sort ImportParcelID RecordingDate
bysort ImportParcelID : generate dateid=_n
save "$dta1\\ZTrans sale with dates.dta",replace
drop _merge
merge m:1 ImportParcelID using "$dta1\\HP new installment time.dta"
keep if _merge==3
keep if (dateid==1 & RecordingDate<beforetime)|(dateid!=1 &RecordingDate>aftertime)
drop tag
duplicates t ImportParcelID ,g(tag)
drop if tag==0
order ImportParcelID dateid RecordingDate aftertime beforetime
save "$dta1\\ZTrans treatment group.dta",replace


