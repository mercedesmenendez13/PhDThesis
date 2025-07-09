
*===============================================*=======================================================
*Article title: Adoption of twin transition technologies in developing countries: a bivariate analysis
*===============================================*=======================================================

clear all


use data_JEE_after_review.dta, clear

*===============================================
* Table 3 - Summary statistics
*===============================================
sum digital green age_logs Large foreign internet_speed gvc human_capital digital_skills Technological_Innovation investment_capabilities finished vietnam ghana thailand food textiles information automotive metal
*===============================================
* Table A.2.1 - Correlations
*===============================================
asdoc pwcorr digital green age_logs Large foreign internet_speed gvc human_capital digital_skills Technological_Innovation investment_capabilities finished , star(.01) 

*===========================================================================================================
* Table 5 - Univariate and Bivariate Probit: Determinants of the adoption of green and digital technologies
*===========================================================================================================
*[UVP]
*Column 1
probit digital  age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7, vce(r)

predict p_probit_digital
summarize digital  p_probit_digital
margins, atmeans post 
*Column 2
probit green  age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7, vce(r)

predict p_probit_green
summarize green  p_probit_green
margins, atmeans post 

*[BVP]
*Column 3 & Column 4
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res0_0


test [digital=green]

*============================================================================================
* Estimation univariate (marginal) predicted probability and bivariate predicted probability
*============================================================================================
*[Marginal effects]
estimates store res0_0
*pmarg1 
predict pmarg1, pmarg1
estimates store res0_0
*pmarg2 
predict pmarg2, pmarg2
estimates store res0_0
*p00 bivariate predicted probability Pr(depvar1=0, depvar2=0).
predict p00, p00
estimates store res0_0
*p01 bivariate predicted probability Pr(depvar1=0, depvar2=1).
predict p01, p01
estimates store res0_0
*p10 bivariate predicted probability Pr(depvar1=1, depvar2=0).
predict p10, p10
estimates store res0_0
*p11 bivariate predicted probability Pr(depvar1=1, depvar2=1)
predict p11, p11
estimates store res0_0

*pcond1 conditional probability Pr(depvar1=1 | depvar2=1).
predict cond1_0_0, pcond1
* pcond2 conditional probability Pr(depvar2=1 | depvar1=1).
predict cond2_0_0, pcond2

summarize digital green p00 p01 p10 p11 pmarg1 pmarg2


*=========================================================================
* Table 6 - Marginal effects: adoption of green and digital technologies
*=========================================================================

est restore res0_0
margins, dydx(*) atmeans predict(pmarg1) post
est restore res0_0
margins, dydx(*) atmeans predict(pmarg2) post
est restore res0_0


margins, dydx(*) atmeans predict(p00) post
   
est restore res0_0
margins, dydx(*)  atmeans predict(p01) post
 
est restore res0_0
margins, dydx(*) atmeans predict(p10) post
 
est restore res0_0
margins, dydx(*) atmeans predict(p11) post
   
est restore res0_0

predict cond1_mer, pcond1
predict cond2_mer, pcond2

*======================================================================================
* Table 7 - Marginal effects of covariates on the probabilities of innovation adoption
*=====================================================================================
*** MEMs Marginal Effects at the Means
margins, dydx (*) atmeans expression ((predict(p11))) post
 
est restore res0_0
margins, dydx (*) atmeans expression (predict(pmarg1)*predict(pmarg2)) post

est restore res0_0
margins, dydx (*) atmeans expression ((predict(p11)) - (predict(pmarg1)*predict(pmarg2))) post

est restore res0_0

*======================================================================================
* Table A 4 1  - Two sample t-test with equal variance 
*=======================================================================================

gen treat3 = p11 - pmarg1*pmarg2


