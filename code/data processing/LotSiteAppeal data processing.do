clear all
cd "D:\Zillow data"
global dta1 "C:\Users\wills\Documents\data\Analysis\Value"
global dta2 "D:\Zillow data"

foreach m in AL AK AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
foreach n in 20180805 {
capture import delimited "D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\LotSiteAppeal.txt", delimiter("|") clear
ren v1 RowID
ren v2 LotSiteAppealStndCode
ren v3 FIPS
ren v4 BatchID
sort RowID
merge m:1 RowID using"D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Row ID ImportParcelID.dta"
drop _merge
order ImportParcelID
sort ImportParcelID
save "C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID `m'`n'.dta",replace
}
}

foreach m in AL AK AR AZ CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI{
use "C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID `m'20180805.dta"
drop if LotSiteAppealStndCode==""
keep ImportParcelID LotSiteAppealStndCode
save "C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID `m'20180805.dta",replace
}

foreach m in AK AR AZ CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI{
use "C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID all.dta"
merge m:m ImportParcelID using"C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID `m'20180805.dta"
drop _merge
save "C:\Users\wills\Documents\data\Analysis\LotSiteAppeal\LotSiteAppeal with ImportParcelID all.dta",replace
}


gen goodview=1 if LotSiteAppealStndCode=="AIR"|LotSiteAppealStndCode=="FWY"|LotSiteAppealStndCode=="GBL"|LotSiteAppealStndCode=="GLF"|LotSiteAppealStndCode=="HST"|LotSiteAppealStndCode=="OMS"|LotSiteAppealStndCode=="SCH"|LotSiteAppealStndCode=="VWL"|LotSiteAppealStndCode=="VWM"|LotSiteAppealStndCode=="VWO"|LotSiteAppealStndCode=="VWR"|LotSiteAppealStndCode=="WFB"|LotSiteAppealStndCode=="WFC"|LotSiteAppealStndCode=="WFS"
