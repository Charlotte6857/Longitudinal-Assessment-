
******************************
* Longitudinal Data Analysis * 
* Final Project              *
* LianLian(Jessie) Chen      *
******************************
gen PID = (ER30001*1000) + ER30002

rename TA090136 employment1
rename TA110137 employment2
rename TA130136 employment3
rename TA150128 employment4

rename TA090403 salary1
rename TA110483 salary2
rename TA130503 salary3
rename TA150512 salary4

rename TA090700 health1
rename TA110788 health2
rename TA130808 health3
rename TA150821 health4

rename TA090779 activity1
rename TA110895 activity2
rename TA130928 activity3
rename TA150944 activity4

rename TA090924 hispanic1
rename TA111056 hispanic2
rename TA131091 hispanic3
rename TA151131 hispanic4

rename TA090925 race1
rename TA111057 race2
rename TA131092 race3
rename TA151132 race4

rename TA090989 bmi1
rename TA111131 bmi2
rename TA131223 bmi3
rename TA151283 bmi4

rename TA091008 education1
rename TA111150 education2
rename TA131241 education3
rename TA151301 education4 

save final.dta
sort PID 
keep PID employment1 employment2 employment3 employment4 salary1 salary2 salary3 salary4 health1 health2 health3 health4 activity1 activity2 activity3 activity4 race1 race2 race3 race4 bmi1 bmi2 bmi3 bmi4 education1 

save final1.dta
use final1, clear
merge 1:1 PID using "anxiety.dta"
drop merge 
sort PID
compress
order PID anxiety1 anxiety2 anxiety3 anxiety4 activity1 activity2 activity3 activity4 employment1 employment2 employment3 employment4 salary1 salary2 salary3 salary4 health1 health2 health3 health4 race1 race2 race3 race4 bmi1 bmi2 bmi3 bmi4 education1 
save final_raw.dta

*** Recode ***
recode employment1 (1/2 = 1 "Employed")   ///
	               (3/7 = 0 "Unemployed") ///
				   (8 = .a "Other")       ///
				   (98 = .b "Don't Know") ///
				   (99 = .c "NA/Refused") ///
				   (missing = .)          ///
				   , gen(employed1)

recode employment2 (1/2 = 1 "Employed")   ///
	               (3/7 = 0 "Unemployed") ///
				   (8 = .a "Other")       ///
				   (98 = .b "Don't Know") ///
				   (99 = .c "NA/Refused") ///
				   (missing = .)          ///
				   , gen(employed2)

recode employment3 (1/2 = 1 "Employed")   ///
	               (3/7 = 0 "Unemployed") ///
				   (8 = .a "Other")       ///
				   (98 = .b "Don't Know") ///
				   (99 = .c "NA/Refused") ///
				   (missing = .)          ///
				   , gen(employed3)

recode employment4 (1/2 = 1 "Employed")   ///
	               (3/7 = 0 "Unemployed") ///
				   (8 = .a "Other")       ///
				   (98 = .b "Don't Know") ///
				   (99 = .c "NA/Refused") ///
				   (missing = .)          ///
				   , gen(employed4)

gen goodhealth1 = .
	replace goodhealth1 = 1 if health1 == 1|health1 ==2|health1==3 
	replace goodhealth1 = 0 if health1 == 3|health1==4
label define gh 0 "No" 1 "Yes"	
label values goodhealth1 gh

gen goodhealth2 = .
	replace goodhealth2 = 1 if health2 == 1|health2 ==2|health2==3 
	replace goodhealth2 = 0 if health2 == 3|health2==4
label values goodhealth2 gh

gen goodhealth3 = .
	replace goodhealth3 = 1 if health2 == 1|health3 ==2|health3==3 
	replace goodhealth3 = 0 if health2 == 3|health3==4
label values goodhealth3 gh

gen goodhealth4 = .
	replace goodhealth4 = 1 if health4 == 1|health4 ==2|health4==3 
	replace goodhealth4 = 0 if health4 == 3|health4==4
label values goodhealth4 gh

recode race1 (1 = 1 "White")   ///
	         (2 = 2 "Black/African American") ///
		     (3/7 = 3 "Other")       ///
			 (8 = .a "Don't Know") ///
		     (9 = .b "NA/Refused") ///
			 (missing = .)          ///
		     , gen(race1a)
drop race1
rename race1a race1

