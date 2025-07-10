***Do file: Paper Menendez, Nomaler and Verspagen***

clear all

*cd c:\projects\patmaps

*import delimited "Green_AI_ML_cosine_similarity_for_novelty_identification_withTechShares_withIndirectCitations.csv"


cd "/Users/mercedesmenendez/Library/Mobile Documents/com~apple~CloudDocs/Documents/PHD/chapterNoveltyPapers/data"

import delimited "Green_AI_ML_cosine_similarity_for_novelty_identification_withTechShares_withIndirectCitations.csv"
*import delimited "Green_AI_ML_cosine_similarity_for_novelty_regression 2.csv"

is_variant_of_trajectory_nr trajectory_nr length_trajectory appln_id_cited appln_id_citing position_in_trajectory_cited position_in_trajectory_citing

** Possibly select a subset of the data only:
*drop if traject_has_docdb_kinship_link_s>0

*===============================================
* Cases
*===============================================

** denote as AI 0/1 Green 0/1
 * Cited 00 Citing 00  C1 ("baseline")
 * Cited 00 Citing 01  C2
 * Cited 00 Citing 10  C3
 * Cited 00 Citing 11  C4
 
 * Cited 01 Citing 00  C5
 * Cited 01 Citing 01  C6
 * Cited 01 Citing 10  C7
 * Cited 01 Citing 11  C8
 
 * Cited 10 Citing 00  C9
 * Cited 10 Citing 01  C10
 * Cited 10 Citing 10  C11
 * Cited 10 Citing 11  C12
 
 * Cited 11 Citing 00  C13
 * Cited 11 Citing 01  C14
 * Cited 11 Citing 10  C15
 * Cited 11 Citing 11  C16
 
gen case1 = 0
replace case1 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 0) 
gen case2 = 0
replace case2 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 1)
gen case3 = 0
replace case3 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 0)
gen case4 = 0
replace case4 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 1) 

gen case5 = 0
replace case5 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 0) 
gen case6 = 0
replace case6 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 1)
gen case7 = 0
replace case7 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 0)
gen case8 = 0
replace case8 = 1 if (cited_has_ai_ml == 0) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 1) 

gen case9 = 0
replace case9 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 0) 
gen case10 = 0
replace case10 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 1)
gen case11 = 0
replace case11 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 0)
gen case12 = 0
replace case12 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 0) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 1) 

gen case13 = 0
replace case13 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 0) 
gen case14 = 0
replace case14 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 0) & (citing_has_envtech_green == 1)
gen case15 = 0
replace case15 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 0)
gen case16 = 0
replace case16 = 1 if (cited_has_ai_ml == 1) & (cited_has_envtech_green == 1) & (citing_has_ai_ml == 1) & (citing_has_envtech_green == 1) 

g traj_5=0
replace traj_5 = 1 if length_trajectory==5

g traj_10=0
replace traj_10 = 1 if length_trajectory==10

g traj_15=0
replace traj_15 = 1 if length_trajectory==15

g traj_20=0
replace traj_20 = 1 if length_trajectory==20

g traj_25=0
replace traj_25 = 1 if length_trajectory==25

*===============================================
* Dependent variable
*===============================================

** Now we focus on the sqrt version of the dependent

gen sqrt_a_novelty_metric = sqrt(a_novelty_metric)

asdoc pwcorr sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, star(.01) 


* Just a robustness check using the alternative "scaling" of the novelty measure
* it doesn't matter whether we use the ln_, non_ln_ or sqrt_ version for this alternative scaling
* because these are all monotonic transformations

* create the ranked version of the novelty metric, by length
sort length_trajectory a_novelty_metric
by length_trajectory: egen ranked_novelty_by_length = rank(a_novelty_metric)
gen ln_ranked_novelty_by_length = ln(ranked_novelty_by_length)


* Just a quick and dirty way to divide by the number of patents for a given length
tab length_trajectory

gen scaled_ranked_novelty = ranked_novelty_by_length

replace scaled_ranked_novelty = 100*scaled_ranked_novelty/3417 if length_trajectory == 5
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/5442 if length_trajectory == 6
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/8801 if length_trajectory == 7
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/12192 if length_trajectory == 8
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/15499 if length_trajectory == 9
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/16541 if length_trajectory == 10
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/15466 if length_trajectory == 11
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/12680 if length_trajectory == 12
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/10453 if length_trajectory == 13
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/8016 if length_trajectory == 14
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/5352 if length_trajectory == 15
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/4122 if length_trajectory == 16
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/2665 if length_trajectory == 17
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/2074 if length_trajectory == 18
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/1408 if length_trajectory == 19
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/1540 if length_trajectory == 20
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/547 if length_trajectory == 21
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/167 if length_trajectory == 22
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/72 if length_trajectory == 23
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/80 if length_trajectory == 25
replace scaled_ranked_novelty = 100*scaled_ranked_novelty/126 if length_trajectory == 26

