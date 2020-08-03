set maxvar 32767
set matsize 11000
use "treatment and mixed control group-n periods.dta",clear 
xtreg logprice_adjusted D Remodel_Age i.county_year i.monthfixed L_trend ,fe vce(cluster ImportParcelID)