asdoc ttest treat3, by(ghana) replace
asdoc ttest treat3, by(vietnam)  rowappend 
asdoc ttest treat3, by(thailand) rowappend 
asdoc ttest treat3, by(food)  rowappend 
asdoc ttest treat3, by(textiles) rowappend 
asdoc ttest treat3, by(information)  rowappend
asdoc ttest treat3, by(automotive) rowappend
asdoc ttest treat3, by(wood)  rowappend 
asdoc ttest treat3, by(plastic) rowappend
asdoc ttest treat3, by(metal) rowappend 
asdoc ttest treat3, by(intermediate) rowappend
asdoc ttest treat3, by(finished) rowappend 
asdoc ttest treat3, by(Large) rowappend 
asdoc ttest treat3, by(sme) rowappend 
asdoc ttest treat3, by(RD) rowappend unpaired
asdoc ttest treat3, by(training) rowappend 
asdoc ttest treat3, by(machinery) rowappend
asdoc ttest treat3, by(priv_owned) rowappend 
asdoc ttest treat3, by(priv_owned10) rowappend 
asdoc ttest treat3, by(foreign10) rowappend 
asdoc ttest treat3, by(foreign100) rowappend
asdoc ttest treat3, by(state) rowappend 
asdoc ttest treat3, by(otherf) rowappend 
asdoc ttest treat3, by(prod_inno) rowappend 
asdoc ttest treat3, by(prod_innom) rowappend 
asdoc ttest treat3, by(proc_inno) rowappend 
asdoc ttest treat3, by(proc_innom) rowappend 



*======================================================================================
* ROBUSTNESS CHECKS
*=====================================================================================

*======================================================================================
* Table A.3. 1 - Determinants of green and digital technologies
*=====================================================================================
*Table A4*
mprobit digi_green c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low, vce(r)

*======================================================================================
* Table A.3. 2 - Additional BVP models
*=====================================================================================

**# M12-product_innovation & process_innovation
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_12
outreg2 using "Biprobit.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))
*The athrho of this model is significant at 5%.

predict biprob1_12, pmarg1
predict biprob2_12, pmarg2
predict biprob00_12, p00
predict biprob01_12, p01
predict biprob10_12, p10
predict biprob11_12, p11

predict cond1_12, pcond1
predict cond2_12, pcond2

summarize digital green biprob1_12 biprob2_12 biprob00_12 biprob01_12 biprob10_12 biprob11_12


est restore res_12
margins, dydx(*) atmeans predict(pmarg1) post
 
est restore  res_12
margins, dydx(*) atmeans predict(pmarg2) post

est restore  res_12

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7,vce(r)

predict p12_a
summarize digital  p12_a

probit green   c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7,vce(r)
predict p12_b
summarize digital  p12_b


**# M13: i.innovation
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_13
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_13, pmarg1
predict biprob2_13, pmarg2
predict biprob00_13, p00
predict biprob01_13, p01
predict biprob10_13, p10
predict biprob11_13, p11

predict cond1_13, pcond1
predict cond2_13, pcond2

summarize digital green biprob1_13 biprob2_13 biprob00_13 biprob01_13 biprob10_13 biprob11_13


estimates store res_13
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_13
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_13

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7, vce(r)
predict p13_a
summarize digital  p13_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p13_b
summarize digital  p13_b


**# M14- product_innovation process_innovation IC_intensity_log 
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_14
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_14, pmarg1
predict biprob2_14, pmarg2
predict biprob00_14, p00
predict biprob01_14, p01
predict biprob10_14, p10
predict biprob11_14, p11

predict cond1_14, pcond1
predict cond2_14, pcond2

summarize digital green biprob1_14 biprob2_14 biprob00_14 biprob01_14 biprob10_14 biprob11_14


estimates restore res_14
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_14
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_14

*Simply probit models
probit digital age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p14_a
summarize digital  p14_a

probit green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p14_b
summarize green  p14_b


**# M15-i.innovation  IC_intensity_log 
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)

estimates store res_15
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_15, pmarg1
predict biprob2_15, pmarg2
predict biprob00_15, p00
predict biprob01_15, p01
predict biprob10_15, p10
predict biprob11_15, p11

predict cond1_15, pcond1
predict cond2_15, pcond2

summarize digital green biprob1_15 biprob2_15 biprob00_15 biprob01_15 biprob10_15 biprob11_15


estimates restore res_15
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_15
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_15

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p15_a
summarize digital  p15_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p15_b
summarize green  p15_b


**# M16-Technological_Innovation RD training

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_16
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_16, pmarg1
predict biprob2_16, pmarg2
predict biprob00_16, p00
predict biprob01_16, p01
predict biprob10_16, p10
predict biprob11_16, p11

