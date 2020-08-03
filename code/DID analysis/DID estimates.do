//1. National DID estimate
use "national DID.dta",clear
xtreg logprice_adjusted D Remodel_Age i.county_year i.monthfixed,fe vce(cluster ImportParcelID)

//2. Pacific DID estimate
use "Pacific DID.dta",clear
xtreg logprice_adjusted D Remodel_Age i.county_year i.monthfixed,fe vce(cluster ImportParcelID)

//3. South Atlantic DID estimate
use "South Atlantic DID.dta",clear
xtreg logprice_adjusted D Remodel_Age i.county_year i.monthfixed,fe vce(cluster ImportParcelID)