recode race2 (1 = 1 "White")   ///
	         (2 = 2 "Black/African American") ///
		     (3/7 = 3 "Other")       ///
			 (8 = .a "Don't Know") ///
		     (9 = .b "NA/Refused") ///
			 (missing = .)          ///
		     , gen(race2a)
drop race2
rename race2a race2

recode race3 (1 = 1 "White")   ///
	         (2 = 2 "Black/African American") ///
		     (3/7 = 3 "Other")       ///
			 (8 = .a "Don't Know") ///
		     (9 = .b "NA/Refused") ///
			 (missing = .)          ///
		     , gen(race3a)
drop race3
rename race3a race3

recode race4 (1 = 1 "White")   ///
	         (2 = 2 "Black/African American") ///
		     (3/7 = 3 "Other")       ///
			 (8 = .a "Don't Know") ///
		     (9 = .b "NA/Refused") ///
			 (missing = .)          ///
		     , gen(race4a)
drop race4
rename race4a race4

recode education1 (1/3 = 1 "No college") ///
                  (4/5 = 2 "Some college") ///
				  (6/19 = 3 "College or higher") ///
				  (99 = .a "NA/DK/Refused") ///
				  (missing = .) ///
				  , gen(education)

recode activity1 (0 = 0 "Not activity") ///
 				 (1/100 = 1 "Active")   ///
				 (998 = .a "DK")        ///
				 (999 = .b "NA/Refused") ///
				 (missing = .)          ///
				 , gen(active1)
				 
recode activity2 (0 = 0 "Not activity") ///
 				 (1/100 = 1 "Active")   ///
				 (998 = .a "DK")        ///
				 (999 = .b "NA/Refused") ///
				 (missing = .)          ///
				 , gen(active2)				 

recode activity3 (0 = 0 "Not activity") ///
 				 (1/100 = 1 "Active")   ///
				 (998 = .a "DK")        ///
				 (999 = .b "NA/Refused") ///
				 (missing = .)          ///
				 , gen(active3)				 
				 
recode activity4 (0 = 0 "Not activity") ///
 				 (1/100 = 1 "Active")   ///
				 (998 = .a "DK")        ///
				 (999 = .b "NA/Refused") ///
				 (missing = .)          ///
				 , gen(active4)				 
				 
				 
mvdecode salary1, mv(9999998 =.a \ 9999999 =.b)		
mvdecode salary2, mv(9999998 =.a \ 9999999 =.b)	
mvdecode salary3, mv(9999998 =.a \ 9999999 =.b)	
mvdecode salary4, mv(9999998 =.a \ 9999999 =.b)	
label define sal .a "DK"              ///             
                 .b "NA/Refused"
label values salary1 sal		
label values salary2 sal	
label values salary3 sal
label values salary4 sal	 


mvdecode bmi1, mv(99 =.a)
mvdecode bmi2, mv(99 =.a)
mvdecode bmi3, mv(99 =.a)
mvdecode bmi4, mv(99 =.a)
label define b .a "DK/NA/Refused"
label values bmi1 b
label values bmi2 b
label values bmi3 b
label values bmi4 b

mvdecode anxiety1, mv(9 =.a)
mvdecode anxiety2, mv(9 =.a)
mvdecode anxiety3, mv(9 =.a)
mvdecode anxiety4, mv(9 =.a)
label define a .a "DK/NA/Refused"
label values anxiety1 a
label values anxiety2 a
label values anxiety3 a
label values anxiety4 a

sort PID
keep PID anxiety1 anxiety2 anxiety3 anxiety4 active1 active2 active3 active4 employed1 employed2 employed3 employed4 salary1 salary2 salary3 salary4 goodhealth1 goodhealth2 goodhealth3 goodhealth4 bmi1 bmi2 bmi3 bmi4 race1 race2 race3 race4 education 
order PID anxiety1 anxiety2 anxiety3 anxiety4 active1 active2 active3 active4 employed1 employed2 employed3 employed4 salary1 salary2 salary3 salary4 goodhealth1 goodhealth2 goodhealth3 goodhealth4 bmi1 bmi2 bmi3 bmi4 race1 race2 race3 race4 education 

save final_data.dta, replace

