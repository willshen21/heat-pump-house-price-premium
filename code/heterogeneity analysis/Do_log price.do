// for happening opinion
xtplfc logprice_adjusted Remodel_Age IncomePC_county PopulationDensity_CountyAnnually fed_fund_rate Residential_Elec_Price NaturalGasPrice i.year i.monthfixed,zvars(D) uvars(happening)

use "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\data for xtplfc.dta"
//incomePC_county
xtplfc logprice_adjusted Remodel_Age income_c_adjusted PopulationDensity_CountyAnnually fed_fund_rate Residential_Elec_Price NaturalGasPrice yearfixed1-monthfixed12 ,zvars(D) uvars(income_c_adjusted) gen(coef)
bysort income_c_adjusted:gen n=_n
keep if n==1
gen h95ci= coef_1 +1.96*coef_1_sd
gen l95ci= coef_1 -1.96*coef_1_sd
save "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\xtplfc result2-incomePC county.dta",replace
keep if income_c_adjusted<85000
keep if income_c_adjusted>29000
twoway line h95ci income_c_adjusted, lpattern(dash) lcolor(grey) ||line l95ci income_c_adjusted, lpattern(dash) lcolor(grey) ||line coef_1 income_c_adjusted, lpattern(solid) lcolor(blue)
graph export "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\Graph2.png", as(png) replace

//HP density
xtplfc logprice_adjusted Remodel_Age IncomePC_county PopulationDensity_CountyAnnually fed_fund_rate Residential_Elec_Price NaturalGasPrice yearfixed1-monthfixed12 ,zvars(D) uvars(HPbyPop) gen(coef)
bysort HPbyPop:gen n=_n
keep if n==1
gen h95ci= coef_1 +1.96*coef_1_sd
gen l95ci= coef_1 -1.96*coef_1_sd
save "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\xtplfc result4-HPbyPOP.dta"
keep if HPbyPop<300000
gen HPbyPop_PC=HPbyPop/1000000
twoway line h95ci HPbyPop_PC, lpattern(dash) lcolor(grey) ||line l95ci HPbyPop_PC, lpattern(dash) lcolor(grey) ||line coef_1 HPbyPop_PC, lpattern(solid) lcolor(blue)
graph export "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\Graph4.png", as(png) replace

//HDD
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\data for xtplfc-with HDD CDD.dta"
xtplfc logprice_adjusted Remodel_Age IncomePC_county PopulationDensity_CountyAnnually fed_fund_rate Residential_Elec_Price NaturalGasPrice yearfixed1-monthfixed12 ,zvars(D) uvars( htdd60 ) gen(coef)
bysort htdd60:gen n=_n
keep if n==1
gen h95ci= coef_1 +1.96*coef_1_sd
gen l95ci= coef_1 -1.96*coef_1_sd
save "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\xtplfc result5-htdd60.dta"
keep if htdd60<5645
twoway line h95ci htdd60, lpattern(dash) lcolor(grey) ||line l95ci htdd60, lpattern(dash) lcolor(grey) ||line coef_1 htdd60, lpattern(solid) lcolor(blue)
graph export "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\Graph5.png", as(png) replace

//CDD
xtplfc logprice_adjusted Remodel_Age IncomePC_county PopulationDensity_CountyAnnually fed_fund_rate Residential_Elec_Price NaturalGasPrice yearfixed1-monthfixed12 ,zvars(D) uvars( cldd60 ) gen(coef)
bysort cldd60:gen n=_n
keep if n==1
gen h95ci= coef_1 +1.96*coef_1_sd
gen l95ci= coef_1 -1.96*coef_1_sd
save "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\xtplfc result6-cldd60.dta"
keep if cldd60<4656
twoway line h95ci cldd60, lpattern(dash) lcolor(grey) ||line l95ci cldd60, lpattern(dash) lcolor(grey) ||line coef_1 cldd60, lpattern(solid) lcolor(blue)
graph export "C:\Users\wills\Desktop\Heat Pump Paper\Data\IF on premium\Graph6.png", as(png) replace














