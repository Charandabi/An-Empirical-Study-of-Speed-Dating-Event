
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

data work.speeddate; set work.speeddate;
   new = input(income, comma10.);
   drop income;
   rename new=income;
run;

data work.speeddate; set work.speeddate;
   new = input(mn_sat, 8.);
   drop mn_sat;
   rename new=mn_sat;
run;

data work.speeddate; set work.speeddate;
   new = input(tuition, 8.);
   drop tuition;
   rename new=tuition;
run;

proc export data=work.speeddate 
outfile='/folders/myfolders/Project/speeddate_reduced.csv'  
dbms=csv;
run;