predict cond1_16, pcond1
predict cond2_16, pcond2

summarize digital green biprob1_16 biprob2_16 biprob00_16 biprob01_16 biprob10_16 biprob11_16


estimates restore res_16
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_16
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_16 

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p16_a
summarize digital  p16_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p16_b
summarize green  p16_b

**# M17-Technological_Innovation RD_training 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_17
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_17, pmarg1
predict biprob2_17, pmarg2
predict biprob00_17, p00
predict biprob01_17, p01
predict biprob10_17, p10
predict biprob11_17, p11

predict cond1_17, pcond1
predict cond2_17, pcond2

summarize digital green biprob1_17 biprob2_17 biprob00_17 biprob01_17 biprob10_17 biprob11_17



estimates restore res_17
margins, dydx(*) atmeans predict(pmarg1) post
estimates restore res_17
margins, dydx(*) atmeans predict(pmarg2) post
estimates restore res_17

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p17_a
summarize digital  p17_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p17_b
summarize green  p17_b

**# m18-product_innovation process_innovation RD_training
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_18
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_18, pmarg1
predict biprob2_18, pmarg2
predict biprob00_18, p00
predict biprob01_18, p01
predict biprob10_18, p10
predict biprob11_18, p11

predict cond1_18, pcond1
predict cond2_18, pcond2

summarize digital green biprob1_18 biprob2_18 biprob00_18 biprob01_18 biprob10_18 biprob11_18


estimates restore res_18
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_18
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_18

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p18_a
summarize digital  p18_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p18_b
summarize green  p18_b

**# M19- i.innovation RD_training 
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)

estimates store res_19
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_19, pmarg1
predict biprob2_19, pmarg2
predict biprob00_19, p00
predict biprob01_19, p01
predict biprob10_19, p10
predict biprob11_19, p11

predict cond1_19, pcond1
predict cond2_19, pcond2

summarize digital green biprob1_19 biprob2_19 biprob00_19 biprob01_19 biprob10_19 biprob11_19


estimates restore res_19
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_19
margins, dydx(*) atmeans predict(pmarg2) post
  
estimates restore res_19

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p19_a
summarize digital  p19_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p19_b
summarize green  p19_b

**# M20-Technological_Innovation investment_capabilities #20
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_20


predict biprob1_20, pmarg1
predict biprob2_20, pmarg2
predict biprob00_20, p00
predict biprob01_20, p01
predict biprob10_20, p10
predict biprob11_20, p11

predict cond1_20, pcond1
predict cond2_20, pcond2

summarize digital green biprob1_20 biprob2_20 biprob00_20 biprob01_20 biprob10_20 biprob11_20


estimates restore res_20
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_20
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_20


*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p20_a
summarize digital  p20_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p20_b
summarize green  p20_b

**# M21-product_innovation process_innovation  investment_capabilities  
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_21


predict biprob1_21, pmarg1
predict biprob2_21, pmarg2
predict biprob00_21, p00
predict biprob01_21, p01
predict biprob10_21, p10
predict biprob11_21, p11

predict cond1_21, pcond1
predict cond2_21, pcond2

summarize digital green biprob1_21 biprob2_21 biprob00_21 biprob01_21 biprob10_21 biprob11_21


estimates restore res_21
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_21
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_21



*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p21_a
summarize digital  p21_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p21_b
summarize green  p21_b


**# M22-i.innovation  investment_capabilities

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_22


predict biprob1_22, pmarg1
predict biprob2_22, pmarg2
predict biprob00_22, p00
predict biprob01_22, p01
predict biprob10_22, p10
predict biprob11_22, p11

predict cond1_22, pcond1
predict cond2_22, pcond2

summarize digital green biprob1_22 biprob2_22 biprob00_22 biprob01_22 biprob10_22 biprob11_22


estimates restore res_22
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_22
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_22

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p22_a
summarize digital  p22_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p22_b
summarize green  p22_b

**# M23-product_innovation process_innovation IC_intensity_log 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_23


predict biprob1_23, pmarg1
predict biprob2_23, pmarg2
predict biprob00_23, p00
predict biprob01_23, p01
predict biprob10_23, p10
predict biprob11_23, p11

