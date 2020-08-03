clear all
use "C:\Users\wills\Documents\data\Zillow data AZ\ZTrans sale with dates.dta"
drop _merge
merge m:1 ImportParcelID using "C:\Users\wills\Documents\data\Zillow data AZ\HP new installment time.dta"
keep if _merge==3
keep if RecordingDate>aftertime
order ImportParcelID dateid RecordingDate aftertime beforetime
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\AZ ZTrans treatment group.dta",replace

clear all
use "C:\Users\wills\Documents\data\Zillow data AZ\saledata with importparcelID.dta"
drop _merge
merge m:1 ImportParcelID using "C:\Users\wills\Documents\data\Zillow data AZ\HP new installment time.dta"
keep if _merge==3
keep if RecordingDate>aftertime
order ImportParcelID SaleSeqNum RecordingDate aftertime beforetime SalesPriceAmount
drop if SalesPriceAmount==.
drop if SalesPriceAmount==0
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\AZ treatment group.dta",replace


AK AL AR AZ CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TX UT VT VA WA WV WI WY



foreach m in AK AL AR CO CT DE DC GA ID IL IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD UT VA WA WV WI WY{
clear all
use "D:\Zillow data\Zillow data `m'\ZTrans sale with dates.dta"
drop _merge
merge m:1 ImportParcelID using "D:\Zillow data\Zillow data `m'\HP new installment time.dta"
keep if _merge==3
keep if RecordingDate>aftertime
order ImportParcelID dateid RecordingDate aftertime beforetime
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta",replace
}

foreach m in AL AR CA CO CT DE DC FL GA ID IL IN IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD TX UT VA WA WV WI WY{
clear all
use "D:\Zillow data\Zillow data `m'\saledata with importparcelID.dta"
drop _merge
merge m:1 ImportParcelID using "D:\Zillow data\Zillow data `m'\HP new installment time.dta"
keep if _merge==3
keep if RecordingDate>aftertime
order ImportParcelID SaleSeqNum RecordingDate aftertime beforetime SalesPriceAmount
drop if SalesPriceAmount==.
drop if SalesPriceAmount==0
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' treatment group.dta",replace
}

// Trans
foreach m in AZ AK AL AR CO CT DE DC GA ID IL IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD UT VA WA WV WI WY{
use "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta"
gen state="`m'"
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta",replace
}

foreach m in AZ AK AL AR CO CT DE DC GA ID IL IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD UT VA WA WV WI WY{
clear all
use "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta"
keep ImportParcelID dateid RecordingDate aftertime beforetime SalesPriceAmount Heating20160322 Heating20170203 Heating20170731 Heating20171102 Heating20180107 Heating20180805 state
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta",replace
}

foreach m in AK AL AR CO CT DE DC GA ID IL IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD UT VA WA WV WI WY{
clear all
use "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\ZTrans treatment group.dta"
merge m:m ImportParcelID using"C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' ZTrans treatment group.dta"
drop _merge
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\ZTrans treatment group.dta",replace
}

//sales
foreach m in AZ AL AR CA CO CT DE DC FL GA ID IL IN IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD TX UT VA WA WV WI WY{
clear all
use "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' treatment group.dta"
gen state="`m'"
keep ImportParcelID SaleSeqNum RecordingDate aftertime beforetime SalesPriceAmount Heating20160322 Heating20170203 Heating20170731 Heating20171102 Heating20180107 Heating20180805 state
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' treatment group.dta",replace
}

foreach m in AL AR CA CO CT DE DC FL GA ID IL IN IA KS KY LA ME MD MA MI MN MS MT MO NE NV NH NM NC ND OH OK OR PA RI SC SD TX UT VA WA WV WI WY{
clear all
use "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\treatment group.dta"
merge m:m ImportParcelID using"C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\\`m' treatment group.dta"
drop _merge
save "C:\Users\wills\Documents\data\Analysis\recent HP homes were sold\treatment group.dta",replace
}


duplicates t ImportParcelID ,g(tag)
tab tag
bysort ImportParcelID: gen n=_n
keep if n==1
drop n
bysort state:gen n=_n
tab state
