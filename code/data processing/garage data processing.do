clear all
cd "D:\Zillow data"
global dta1 "C:\Users\wills\Documents\data\Analysis\Value"
global dta2 "D:\Zillow data"

foreach m in AL AK AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
foreach n in 20160322 20170203 20170731 20171102 20180107 20180805 {
capture import delimited "D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Garage.txt", delimiter("|") clear
ren v1 RowID
ren v2 BuildingOrImprovementNumber
ren v3 GarageSequenceNumber
ren v4 GarageStndCode
ren v5 GarageAreaSqFt
ren v6 GarageNoOfCars
ren v7 FIPS
ren v8 BatchID
sort RowID
merge m:1 RowID using"D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Row ID ImportParcelID.dta"
drop _merge
order ImportParcelID
sort ImportParcelID
save "C:\Users\wills\Documents\data\Analysis\Garage\garage with ImportParcelID `m'`n'.dta",replace
}
}

foreach m in AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
foreach n in 20180805 {
use "C:\Users\wills\Documents\data\Analysis\Garage\garage with ImportParcelID `m'`n'.dta"
bysort ImportParcelID: egen garage_area=total(GarageAreaSqFt)
keep if GarageSequenceNumber==0
keep ImportParcelID garage_area
save "C:\Users\wills\Documents\data\Analysis\Garage\garage area `m'`n'.dta",replace
}
}