drop if missing(anxiety1)
drop if missing(anxiety2)
drop if missing(anxiety3)
drop if missing(anxiety4)
drop if missing(active1)
drop if missing(active2)
drop if missing(active3)
drop if missing(active4)
drop if missing(employed1)
drop if missing(employed2)
drop if missing(employed3)
drop if missing(employed4)
drop if missing(salary1)
drop if missing(salary2)
drop if missing(salary3)
drop if missing(salary4)
drop if missing(goodhealth1)
drop if missing(goodhealth2)
drop if missing(goodhealth3)
drop if missing(goodhealth4)
drop if missing(bmi1)
drop if missing(bmi2)
drop if missing(bmi3)
drop if missing(bmi4)
drop if missing(race1)
drop if missing(education)

*** Descriptive Analyses ***
summarize anxiety*

/*


    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
    anxiety1 |        362    3.497238    1.464726          1          7
    anxiety2 |        362    3.441989    1.476765          1          7
    anxiety3 |        362    3.383978    1.386147          1          7
    anxiety4 |        362    3.381215    1.438867          1          7
*/ 

tab1 active*
/*

-> tabulation of active1  

   RECODE of |
   activity1 |
  (H23B FREQ |
     OF LITE |
    PHYSICAL |
ACTIVITY-HW) |      Freq.     Percent        Cum.
-------------+-----------------------------------
Not activity |        324       89.50       89.50
      Active |         38       10.50      100.00
-------------+-----------------------------------
       Total |        362      100.00

-> tabulation of active2  

   RECODE of |
   activity2 |
  (H23B FREQ |
     OF LITE |
    PHYSICAL |
ACTIVITY--HW |
           ) |      Freq.     Percent        Cum.
-------------+-----------------------------------
Not activity |        272       75.14       75.14
      Active |         90       24.86      100.00
-------------+-----------------------------------
       Total |        362      100.00

-> tabulation of active3  

   RECODE of |
   activity3 |
  (H23B FREQ |
     OF LITE |
    PHYSICAL |
ACTIVITY--HW |
           ) |      Freq.     Percent        Cum.
-------------+-----------------------------------
Not activity |        210       58.01       58.01
      Active |        152       41.99      100.00
-------------+-----------------------------------
       Total |        362      100.00

-> tabulation of active4  

   RECODE of |
     active4 |
  (RECODE of |
   activity4 |
  (H23B FREQ |
     OF LITE |
    PHYSICAL |
ACTIVITY--HW |
           ) |      Freq.     Percent        Cum.
-------------+-----------------------------------
Not activity |        140       38.67       38.67
      Active |        222       61.33      100.00
-------------+-----------------------------------
       Total |        362      100.00


*/

tab1 employed*
/*

-> tabulation of employed1  

  RECODE of |
employment1 |
        (E1 |
 EMPLOYMENT |
 STATUS 1ST |
   MENTION) |      Freq.     Percent        Cum.
------------+-----------------------------------
 Unemployed |        193       53.31       53.31
   Employed |        169       46.69      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of employed2  

  RECODE of |
employment2 |
        (E1 |
 EMPLOYMENT |
 STATUS 1ST |
   MENTION) |      Freq.     Percent        Cum.
------------+-----------------------------------
 Unemployed |        151       41.71       41.71
   Employed |        211       58.29      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of employed3  

  RECODE of |
employment3 |
        (E1 |
 EMPLOYMENT |
 STATUS 1ST |
   MENTION) |      Freq.     Percent        Cum.
------------+-----------------------------------
 Unemployed |        103       28.45       28.45
   Employed |        259       71.55      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of employed4  

  RECODE of |
employment4 |
        (E1 |
 EMPLOYMENT |
 STATUS 1ST |
   MENTION) |      Freq.     Percent        Cum.
------------+-----------------------------------
 Unemployed |         71       19.61       19.61
   Employed |        291       80.39      100.00
------------+-----------------------------------
      Total |        362      100.00

*/

summarize salary*
/*

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
     salary1 |        362    4741.536    9903.978          0     150000
     salary2 |        362    5097.301    8909.688          0      70000
     salary3 |        362    6376.105    11001.98          0      70000
     salary4 |        362    23975.24    20701.86          0     130000

*/

