/* 
This is a template homework.
The structure may change based on the homework or your programming style

Nevertheless, you will find it useful to commment what you do
so collaborators understand what you are doing


*/

** Load data
*! The next line will depend on the working directory you are currently at. 
*! In my case, I assume my WD is the -root- folder (homework_template)

** Start log.
log using do_files\homework.log, text replace

use data\oaxaca, clear

** Data exploration

sum *

** only for required variables

sum lnwage educ age agesq single married divorced

** Note: There are some missing data. Either Keep not missing, or use "if" conditions for other analysis

** Correlation between Wages and lnwage

corr lnwage educ age agesq single married divorced if lnwage!=.

** We may only need one column. 
** some of the results are in r-objects. 
** Tyle -return list- to see what is left after corr

** What if we copy the matrix
matrix corr_hw = r(C)
** but only 1 col is needed:

matrix corr_hw = corr_hw[1,....]

** A simple Correlation table
** We can use esttab! But is it installed?

** Now it will be
ssc install estout

esttab matrix(corr_hw), mlabels(, none) md

** -md- will formated nicely for the homework.
** and Markdown tables only accepts one row. So we need -mlabels(,none)

** lets not forget saving for later! 
** we can use qmd for that. 
** I still do not know how to use -nbstata-. Lets just do it all here.
** Do not forget, they have to go into -resources- folder
esttab matrix(corr_hw) using resources/tb1, mlabels(, none) md replace

** What about some plots?

scatter lnwage age
scatter lnwage educ 

** and for mstatus?
** lets create a new variable first

gen     mstatus = 1 if single==1
replace mstatus = 2 if married==1
replace mstatus = 3 if divorced==1

label var mstatus "Marital Status"
** This creates labels for each invidual value of mstatus
label define mstatus 1 "Single" 2 "Married" 3 "Divorced", modify
** This one assignes the values-tag to the variable
label values mstatus mstatus 

** So the plot? What about a density plot?

two (kdensity lnwage if mstatus ==1 ) ///
	(kdensity lnwage if mstatus ==2 ) ///
	(kdensity lnwage if mstatus ==3 ) , ///
	legend(order(1 "Single" 2 "Married" 3 "Divorced"))
	
** Lets not forget saving it all

** ok From the top!

scatter lnwage age, ytitle("Log(Wages)") xtitle("Age in Years")
graph export resources/fig1.png, width(1000) replace
scatter lnwage educ, ytitle("Log(Wages)") xtitle("Yrs of Education") 	
graph export resources/fig2.png, width(1000) replace

two (kdensity lnwage if mstatus ==1 ) ///
	(kdensity lnwage if mstatus ==2 ) ///
	(kdensity lnwage if mstatus ==3 ) , ///
	legend(order(1 "Single" 2 "Married" 3 "Divorced"))
	
graph export resources/fig3.png, width(1000) replace	

** Now the regressions. How many do we need?
** For now 2
regress lnwage age educ i.mstatus
est sto m1
regress lnwage age educ i.mstatus agesq
est sto m2

esttab m1 m2 using resources/reg1, se label nomtitle b(3) md replace

** Test for misspecification and heteroskedasiticy
** Lets use the canned commands

regress lnwage age educ i.mstatus agesq

** But how do we export them?
** lets use a logfile. meed to use -text nomsg- options
** and add the "display lines on top and bottom"
 
log using resources/ovtest, name(ovtest) replace text nomsg
estat ovtest
log close ovtest

log using resources/hettest, name(hettest) replace text nomsg
estat hettest
log close hettest

log close