predict cond1_23, pcond1
predict cond2_23, pcond2

summarize digital green biprob1_23 biprob2_23 biprob00_23 biprob01_23 biprob10_23 biprob11_23


estimates restore res_23
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_23
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_23


*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low
predict p23_a
summarize digital  p23_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low
predict p23_b
summarize green  p23_b

**# M24 -i.innovation  IC_intensity_log 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_24


predict biprob1_24, pmarg1
predict biprob2_24, pmarg2
predict biprob00_24, p00
predict biprob01_24, p01
predict biprob10_24, p10
predict biprob11_24, p11

predict cond1_24, pcond1
predict cond2_24, pcond2

summarize digital green biprob1_24 biprob2_24 biprob00_24 biprob01_24 biprob10_24 biprob11_24


estimates restore res_24
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_24
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_24


*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p24_a
summarize digital  p24_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p24_b
summarize green  p24_b

**# M25--Technological_Innovation RD training 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_25


predict biprob1_25, pmarg1
predict biprob2_25, pmarg2
predict biprob00_25, p00
predict biprob01_25, p01
predict biprob10_25, p10
predict biprob11_25, p11

predict cond1_25, pcond1
predict cond2_25, pcond2

summarize digital green biprob1_25 biprob2_25 biprob00_25 biprob01_25 biprob10_25 biprob11_25


estimates restore res_25
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_25
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_25

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p25_a
summarize digital  p25_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p25_b
summarize green  p25_b

**# M26-Technological_Innovation RD_training 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ), vce(r)
estimates store res_26


predict biprob1_26, pmarg1
predict biprob2_26, pmarg2
predict biprob00_26, p00
predict biprob01_26, p01
predict biprob10_26, p10
predict biprob11_26, p11

predict cond1_26, pcond1
predict cond2_26, pcond2

summarize digital green biprob1_26 biprob2_26 biprob00_26 biprob01_26 biprob10_26 biprob11_26


estimates restore res_26
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_26
margins, dydx(*) atmeans predict(pmarg2) post
  
estimates restore res_26

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p26_a
summarize digital  p26_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p26_b
summarize green  p26_b

**# M27-product_innovation process_innovation RD_training 
biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ), vce(r)
estimates store res_27

predict biprob1_27, pmarg1
predict biprob2_27, pmarg2
predict biprob00_27, p00
predict biprob01_27, p01
predict biprob10_27, p10
predict biprob11_27, p11

predict cond1_27, pcond1
predict cond2_27, pcond2

summarize digital green biprob1_27 biprob2_27 biprob00_27 biprob01_27 biprob10_27 biprob11_27


estimates restore res_27
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_27
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_27


*Simply probit models
probit digital age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p27_a
summarize digital  p27_a

probit green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p27_b
summarize green  p27_b


**# M28-i.innovation RD_training 