* Now the alternatively scaled version is done


*====================================
* Check out the new variables
* split is_inDirect_EPO_Citn into two:
gen docdb_nocitation = 0
replace docdb_nocitation = 1 if is_indirect_epo_citn == 0.5
gen docdb_citation = 0
replace docdb_citation = 1 if is_indirect_epo_citn == 1

** docdb_nocitation = 1 means that originally this pair was not a citation, but we turned it into a citation because they are in the same DOCDB family
** docdb_citation = 1 means that originally this pair was not a citation, but we turned it into a citation because another patent made it into an indirect citation

*====================================


*==========================
* new definition of the citation type control dummies
* this should not change anything

gen ArtCitType1 = 0
gen ArtCitType2 = 0
gen ArtCitType3 = 0

replace ArtCitType1 = 1 if is_indirect_epo_citn == 0.5 
replace ArtCitType2 = 1 if is_indirect_epo_citn == 1 & indirect_citn_involves_docdb_kin == 0
replace ArtCitType3 = 1 if is_indirect_epo_citn == 1 & indirect_citn_involves_docdb_kin == 1


** Check dependency of old and new citation type controls

*tab ArtCitType1 docdb_nocitation
*tab ArtCitType2 docdb_nocitation
*tab ArtCitType3 docdb_nocitation

*tab ArtCitType1 docdb_citation
*tab ArtCitType2 docdb_citation
*tab ArtCitType3 docdb_citation

*tab ArtCitType1 indirect_citn_involves_docdb_kin
*tab ArtCitType2 indirect_citn_involves_docdb_kin
*tab ArtCitType3 indirect_citn_involves_docdb_kin

*reg ArtCitType1 docdb_nocitation docdb_citation indirect_citn_involves_docdb_kin
*reg ArtCitType2 docdb_nocitation docdb_citation indirect_citn_involves_docdb_kin
*reg ArtCitType3 docdb_nocitation docdb_citation indirect_citn_involves_docdb_kin

*reg docdb_nocitation ArtCitType1 ArtCitType2 ArtCitType3
*reg docdb_citation ArtCitType1 ArtCitType2 ArtCitType3
*reg indirect_citn_involves_docdb_kin ArtCitType1 ArtCitType2 ArtCitType3

*==========================


** The regressions below do not use the case variables, but they reproduce them exactly
** They also use a basic set of explanatory variables, which could be varied slightly as a kind of robustness analysis
** For example, we could use prox_to_centre_abs instead of prox_to_centre_signed
** and we could use i.length_trajectory instead of length_trajectory

** Also, I use "manually" specified values for q() instead of looping them or some other way of automating
** also note I installed and use qreg2, which allows clusterd standard errors

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, vce(cluster trajectory_nr)
outreg2 using qregres_mercedes.xls, excel replace
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes.xls, excel


reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, vce(cluster trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes2.xls, excel


reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory, vce(cluster trajectory_nr)
outreg2 using qregres_mercedes2.tex, replace 


qregplot case2-case16, ols


qregplot case2-case16 ,  q(5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95) 


reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), vce(cluster trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes355.xls, excel


reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , vce(cluster trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel




reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory , vce(cluster trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  traj_5 traj_10 traj_15 traj_20 traj_25  , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  traj_5 traj_10 traj_15 traj_20 traj_25   , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel



reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesiter.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  , q(0.50) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  , q(0.55) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  , q(0.60) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  , q(0.65) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory   , q(0.70) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory   , q(0.75) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory   , q(0.80) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory   , q(0.85) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory  , q(0.90) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory   , q(0.95) c(trajectory_nr)  wlsiter(500)
outreg2 using qregres_mercedesiter.xls, excel













reg sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), vce(cluster trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel replace
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel 
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s i.length_trajectory  if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory if inlist(length_trajectory, 5, 10, 15, 20, 25), q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel
qreg2 sqrt_a_novelty_metric case2-case16 prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s  i.length_trajectory if inlist(length_trajectory, 5, 6, 7,8,9,10,11,12,13,14,15,16,17,18,19, 20, 25), q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedes3.xls, excel


**** haciendo con los verdes***
*is_y0a*
reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel replace
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y0a==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02b==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02c==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02d==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02e==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append


reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02p==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02t==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append

reg sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , vce(cluster trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.50) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append 
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.55) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.60) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.65) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.70) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.75) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.80) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.85) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.90) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append
qreg2 sqrt_a_novelty_metric cited_has_ai_ml#cited_has_envtech_green#citing_has_ai_ml#citing_has_envtech_green prox_to_centre_signed shr_ai_ml_intraj shr_green_intraj shr_green_ai_ml ArtCitType1 ArtCitType2 ArtCitType3 traject_has_docdb_kinship_link_s length_trajectory if is_y02w==1 , q(0.95) c(trajectory_nr)
outreg2 using qregres_mercedesy02a.xls, excel append