tab1 goodhealth*	
/*
-> tabulation of goodhealth1  

goodhealth1 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        114       31.49       31.49
        Yes |        248       68.51      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of goodhealth2  

goodhealth2 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        126       34.81       34.81
        Yes |        236       65.19      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of goodhealth3  

goodhealth3 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        114       31.49       31.49
        Yes |        248       68.51      100.00
------------+-----------------------------------
      Total |        362      100.00

-> tabulation of goodhealth4  

goodhealth4 |      Freq.     Percent        Cum.
------------+-----------------------------------
         No |        122       33.70       33.70
        Yes |        240       66.30      100.00
------------+-----------------------------------
      Total |        362      100.00


*/
	   
summarize bmi*
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
        bmi1 |        362    24.81547    4.815313         16       43.8
        bmi2 |        362    25.65442    5.112783       16.6       49.8
        bmi3 |        362    26.25304    5.421135       16.4       46.8
        bmi4 |        362    27.21519    6.014306       15.6       59.5

*/

tab race1
/*
   RECODE of race1 (L7 |
      RACE MENTION #1) |      Freq.     Percent        Cum.
-----------------------+-----------------------------------
                 White |        200       55.25       55.25
Black/African American |        118       32.60       87.85
                 Other |         44       12.15      100.00
-----------------------+-----------------------------------
                 Total |        362      100.00


*/

tab education 
/*
        RECODE of |
       education1 |
         (HIGHEST |
 EDUCATION LEVEL) |      Freq.     Percent        Cum.
------------------+-----------------------------------
       No college |        101       27.90       27.90
     Some college |        251       69.34       97.24
College or higher |         10        2.76      100.00
------------------+-----------------------------------
            Total |        362      100.00

*/

*** Reshape ***
reshape long anxiety active employed salary goodhealth bmi, i(PID) j(wave)
xtset PID wave

** Individual Growth Plots *** 
graph twoway scatter anxiety wave in 1/100, by(PID) ylabel(1(1)7) xlabel(1(1)4)
graph twoway (lowess anxiety wave)(scatter anxiety wave) in 1/100, by(PID) ylabel(1(1)7) xlabel(1(1)4)
graph twoway (lfit anxiety wave)(scatter anxiety wave)in 1/100, by(PID) ylabel(1(1)7) xlabel(1(1)4)
*** OLS ***
preserve
gen wave_c=(wave-1)
tab wave_c
egen grp=group(PID)
generate p2=.
forvalues i = 1/362 {
  quietly regress anxiety wave_c if grp==`i' 
  quietly predict p 
  quietly replace p2=p if grp==`i'
  quietly drop p
 }
graph twoway (scatter p2 wave_c, msym(i) connect(L))(lfit anxiety wave_c, ylabel(1(1)7) xlabel(0(1)3) lc(red) lwidth(thick) legend(lab (1 "Anxiety"))) 


*** Statistics ***
statsby _b[_cons] _se[_cons] _b[wave_c] _se[wave_c] (e(rmse)^2) e(r2), by(PID) saving(final_data2): regress anxiety wave_c
clear all
use final_data2
list, clean
rename _stat_1 intercept 
rename _stat_3 slope
save final_data2, replace

** Descriptive statistics of individual regression estimates
sum  intercept slope
/*
    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
   intercept |        362    3.487017    1.371403         .6        7.3
       slope |        362   -.0406077     .484991         -2        1.3


*/ 

** Correlation between estimated intercepts and slopes (SLIDE 10)
correlate intercept slope
/* 
             | interc~t    slope
-------------+------------------
   intercept |   1.0000
       slope |  -0.5151   1.0000

*/ 


mixed anxiety|| PID:,  var  mle
/*
. mixed anxiety|| PID:,  var  mle

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -2324.3614  
Iteration 1:   log likelihood = -2324.3614  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      1,448
Group variable: PID                             Number of groups  =        362
                                                Obs per group:
                                                              min =          4
                                                              avg =        4.0
                                                              max =          4
                                                Wald chi2(0)      =          .
Log likelihood = -2324.3614                     Prob > chi2       =          .

------------------------------------------------------------------------------
     anxiety | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
       _cons |   3.426105   .0617056    55.52   0.000     3.305164    3.547046
------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Identity                |
                  var(_cons) |   1.145782   .1029365      .9607948    1.366387
-----------------------------+------------------------------------------------
               var(Residual) |   .9302487   .0399208      .8552055    1.011877
------------------------------------------------------------------------------
LR test vs. linear model: chibar2(01) = 518.23        Prob >= chibar2 = 0.0000

*/ 

