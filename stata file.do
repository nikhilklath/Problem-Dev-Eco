******************
* Nikhil Kumar
* EC 522
* Problem Set 3
* Question 2
******************

clear all

cd "C:\Users\nikhi\Desktop\BU_Sem_2\EC 522\Problem Sets\PS3"
use "PS3_DID.dta"

* a
recode v116 (23 30 31 42 43 96 = 1 "No Toilet")(10 11 12 13 14 15 20 21 22 41 = 0 "Has Toilet"), gen(no_toilet)

tab no_toilet

recode v113 (10 11 12 13 14 20 21 30 31 33 41 61 62 71= 0 "Good Water Resource")(22 23 24 32 40 42 43 51 96= 1 "Poor Water Resource"), gen(poor_water)

tab poor_water

* b
tabulate year fever, row nofreq
// We can see that compared to 2001,
//  about 27% less children have reported a fever in the last two weeks.

// In 2001, about 11% less children reported a fever in the last two weeks than didn't.
// In 2007, about 65% less children reported a fever in the last two weeks than didn't.

* c 
reg fever treatment_district, vce(cluster NBER_District_ID)

* d
gen post = (year==2007)
reg fever treatment_district post, vce(cluster NBER_District_ID)

* e
gen inter = post*treatment_district
reg fever treatment_district post inter, vce(cluster NBER_District_ID)

// drop observation where toilet or water information is not available
drop if v116==97 
* f
reg fever treatment_district post inter no_toilet poor_water i.age v133 v136, vce(cluster NBER_District_ID)
