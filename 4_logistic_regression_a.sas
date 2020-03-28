/*
Submit some meaningful correlations or regressions from your project. 

Do this in a Word doc, with brief explanation as to why it is meaningful 
Quality, rather than quantity is the key here. 1-2 pages of writing at most, a few small tables/graphics. 
No code needed, just context
*/


/*
filename ref1 "/folders/myfolders/Project/Data/speed-dating_zip/data/speed-dating_json.json";
libname proj JSON fileref=ref1;
*/

/*Investigation of this JSON file shows that it doesn't include all important variables we need for the study.
Thus, we import the CSV file.*/

%web_drop_table(WORK.speeddate);


FILENAME REFFILE "/folders/myfolders/Project/Speed_Dating_Data.csv" TERMSTR=CR;

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.speeddate;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.speeddate; RUN;


%web_open_table(WORK.speeddate);

/*Total rows: 8378 Total columns: 195*/

/*Apparently there are inconsistent scales for waves 6,7,8, and 9. 
Thus, we exclude them from the rest of analysis.*/

data work.speeddate; set work.speeddate;
	if wave<6 or wave>9;
run;

data work.speeddate; set work.speeddate;
	keep
		iid
		id
		gender
		idg
		condtn
		wave
		round
		position
		positin1
		order
		partner
		pid
		match
		int_corr
		samerace
		age_o
		race_o
		pf_o_att
		pf_o_sin
		pf_o_int
		pf_o_fun
		pf_o_amb
		pf_o_sha
		dec_o
		attr_o
		sinc_o
		intel_o
		fun_o
		amb_o
		shar_o
		like_o
		prob_o
		met_o
		age
		field
		field_cd
		undergra
		mn_sat
		tuition
		race
		imprace
		imprelig
		from
		zipcode
		income
		goal
		date
		go_out
		career
		career_c
		sports
		tvsports
		exercise
		dining
		museums
		art
		hiking
		gaming
		clubbing
		reading
		tv
		theater
		movies
		concerts
		music
		shopping
		yoga
		exphappy
		expnum
		attr1_1
		sinc1_1
		intel1_1
		fun1_1
		amb1_1
		shar1_1;
run;

/*Total rows: 6816 Total columns: 75*/

/* 
Empirical Model 1:
Most Important Traits in Males to be Chosen for Date
*/

/* Population Means of Men */
proc means data=work.speeddate (where=(gender=1));
	var 
		attr_o
		sinc_o
		intel_o
		fun_o
		amb_o
		shar_o;
run;

/* Density Plots of Each Male Attribute (as rated by date) */
proc sgplot data=work.speeddate (where=(gender=1));
	histogram attr_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density attr_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=1));
	histogram sinc_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density sinc_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=1));
	histogram intel_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density intel_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=1));
	histogram fun_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density fun_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=1));
	histogram amb_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density amb_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=1));
	histogram shar_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density shar_o / type=kernel group= dec_o;
run;


/* Logistic Regression Model of Date Selection of Men by Women*/
proc logistic data=work.speeddate (where=(gender=1)) descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o;
run;

/* Population Means of Women */
proc means data=work.speeddate (where=(gender=0));
	var 
		attr_o
		sinc_o
		intel_o
		fun_o
		amb_o
		shar_o;
run;

/* Density Plots of Each Female Attribute (as rated by date) */
proc sgplot data=work.speeddate (where=(gender=0));
	histogram attr_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density attr_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=0));
	histogram sinc_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density sinc_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=0));
	histogram intel_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density intel_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=0));
	histogram fun_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density fun_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=0));
	histogram amb_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density amb_o / type=kernel group= dec_o;
run;

proc sgplot data=work.speeddate (where=(gender=0));
	histogram shar_o / group = dec_o bindwidth=1.5 transparency=0.5;
	density shar_o / type=kernel group= dec_o;
run;

/* Logistic Regression Model of Date Selection of Men by Women*/
proc logistic data=work.speeddate (where=(gender=0)) descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o;
run;

/* Logistic Regression Model with Interaction Variable on Gender*/
proc logistic data=work.speeddate descending;
	model dec_o = 
		attr_o 
		sinc_o 
		intel_o 
		fun_o 
		amb_o
		shar_o
		attr_o*gender
		sinc_o*gender
		intel_o*gender
		fun_o*gender
		amb_o*gender
		shar_o*gender;
run;

/* Logistic Regression Model with Interaction Variable on Gender*/
/* Removed non-significant variables based on p-values */
proc logistic data=work.speeddate descending;
	model dec_o = 
		attr_o 
		sinc_o 
		fun_o 
		amb_o
		shar_o
		attr_o*gender
		intel_o*gender;
run;
