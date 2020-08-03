clear all
cd "D:\Zillow data"
global dta1 "C:\Users\wills\Documents\data\Analysis\Value"
global dta2 "D:\Zillow data"

foreach m in AL AK AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
foreach n in 20160322 20170203 20170731 20171102 20180107 20180805 {
capture import delimited "D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Pool.txt", delimiter("|") clear
ren v1 RowID
ren v2 BuildingOrImprovementNumber
ren v3 PoolStndCode
ren v4 PoolSize
ren v5 FIPS
ren v6 BatchID
sort RowID
merge m:1 RowID using"D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Row ID ImportParcelID.dta"
drop _merge
order ImportParcelID
sort ImportParcelID
save "C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID `m'`n'.dta",replace
}
}


foreach m in AL AK AR AZ CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
use "C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID `m'20180805.dta"
drop PoolSize
save "C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID `m'20180805.dta",replace
}

foreach m in AK AR AZ CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
use "C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID all.dta"
merge m:m ImportParcelID using"C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID `m'20180805.dta"
drop _merge
save "C:\Users\wills\Documents\data\Analysis\Pool\pool with ImportParcelID all.dta",replace
}
