//1. only 2 periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-same county-drop remodel after 2000-only 2 periods-drop EL-Remodel_AGE.dta" 
tab FIPS,gen(county)
foreach n of numlist 1/306{
gen county`n'_T=county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T i.monthfixed,fe vce(cluster ImportParcelID)
/////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    853,142
Group variable: ImportParc~D                    Number of groups  =    440,764

R-sq:                                           Obs per group:
     within  = 0.0151                                         min =          1
     between = 0.0038                                         avg =        1.9
     overall = 0.0039                                         max =          2

                                                F(311,440763)     =          .
corr(u_i, Xb)  = -0.0847                        Prob > F          =          .

                   (Std. Err. adjusted for 440,764 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .2191206   .0097491    22.48   0.000     .2000127    .2382285
 Remodel_Age |   -.002139   .0003777    -5.66   0.000    -.0028793   -.0013988
/////////////////////////////////////////////////////////////////////////////////


gen n_year2=n_year*n_year
foreach n of numlist 1/306{
gen county`n'_T2=county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 i.monthfixed,fe vce(cluster ImportParcelID)
/////////////////////////////////////////////////////////////////////////////////

Fixed-effects (within) regression               Number of obs     =    853,142
Group variable: ImportParc~D                    Number of groups  =    440,764

R-sq:                                           Obs per group:
     within  = 0.0302                                         min =          1
     between = 0.0060                                         avg =        1.9
     overall = 0.0069                                         max =          2

                                                F(601,440763)     =          .
corr(u_i, Xb)  = -0.1240                        Prob > F          =          .

                   (Std. Err. adjusted for 440,764 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .1896621   .0102472    18.51   0.000     .1695778    .2097464
 Remodel_Age |  -.0028556   .0003794    -7.53   0.000    -.0035992   -.0021119
/////////////////////////////////////////////////////////////////////////////////


gen n_year3=n_year2*n_year
foreach n of numlist 1/306{
gen county`n'_T3=county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 county1_T3-county306_T3 i.monthfixed,fe vce(cluster ImportParcelID)
/////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    853,142
Group variable: ImportParc~D                    Number of groups  =    440,764

R-sq:                                           Obs per group:
     within  = 0.0615                                         min =          1
     between = 0.0085                                         avg =        1.9
     overall = 0.0129                                         max =          2

                                                F(887,440763)     =          .
corr(u_i, Xb)  = -0.1295                        Prob > F          =          .

                   (Std. Err. adjusted for 440,764 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .0793142   .0101727     7.80   0.000      .059376    .0992524
 Remodel_Age |   -.002552   .0003766    -6.78   0.000    -.0032902   -.0018139
/////////////////////////////////////////////////////////////////////////////////





//2. n periods
set maxvar 32767
set matsize 11000
use "C:\Users\wills\Desktop\Heat Pump Paper\Data\National\treatment and mixed control group-same county-drop remodel after 2000-n periods-drop EL-Remodel_AGE.dta",clear 
tab FIPS,gen(county)
foreach n of numlist 1/306{
gen county`n'_T=county`n'*n_year
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T i.monthfixed,fe vce(cluster ImportParcelID)
///////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    870,630
Group variable: ImportParc~D                    Number of groups  =    440,822

R-sq:                                           Obs per group:
     within  = 0.0153                                         min =          1
     between = 0.0445                                         avg =        2.0
     overall = 0.0377                                         max =         71

                                                F(312,440821)     =          .
corr(u_i, Xb)  = 0.0213                         Prob > F          =          .

                   (Std. Err. adjusted for 440,822 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .2386219   .0074747    31.92   0.000     .2239716    .2532721
 Remodel_Age |  -.0019596   .0003432    -5.71   0.000    -.0026322    -.001287
///////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year2=n_year*n_year
foreach n of numlist 1/306{
gen county`n'_T2=county`n'*n_year2
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 i.monthfixed,fe vce(cluster ImportParcelID)
///////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    870,630
Group variable: ImportParc~D                    Number of groups  =    440,822

R-sq:                                           Obs per group:
     within  = 0.0297                                         min =          1
     between = 0.0018                                         avg =        2.0
     overall = 0.0021                                         max =         71

                                                F(603,440821)     =          .
corr(u_i, Xb)  = -0.4110                        Prob > F          =          .

                   (Std. Err. adjusted for 440,822 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .2254702   .0079985    28.19   0.000     .2097934     .241147
 Remodel_Age |  -.0024143   .0003485    -6.93   0.000    -.0030973   -.0017313
///////////////////////////////////////////////////////////////////////////////////////////////////////


gen n_year3=n_year2*n_year
foreach n of numlist 1/306{
gen county`n'_T3=county`n'*n_year3
}
xtreg logprice_adjusted D Remodel_Age county1_T-county306_T county1_T2-county306_T2 county1_T3-county306_T3 i.monthfixed,fe vce(cluster ImportParcelID)
///////////////////////////////////////////////////////////////////////////////////////////////////////
Fixed-effects (within) regression               Number of obs     =    870,630
Group variable: ImportParc~D                    Number of groups  =    440,822

R-sq:                                           Obs per group:
     within  = 0.0601                                         min =          1
     between = 0.0007                                         avg =        2.0
     overall = 0.0009                                         max =         71

                                                F(888,440821)     =          .
corr(u_i, Xb)  = -0.8555                        Prob > F          =          .

                   (Std. Err. adjusted for 440,822 clusters in ImportParcelID)
------------------------------------------------------------------------------
             |               Robust
logprice_a~d |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .0859953   .0078843    10.91   0.000     .0705422    .1014483
 Remodel_Age |  -.0020093   .0003498    -5.74   0.000     -.002695   -.0013236
///////////////////////////////////////////////////////////////////////////////////////////////////////

