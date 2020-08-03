//1. only 2 periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-only 2 periods.dta" 
egen group_county=group(treatment FIPS)
tab group_county,gen(group_county)
foreach n of numlist 1/579{
gen group_county`n'_T=group_county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year2=n_year*n_year
foreach n of numlist 1/579{
gen group_county`n'_T2=group_county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year3=n_year2*n_year
foreach n of numlist 1/579{
gen group_county`n'_T3=group_county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 group_county1_T3-group_county579_T3 i.monthfixed,fe vce(cluster ImportParcelID)










//2. n periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-n periods.dta" 
egen group_county=group(treatment FIPS)
tab group_county,gen(group_county)
foreach n of numlist 1/579{
gen group_county`n'_T=group_county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year2=n_year*n_year
foreach n of numlist 1/579{
gen group_county`n'_T2=group_county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 i.monthfixed,fe vce(cluster ImportParcelID)



gen n_year3=n_year2*n_year
foreach n of numlist 1/579{
gen group_county`n'_T3=group_county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 group_county1_T3-group_county579_T3 i.monthfixed,fe vce(cluster ImportParcelID)




	  
	  