estat icc
/* 
Intraclass correlation

------------------------------------------------------------------------------
                       Level |        ICC   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
                         PID |     .55191    .025534      .5015067     .601269
------------------------------------------------------------------------------

*/ 
estat ic
/*
Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
           . |      1,448          .  -2324.361       3   4654.723   4670.557
-----------------------------------------------------------------------------
Note: BIC uses N = number of observations. See [R] BIC note.

*/
est store model_0


*** Unconditional Growth Model ***
mixed anxiety wave_c || PID: wave_c, cov(un) 
/* 

Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood =  -2313.962  
Iteration 1:   log likelihood = -2313.8224  
Iteration 2:   log likelihood = -2313.8223  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      1,448
Group variable: PID                             Number of groups  =        362
                                                Obs per group:
                                                              min =          4
                                                              avg =        4.0
                                                              max =          4
                                                Wald chi2(1)      =       2.54
Log likelihood = -2313.8223                     Prob > chi2       =     0.1107

------------------------------------------------------------------------------
     anxiety | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      wave_c |  -.0406077   .0254553    -1.60   0.111    -.0904993    .0092838
       _cons |   3.487017   .0719797    48.44   0.000     3.345939    3.628094
------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(wave_c) |      .0736   .0193794      .0439289    .1233118
                  var(_cons) |   1.312167   .1425186      1.060565    1.623457
           cov(wave_c,_cons) |    -.10021   .0412167     -.1809932   -.0194268
-----------------------------+------------------------------------------------
               var(Residual) |   .8048338   .0423011      .7260526    .8921632
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 537.87                Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

*/
estat ic
/*
Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
           . |      1,448          .  -2313.822       6   4639.645   4671.312
-----------------------------------------------------------------------------
Note: BIC uses N = number of observations. See [R] BIC note.

*/
est store model_1

predict m2
graph twoway (line m2 wave_c, sort), xlabel(0 1 2 3) xtitle("Wave") ytitle("Linear Prediction of Anxiety")


*** Model with main iv*** 
mixed anxiety c.wave_c##i.active || PID: wave_c, var cov(un)
/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -2313.7814  
Iteration 1:   log likelihood = -2313.6389  
Iteration 2:   log likelihood = -2313.6387  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      1,448
Group variable: PID                             Number of groups  =        362
                                                Obs per group:
                                                              min =          4
                                                              avg =        4.0
                                                              max =          4
                                                Wald chi2(3)      =       2.92
Log likelihood = -2313.6387                     Prob > chi2       =     0.4047

------------------------------------------------------------------------------
     anxiety | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
      wave_c |  -.0281218   .0337904    -0.83   0.405    -.0943499    .0381062
             |
      active |
     Active  |   -.004613   .1382685    -0.03   0.973    -.2756143    .2663884
             |
      active#|
    c.wave_c |
     Active  |  -.0191531   .0609228    -0.31   0.753    -.1385596    .1002535
             |
       _cons |   3.483908   .0755466    46.12   0.000     3.335839    3.631976
------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(wave_c) |   .0732015    .019363      .0435877    .1229353
                  var(_cons) |   1.312227   .1425334        1.0606    1.623551
           cov(wave_c,_cons) |  -.0997825   .0411931     -.1805195   -.0190456
-----------------------------+------------------------------------------------
               var(Residual) |   .8049338   .0423098      .7261367    .8922817
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 538.17                Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.

*/
estat ic 
/*
. estat ic 

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
           . |      1,448          .  -2313.639       8   4643.277   4685.501
-----------------------------------------------------------------------------
Note: BIC uses N = number of observations. See [R] BIC note.

*/

est store model_2

margins active, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")


*** Model with all varibles***
gen wave_employ = (employed*wave_c)
gen wave_salary = (salary*wave_c)
gen wave_gh = (goodhealth*wave_c)
gen wave_bmi = (bmi*wave_c)