biprobit (digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ) (green age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_28


predict biprob1_28, pmarg1
predict biprob2_28, pmarg2
predict biprob00_28, p00
predict biprob01_28, p01
predict biprob10_28, p10
predict biprob11_28, p11

predict cond1_28, pcond1
predict cond2_28, pcond2

summarize digital green biprob1_28 biprob2_28 biprob00_28 biprob01_28 biprob10_28 biprob11_28


estimates restore res_28
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_28
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_28

*Simply probit models
probit digital  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p28_a
summarize digital  p28_a

probit green  c.age_logs i.Large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p28_b
summarize green  p28_b


*======================================================================================
* Table A.3. 2 - Additional BVP models considering different sizes
*=====================================================================================

**#M29A-

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_29a
outreg2 using "Biprobitee.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

test [digital=green]

predict biprob1_29a, pmarg1
predict biprob2_29a, pmarg2
predict biprob00_29a, p00
predict biprob01_29a, p01
predict biprob10_29a, p10
predict biprob11_29a, p11

predict cond1_29a, pcond1
predict cond2_29a, pcond2

summarize digital green p00 p01 p10 p11 pmarg1 pmarg2


*=========================================================================
* Table 6 - Marginal effects: adoption of green and digital technologies
*=========================================================================

est restore res_29a
margins, dydx(*) atmeans predict(pmarg1) post
est restore res_29a
margins, dydx(*) atmeans predict(pmarg2) post
est restore res_29a


margins, dydx(*) atmeans predict(p00) post
outreg2 using "Model0_b_rev.doc", replace 
est restore res_29a
margins, dydx(*)  atmeans predict(p01) post
outreg2 using "Model0_b_rev.doc", append 
est restore res_29a
margins, dydx(*) atmeans predict(p10) post
outreg2 using "Model0_b_rev.doc", append 
est restore res_29a
margins, dydx(*) atmeans predict(p11) post
outreg2 using "Model0_b_rev.doc", append 
est restore res_29a



**# M29-product_innovation & process_innovation
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_29
outreg2 using "Biprobit.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))
*The athrho of this model is significant at 5%.

predict biprob1_29, pmarg1
predict biprob2_29, pmarg2
predict biprob00_29, p00
predict biprob01_29, p01
predict biprob10_29, p10
predict biprob11_29, p11

predict cond1_29, pcond1
predict cond2_29, pcond2

summarize digital green biprob1_29 biprob2_29 biprob00_29 biprob01_29 biprob10_29 biprob11_29


est restore res_29
margins, dydx(*) atmeans predict(pmarg1) post
 
est restore  res_29
margins, dydx(*) atmeans predict(pmarg2) post

est restore  res_29

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7,vce(r)

predict p29_a
summarize digital  p29_a

probit green   c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7,vce(r)
predict p29_b
summarize digital  p29_b


**# M30: i.innovation
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_30
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_30, pmarg1
predict biprob2_30, pmarg2
predict biprob00_30, p00
predict biprob01_30, p01
predict biprob10_30, p10
predict biprob11_30, p11

predict cond1_30, pcond1
predict cond2_30, pcond2

summarize digital green biprob1_30 biprob2_30 biprob00_30 biprob01_30 biprob10_30 biprob11_30


estimates store res_30
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_30
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_30

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7, vce(r)
predict p30_a
summarize digital  p30_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p30_b
summarize digital  p30_b


**# M31- product_innovation process_innovation IC_intensity_log 
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_31
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_31, pmarg1
predict biprob2_31, pmarg2
predict biprob00_31, p00
predict biprob01_31, p01
predict biprob10_31, p10
predict biprob11_31, p11

predict cond1_31, pcond1
predict cond2_31, pcond2

summarize digital green biprob1_31 biprob2_31 biprob00_31 biprob01_31 biprob10_31 biprob11_31


estimates restore res_31
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_31
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_31

*Simply probit models
probit digital age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p31_a
summarize digital  p31_a

probit green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p31_b
summarize green  p31_b


**# M32-i.innovation  IC_intensity_log 
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)

estimates store res_32
outreg2 using "Biprobit.doc", append  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_32, pmarg1
predict biprob2_32, pmarg2
predict biprob00_32, p00
predict biprob01_32, p01
predict biprob10_32, p10
predict biprob11_32, p11

predict cond1_32, pcond1
predict cond2_32, pcond2

summarize digital green biprob1_32 biprob2_32 biprob00_32 biprob01_32 biprob10_32 biprob11_32


estimates restore res_32
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_32
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_32

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p32_a
summarize digital  p32_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p32_b
summarize green  p32_b


**# M33-Technological_Innovation RD training

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_33
outreg2 using "Biprobit.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_33, pmarg1
predict biprob2_33, pmarg2
predict biprob00_33, p00
predict biprob01_33, p01
predict biprob10_33, p10
predict biprob11_33, p11

predict cond1_33, pcond1
predict cond2_33, pcond2

summarize digital green biprob1_33 biprob2_33 biprob00_33 biprob01_33 biprob10_33 biprob11_33


estimates restore res_33
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_33
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_33 

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p33_a
summarize digital  p33_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p33_b
summarize green  p33_b

**# M34-Technological_Innovation RD_training 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_34
outreg2 using "Biprobit.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_34, pmarg1
predict biprob2_34, pmarg2
predict biprob00_34, p00
predict biprob01_34, p01
predict biprob10_34, p10
predict biprob11_34, p11

predict cond1_34, pcond1
predict cond2_34, pcond2

summarize digital green biprob1_34 biprob2_34 biprob00_34 biprob01_34 biprob10_34 biprob11_34



