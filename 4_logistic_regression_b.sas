data speeddating; set work.speeddating;
run;


/* Logistic Regression Model 4 */
/* basically Model 3, with gender restricted to Males and the addition of imprace and imprelig */
proc logistic data=work.speeddating (where=(gender=1)) descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		imprace
		imprelig;
run;


/* Logistic Regression Model 5 */
/* basically Model 3, with gender restricted to Females and the addition of imprace and imprelig */
proc logistic data=work.speeddating (where=(gender=0)) descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		imprace
		imprelig;
run;

/* Logistic Regression Model 6 */
/* basically Model 3, with no gender restricted  and the addition of the interaction with gener and imprace/imprelig respectively */
proc logistic data=work.speeddating descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		imprace
		imprelig
		imprace*gender
		imprelig*gender
		attr_o*gender
		sinc_o*gender
		intel_o*gender
		fun_o*gender
		amb_o*gender
		shar_o*gender;
run;

/* Modification to highlight that since there was no signifance for males or females, then interaction also does have significance */
/* Included only significant interactions from the attributes */
/* Indepht of Model not needed */
proc logistic data=work.speeddating descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		imprace
		imprelig
		imprace*gender
		imprelig*gender
		attr_o*gender
		intel_o*gender;
run;

/* Logistic Regression Model 6 */
/* basically Model 3, with the addition of age and significant interactions*/
proc logistic data=work.speeddating descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		age_o
		attr_o*gender
		intel_o*gender;
		
run;