mixed anxiety c.wave_c##i.active i.employed wave_employ c.salary wave_salary i.goodhealth wave_gh c.bmi wave_bmi i.race1 i.education|| PID: wave_c, cov(un) var mle
/*
Performing EM optimization ...

Performing gradient-based optimization: 
Iteration 0:   log likelihood = -2303.1363  
Iteration 1:   log likelihood = -2302.9505  
Iteration 2:   log likelihood = -2302.9502  
Iteration 3:   log likelihood = -2302.9502  

Computing standard errors ...

Mixed-effects ML regression                     Number of obs     =      1,448
Group variable: PID                             Number of groups  =        362
                                                Obs per group:
                                                              min =          4
                                                              avg =        4.0
                                                              max =          4
                                                Wald chi2(15)     =      24.68
Log likelihood = -2302.9502                     Prob > chi2       =     0.0544

--------------------------------------------------------------------------------
       anxiety | Coefficient  Std. err.      z    P>|z|     [95% conf. interval]
---------------+----------------------------------------------------------------
        wave_c |  -.2028571   .1407296    -1.44   0.149     -.478682    .0729678
               |
        active |
       Active  |   .0444116   .1466551     0.30   0.762    -.2430271    .3318504
               |
        active#|
      c.wave_c |
       Active  |  -.0397811   .0638925    -0.62   0.534    -.1650082     .085446
               |
      employed |
     Employed  |  -.0939453    .103028    -0.91   0.362    -.2958765    .1079859
   wave_employ |   .0084029   .0600663     0.14   0.889    -.1093248    .1261307
        salary |  -5.26e-07   5.63e-06    -0.09   0.926    -.0000116    .0000105
   wave_salary |   1.20e-06   2.06e-06     0.58   0.561    -2.85e-06    5.25e-06
               |
    goodhealth |
          Yes  |  -.1601466   .1083901    -1.48   0.140    -.3725873     .052294
       wave_gh |    .030848   .0554929     0.56   0.578     -.077916     .139612
           bmi |   .0167924   .0129442     1.30   0.195    -.0085777    .0421625
      wave_bmi |   .0045993   .0047873     0.96   0.337    -.0047837    .0139823
               |
         race1 |
Black/Afric..  |   -.381965   .1423482    -2.68   0.007    -.6609624   -.1029676
        Other  |   .0492992    .193154     0.26   0.799    -.3292758    .4278741
               |
     education |
 Some college  |  -.2851924   .1426495    -2.00   0.046    -.5647803   -.0056046
College or ..  |  -.2206474   .3884948    -0.57   0.570    -.9820832    .5407884
               |
         _cons |   3.552324   .3604571     9.86   0.000     2.845841    4.258807
--------------------------------------------------------------------------------

------------------------------------------------------------------------------
  Random-effects parameters  |   Estimate   Std. err.     [95% conf. interval]
-----------------------------+------------------------------------------------
PID: Unstructured            |
                 var(wave_c) |    .068093   .0191575      .0392304    .1181904
                  var(_cons) |   1.246463   .1385488      1.002456    1.549864
           cov(wave_c,_cons) |  -.0895319   .0407899     -.1694787   -.0095851
-----------------------------+------------------------------------------------
               var(Residual) |   .8042357    .042323      .7254186    .8916162
------------------------------------------------------------------------------
LR test vs. linear model: chi2(3) = 515.10                Prob > chi2 = 0.0000

Note: LR test is conservative and provided only for reference.


*/
estat ic
/*
. estat ic

Akaike's information criterion and Bayesian information criterion

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
           . |      1,448          .   -2302.95      20     4645.9   4751.459
-----------------------------------------------------------------------------
Note: BIC uses N = number of observations. See [R] BIC note.

*/

est store model_3

margins active, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins employed, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins goodhealth, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins race1, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins education, at(wave_c = (0(1)3))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins, at(wave_c = (0(1)3) salary = (0(5000)15000))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

margins, at(wave_c = (0(1)3) bmi = (15.6(10)59.5))
marginsplot, noci xtitle("Wave") ytitle("Linear Prediction of Anxiety")

*** Model Fit 
lrtest model_0 model_1
lrtest model_1 model_2
lrtest model_2 model_3
/*
. lrtest model_0 model_1

Likelihood-ratio test
Assumption: model_0 nested within model_1

 LR chi2(3) =  21.08
Prob > chi2 = 0.0001

Note: The reported degrees of freedom assumes the null hypothesis is not on the
      boundary of the parameter space. If this is not true, then the reported
      test is conservative.

. lrtest model_1 model_2

Likelihood-ratio test
Assumption: model_1 nested within model_2

 LR chi2(2) =   0.37
Prob > chi2 = 0.8323

. lrtest model_2 model_3

Likelihood-ratio test
Assumption: model_2 nested within model_3

LR chi2(12) =  21.38
Prob > chi2 = 0.0451

*/