estimates restore res_34
margins, dydx(*) atmeans predict(pmarg1) post
estimates restore res_34
margins, dydx(*) atmeans predict(pmarg2) post
estimates restore res_34

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p34_a
summarize digital  p34_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p34_b
summarize green  p34_b

**# m35-product_innovation process_innovation RD_training
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)
estimates store res_35
outreg2 using "Biprobit.doc", replace  stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_35, pmarg1
predict biprob2_35, pmarg2
predict biprob00_35, p00
predict biprob01_35, p01
predict biprob10_35, p10
predict biprob11_35, p11

predict cond1_35, pcond1
predict cond2_35, pcond2

summarize digital green biprob1_35 biprob2_35 biprob00_35 biprob01_35 biprob10_35 biprob11_35


estimates restore res_35
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_35
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_35

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p35_a
summarize digital  p35_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p35_b
summarize green  p35_b

**# M36- i.innovation RD_training 
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7), vce(r)

estimates store res_36
outreg2 using "Biprobit.doc", replace   stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_36, pmarg1
predict biprob2_36, pmarg2
predict biprob00_36, p00
predict biprob01_36, p01
predict biprob10_36, p10
predict biprob11_36, p11

predict cond1_36, pcond1
predict cond2_36, pcond2

summarize digital green biprob1_36 biprob2_36 biprob00_36 biprob01_36 biprob10_36 biprob11_36


estimates restore res_36
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_36
margins, dydx(*) atmeans predict(pmarg2) post
  
estimates restore res_36

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p36_a
summarize digital  p36_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.sector1 i.sector2 i.sector3 i.sector4 i.sector7
predict p36_b
summarize green  p36_b

**# M37-Technological_Innovation investment_capabilities #37
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_37
outreg2 using "Biprobit.doc", replace   stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))


predict biprob1_37, pmarg1
predict biprob2_37, pmarg2
predict biprob00_37, p00
predict biprob01_37, p01
predict biprob10_37, p10
predict biprob11_37, p11

predict cond1_37, pcond1
predict cond2_37, pcond2

summarize digital green biprob1_37 biprob2_37 biprob00_37 biprob01_37 biprob10_37 biprob11_37


estimates restore res_37
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_37
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_37


*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p37_a
summarize digital  p37_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p37_b
summarize green  p37_b

**# M38-product_innovation process_innovation  investment_capabilities  
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_38
outreg2 using "Biprobit.doc", replace   stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))


predict biprob1_38, pmarg1
predict biprob2_38, pmarg2
predict biprob00_38, p00
predict biprob01_38, p01
predict biprob10_38, p10
predict biprob11_38, p11

predict cond1_38, pcond1
predict cond2_38, pcond2

summarize digital green biprob1_38 biprob2_38 biprob00_38 biprob01_38 biprob10_38 biprob11_38


estimates restore res_38
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_38
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_38



*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p38_a
summarize digital  p38_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p38_b
summarize green  p38_b


**# M39-i.innovation  investment_capabilities

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_39
outreg2 using "Biprobit.doc", replace   stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))


predict biprob1_39, pmarg1
predict biprob2_39, pmarg2
predict biprob00_39, p00
predict biprob01_39, p01
predict biprob10_39, p10
predict biprob11_39, p11

predict cond1_39, pcond1
predict cond2_39, pcond2

summarize digital green biprob1_39 biprob2_39 biprob00_39 biprob01_39 biprob10_39 biprob11_39


estimates restore res_39
margins, dydx(*) atmeans predict(pmarg1) post
  
estimates restore res_39
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_39

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p39_a
summarize digital  p39_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.investment_capabilities i.digital_skills i.countries i.high i.medium i.low
predict p39_b
summarize green  p39_b

**# M40-product_innovation process_innovation IC_intensity_log 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_40
outreg2 using "Biprobit.doc", replace   stats(coef se) addstat("chi-squared",e(chi2) , "chi-squared for comparison test",  e(chi2_c), "p-value for model test",  e(p) , "rho", e(rho))

predict biprob1_40, pmarg1
predict biprob2_40, pmarg2
predict biprob00_40, p00
predict biprob01_40, p01
predict biprob10_40, p10
predict biprob11_40, p11

