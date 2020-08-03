clear all
cd "D:\Zillow data"
global dta1 "D:\Zillow data"

foreach m in AL AK AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
clear all
capture import delimited "$dta1\\Zillow data `m'\20180805\ZAsmt\BKManagedSpecific.txt", delimiter("|") clear
ren v1 RowID
ren v2 LotSizeUnit
ren v3 LotSizeorArea
ren v4 BKFSPID
ren v5 BKFSLoadDate
ren v6 FIPS
ren v7 BatchID
gen posX=strpos( LotSizeorArea,"X" )
gen posAC=strpos( LotSizeorArea,"AC" )
gen posSF=strpos( LotSizeorArea,"SF" )
drop if LotSizeUnit==""
gen posIRR=strpos( LotSizeorArea,"IRR" )
gen length=strlen( LotSizeorArea )
gen lotsize1=substr( LotSizeorArea ,1,length-3) if posSF!=0
destring lotsize1, generate (lotsize)
gen lotsize2=substr( LotSizeorArea ,1,length-3) if posAC!=0
gen lotsize4=regexr(lotsize2, "[^0-9.]+", "")
destring lotsize4, generate (lotsize3)
replace lotsize=lotsize3*43560 if posAC!=0
gen lotsizeX1=substr(LotSizeorArea ,1,posX-1) if (posX!=0)&(posIRR==0)
gen lotsizeX2=substr(LotSizeorArea ,posX+1,length-posX) if (posX!=0)&(posIRR==0)
destring lotsizeX1,replace
destring lotsizeX2,replace
replace lotsize=lotsizeX1*lotsizeX2 if (posX!=0)&(posIRR==0)&(LotSizeUnit=="SF")
replace lotsize=lotsizeX1*lotsizeX2*43560 if (posX!=0)&(posIRR==0)&(LotSizeUnit=="AC")
gen lotsizeX3=substr(LotSizeorArea ,1,posX-1) if (posX!=0)&(posIRR!=0)
gen lotsizeX4=substr(LotSizeorArea ,posX+1,length-posX-3) if (posX!=0)&(posIRR!=0)
destring lotsizeX3,replace
destring lotsizeX4,replace
replace lotsize=lotsizeX3*lotsizeX4 if (posX!=0)&(posIRR!=0)&(LotSizeUnit=="SF")
replace lotsize=lotsizeX3*lotsizeX4*43560 if (posX!=0)&(posIRR!=0)&(LotSizeUnit=="AC")
sort RowID
merge 1:1 RowID using "$dta1\\Zillow data `m'\20180805\ZAsmt\Row ID ImportParcelID.dta"
order ImportParcelID
sort ImportParcelID
drop _merge
save "C:\Users\wills\Documents\data\Analysis\lotsize\lotsize `m'20180805.dta",replace
}




