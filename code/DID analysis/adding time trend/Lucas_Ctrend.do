set maxvar 32767
set matsize 11000
use "treatment and mixed control group-same county-drop remodel after 2000-n periods-drop EL-Remodel_AGE.dta",clear 
xtreg logprice_adjusted D Remodel_Age i.county_year i.monthfixed L_trend Q_trend C_trend,fe vce(cluster ImportParcelID)
