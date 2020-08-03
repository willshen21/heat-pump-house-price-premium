//1. only 2 periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-2 periods.dta" 
tab FIPS,gen(county)
foreach n of numlist 1/306{
gen county`n'_T=county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year2=n_year*n_year
foreach n of numlist 1/306{
gen county`n'_T2=county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 i.monthfixed,fe vce(cluster ImportParcelID)


gen n_year3=n_year2*n_year
foreach n of numlist 1/306{
gen county`n'_T3=county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 county1_T3-county306_T3 i.monthfixed,fe vce(cluster ImportParcelID)






//2. n periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-n periods.dta",clear 
tab FIPS,gen(county)
foreach n of numlist 1/306{
gen county`n'_T=county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T i.monthfixed,fe vce(cluster ImportParcelID)


gen n_year2=n_year*n_year
foreach n of numlist 1/306{
gen county`n'_T2=county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year3=n_year2*n_year
foreach n of numlist 1/306{
gen county`n'_T3=county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 county1_T3-county306_T3 i.monthfixed,fe vce(cluster ImportParcelID)


