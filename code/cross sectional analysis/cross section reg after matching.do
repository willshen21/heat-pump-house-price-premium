//1. national cross sectional analysis after matching
set matsize 11000
use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]


//2. cross sectional regression by census divisions
use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="ME"|state=="VT"|state=="NH"|state=="MA"|state=="RI"|state=="CT"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="NJ"|state=="NY"|state=="PA"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="IL"|state=="IN"|state=="MI"|state=="OH"|state=="WI"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="IA"|state=="KS"|state=="MN"|state=="MO"|state=="NE"|state=="ND"|state=="SD" 
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="DE"|state=="DC"|state=="FL"|state=="GA"|state=="MD"|state=="NC"|state=="SC"|state=="VA"|state=="WV"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="AL"|state=="KY"|state=="MS"|state=="TN"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="AR"|state=="LA"|state=="OK"|state=="TX"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="AZ"|state=="NM"|state=="CO"|state=="UT"|state=="WY"|state=="ID"|state=="MT"|state=="NV"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]

use "C:\Desktop\Heat Pump\Data-Post-treatment\matched data.dta",clear
keep if state=="AK"|state=="CA"|state=="HI"|state=="OR"|state=="WA"
reg logprice_adjusted treatment yearbuilt-landassessedvalue_persqft i.year i.city_id [iweight=weight]
