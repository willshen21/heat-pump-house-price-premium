clear all
cd "D:\Zillow data"
global dta1 "C:\Users\wills\Documents\data\Analysis\Value"
global dta2 "D:\Zillow data"

foreach m in AL AK AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY{
foreach n in 20160322 20170203 20170731 20171102 20180107 20180805 {
capture import delimited "D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Value.txt", delimiter("|") clear
ren v1 RowID
ren v2 LandAssessedValue
ren v3 ImprovementAssessedValue
ren v4 TotalAssessedValue
ren v5 AssessmentYear
ren v6 LandMarketValue
ren v7 ImprovementMarketValue
ren v8 TotalMarketValue
ren v9 MarketValueYear
ren v10 LandAppraisalValue
ren v11 ImprovementAppraisalValue
ren v12 TotalAppraisalValue
ren v13 AppraisalValueYear
ren v14 FIPS
ren v15 BatchID
sort RowID
merge 1:1 RowID using"D:\Zillow data\Zillow data `m'\\`n'\ZAsmt\Row ID ImportParcelID.dta"
drop _merge
order ImportParcelID
sort ImportParcelID
save "C:\Users\wills\Documents\data\Analysis\Value\value with ImportParcelID `m'`n'.dta",replace
}
}

