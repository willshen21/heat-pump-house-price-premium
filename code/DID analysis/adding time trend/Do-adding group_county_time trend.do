//1. only 2 periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-same county-drop remodel after 2000-only 2 periods-drop EL-Remodel_AGE.dta" 
egen group_county=group(treatment FIPS)
tab group_county,gen(group_county)
foreach n of numlist 1/579{
gen group_county`n'_T=group_county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T i.monthfixed,fe vce(cluster ImportParcelID)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    853,142
Group variable: ImportParc~D                    Number of groups  =    440,764

R-sq:                                           Obs per group:
     within  = 0.0165                                         min =          1
     between = 0.0036                                         avg =        1.9
     overall = 0.0038                                         max =          2

                                                F(513,440763)     =          .
corr(u_i, Xb)  = -0.0921                        Prob > F          =          .

                        (Std. Err. adjusted for 440,764 clusters in ImportParcelID)
-----------------------------------------------------------------------------------
                  |               Robust
logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
                D |    .192732    .010602    18.18   0.000     .1719524    .2135116
      Remodel_Age |  -.0022101   .0003779    -5.85   0.000    -.0029507   -.0014695
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year2=n_year*n_year
foreach n of numlist 1/579{
gen group_county`n'_T2=group_county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 i.monthfixed,fe vce(cluster ImportParcelID)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    853,142
Group variable: ImportParc~D                    Number of groups  =    440,764

R-sq:                                           Obs per group:
     within  = 0.0325                                         min =          1
     between = 0.0047                                         avg =        1.9
     overall = 0.0058                                         max =          2

                                                F(939,440763)     =          .
corr(u_i, Xb)  = -0.1427                        Prob > F          =          .

                         (Std. Err. adjusted for 440,764 clusters in ImportParcelID)
------------------------------------------------------------------------------------
                   |               Robust
 logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------+----------------------------------------------------------------
                 D |   .1232776   .0109794    11.23   0.000     .1017583     .144797
       Remodel_Age |  -.0029271   .0003797    -7.71   0.000    -.0036713   -.0021829
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year3=n_year2*n_year
foreach n of numlist 1/579{
gen group_county`n'_T3=group_county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 group_county1_T3-group_county579_T3 i.monthfixed,fe vce(cluster ImportParcelID)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

. lincom D

 ( 1)  D = 0

------------------------------------------------------------------------------
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         (1) |   .0950305   .0109726     8.66   0.000     .0735245    .1165365
------------------------------------------------------------------------------

. lincom Remodel_Age

 ( 1)  Remodel_Age = 0

------------------------------------------------------------------------------
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         (1) |  -.0026017   .0003769    -6.90   0.000    -.0033404   -.0018631
------------------------------------------------------------------------------
. 
. display round(e(r2),.01)
.06
. 
. display e(N)
853142
////////////////////////////////////////////////////////////////////////////////////////////////////////////////









//2. n periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-same county-drop remodel after 2000-n periods-drop EL-Remodel_AGE.dta" 
egen group_county=group(treatment FIPS)
tab group_county,gen(group_county)
foreach n of numlist 1/579{
gen group_county`n'_T=group_county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T i.monthfixed,fe vce(cluster ImportParcelID)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    870,630
Group variable: ImportParc~D                    Number of groups  =    440,822

R-sq:                                           Obs per group:
     within  = 0.0176                                         min =          1
     between = 0.0185                                         avg =        2.0
     overall = 0.0163                                         max =         71

                                                F(519,440821)     =          .
corr(u_i, Xb)  = -0.1603                        Prob > F          =          .

                        (Std. Err. adjusted for 440,822 clusters in ImportParcelID)
-----------------------------------------------------------------------------------
                  |               Robust
logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
                D |   .2166965   .0079519    27.25   0.000      .201111    .2322819
      Remodel_Age |  -.0020935   .0003397    -6.16   0.000    -.0027593   -.0014278
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year2=n_year*n_year
foreach n of numlist 1/579{
gen group_county`n'_T2=group_county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 i.monthfixed,fe vce(cluster ImportParcelID)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    870,630
Group variable: ImportParc~D                    Number of groups  =    440,822

R-sq:                                           Obs per group:
     within  = 0.0335                                         min =          1
     between = 0.0001                                         avg =        2.0
     overall = 0.0002                                         max =         71

                                                F(968,440821)     =          .
corr(u_i, Xb)  = -0.8561                        Prob > F          =          .

                         (Std. Err. adjusted for 440,822 clusters in ImportParcelID)
------------------------------------------------------------------------------------
                   |               Robust
 logprice_adjusted |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------------+----------------------------------------------------------------
                 D |   .1639704   .0084267    19.46   0.000     .1474543    .1804866
       Remodel_Age |  -.0023839   .0003456    -6.90   0.000    -.0030612   -.0017066
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year3=n_year2*n_year
foreach n of numlist 1/579{
gen group_county`n'_T3=group_county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age group_county1_T-group_county579_T group_county1_T2-group_county579_T2 group_county1_T3-group_county579_T3 i.monthfixed,fe vce(cluster ImportParcelID)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

. lincom D

 ( 1)  D = 0

------------------------------------------------------------------------------
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         (1) |   .0670366   .0081169     8.26   0.000     .0511278    .0829454
------------------------------------------------------------------------------

. lincom Remodel_Age

 ( 1)  Remodel_Age = 0

------------------------------------------------------------------------------
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
         (1) |  -.0020014   .0003485    -5.74   0.000    -.0026844   -.0013184
------------------------------------------------------------------------------

. display round(e(r2),.01)
.06

. 
. display e(N)
870630
///////////////////////////////////////////////////////////////////////////////////////////////////////////////



	  
	  