predict cond1_40, pcond1
predict cond2_40, pcond2

summarize digital green biprob1_40 biprob2_40 biprob00_40 biprob01_40 biprob10_40 biprob11_40


estimates restore res_40
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_40
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_40


*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low
predict p40_a
summarize digital  p40_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation IC_intensity_log i.digital_skills i.countries i.high i.medium i.low
predict p40_b
summarize green  p40_b

**# M41 -i.innovation  IC_intensity_log 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_41


predict biprob1_41, pmarg1
predict biprob2_41, pmarg2
predict biprob00_41, p00
predict biprob01_41, p01
predict biprob10_41, p10
predict biprob11_41, p11

predict cond1_41, pcond1
predict cond2_41, pcond2

summarize digital green biprob1_41 biprob2_41 biprob00_41 biprob01_41 biprob10_41 biprob11_41


estimates restore res_41
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_41
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_41


*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p41_a
summarize digital  p41_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation  IC_intensity_log i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p41_b
summarize green  p41_b

**# M42--Technological_Innovation RD training 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_42


predict biprob1_42, pmarg1
predict biprob2_42, pmarg2
predict biprob00_42, p00
predict biprob01_42, p01
predict biprob10_42, p10
predict biprob11_42, p11

predict cond1_42, pcond1
predict cond2_42, pcond2

summarize digital green biprob1_42 biprob2_42 biprob00_42 biprob01_42 biprob10_42 biprob11_42


estimates restore res_42
margins, dydx(*) atmeans predict(pmarg1) post

estimates restore res_42
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_42

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p42_a
summarize digital  p42_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD i.training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p42_b
summarize green  p42_b

**# M43-Technological_Innovation RD_training 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ), vce(r)
estimates store res_43


predict biprob1_43, pmarg1
predict biprob2_43, pmarg2
predict biprob00_43, p00
predict biprob01_43, p01
predict biprob10_43, p10
predict biprob11_43, p11

predict cond1_43, pcond1
predict cond2_43, pcond2

summarize digital green biprob1_43 biprob2_43 biprob00_43 biprob01_43 biprob10_43 biprob11_43


estimates restore res_43
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_43
margins, dydx(*) atmeans predict(pmarg2) post
  
estimates restore res_43

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p43_a
summarize digital  p43_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.Technological_Innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low,vce(r)
predict p43_b
summarize green  p43_b

**# M44-product_innovation process_innovation RD_training 
biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ), vce(r)
estimates store res_44

predict biprob1_44, pmarg1
predict biprob2_44, pmarg2
predict biprob00_44, p00
predict biprob01_44, p01
predict biprob10_44, p10
predict biprob11_44, p11

predict cond1_44, pcond1
predict cond2_44, pcond2

summarize digital green biprob1_44 biprob2_44 biprob00_44 biprob01_44 biprob10_44 biprob11_44


estimates restore res_44
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_44
margins, dydx(*) atmeans predict(pmarg2) post

estimates restore res_44


*Simply probit models
probit digital age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p44_a
summarize digital  p44_a

probit green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.product_innovation i.process_innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p44_b
summarize green  p44_b


**# M45-i.innovation RD_training 

biprobit (digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low ) (green age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low), vce(r)
estimates store res_45


predict biprob1_45, pmarg1
predict biprob2_45, pmarg2
predict biprob00_45, p00
predict biprob01_45, p01
predict biprob10_45, p10
predict biprob11_45, p11

predict cond1_45, pcond1
predict cond2_45, pcond2

summarize digital green biprob1_45 biprob2_45 biprob00_45 biprob01_45 biprob10_45 biprob11_45


estimates restore res_45
margins, dydx(*) atmeans predict(pmarg1) post
 
estimates restore res_45
margins, dydx(*) atmeans predict(pmarg2) post
 
estimates restore res_45

*Simply probit models
probit digital  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p45_a
summarize digital  p45_a

probit green  c.age_logs i.size_small i.size_medium i.size_medium_large i.size_large i.foreign i.finished i.gvc i.internet_speed human_capital i.innovation i.RD_training i.digital_skills i.countries i.high i.medium i.low, vce(r)
predict p45_b
summarize green  p45_b
















