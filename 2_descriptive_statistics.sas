FILENAME REFFILE '/folders/myfolders/project/speeddating.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.speed;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.speed; RUN;

/* RACE Bar Graph */
ods graphics / reset width=7in height=7in imagemap;

proc sgplot data=WORK.SPEED;
	title height=14pt "Race by Gender";
	footnote2 justify=left height=12pt "1=Black/African American       2=European/Caucasian-American 	3=Latino/Hispanic American      	4=Asian/Pacific Islander/Asian-American 	    5=Native American 	6=Other";
	vbar race / group=gender groupdisplay=cluster fillattrs=(transparency=0.25) 
		datalabel stat=percent;
	xaxis label="Race";
	yaxis grid;
run;

ods graphics / reset;
title;
footnote2;

/* CAREERS Define Pie template */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		entrytitle "Career Fields" / textattrs=(size=14);
		entryfootnote halign=left "1= Lawyer     2= Academic/Research     4= Doctor/Medicine     6= Creative Arts/Entertainment     7= General Business    9= International/Humanitarian Affairs" 
			/ textattrs=(size=10);
		layout region;
		piechart category=career_c / stat=pct start=90 categorydirection=clockwise 
			datalabelattrs=(size=10);
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=7in height=7in imagemap;

proc sgrender template=SASStudio.Pie data=WORK.SPEED;
run;

ods graphics / reset;

/* FIELD OF STUDY Define Pie template */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		entrytitle "Fields of Study" / textattrs=(size=14);
		entryfootnote halign=left "1= Law   3= Social Science, Psychologist 5= Engineering   8= Business/Econ/Finance 9= Education, Academia 10= Biological Sciences/Chemistry/Physics 11= Social Work 13=Political Science/International Affairs" 
			/ textattrs=(size=10);
		layout region;
		piechart category=field_cd / stat=pct start=90 categorydirection=clockwise 
			datalabelattrs=(size=12);
		endlayout;
		endgraph;
	end;
run;

ods graphics / reset width=6in height=6in imagemap;

proc sgrender template=SASStudio.Pie data=WORK.SPEED;
run;

ods graphics / reset;


/* GENDERED Field of Study Pie template */
proc template;
	define statgraph SASStudio.Pie;
		begingraph;
		entrytitle "Fields of Study" / textattrs=(size=14);
		entryfootnote halign=left "1= Law   3= Social Science, Psychologist 5= Engineering   8= Business/Econ/Finance 9= Education, Academia 10= Biological Sciences/Chemistry/Physics 11= Social Work 13=Political Science/International Affairs" 
			/ textattrs=(size=10);
		layout region;
		piechart category=field_cd / group=gender groupgap=2% stat=pct start=90 
			categorydirection=clockwise datalabellocation=inside 
			datalabelattrs=(size=12);
		endlayout;
		endgraph;
	end;
run;


/* GENDERED Stats for Shared Interested */
ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.SPEED chartype mean std min max var vardef=df;
	var age_o attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy 
		like pf_o_sha;
	class gender;
run;

/* GENDERED SAT SCORES for DESC STATS */

data SPEED; set 	WORK.SPEED;
   new = input(mn_sat, 8.);
   drop mn_sat;
   rename new=mn_sat;
run;

ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.SPEED chartype mean std min max var vardef=df;
	var mn_sat;
	class gender;
run;


/* GENDERED SAT SCORES for shared stuff */

data SPEED; set 	WORK.SPEED;
   new = input(income, 8.);
   drop income;
   rename new=income;
run;


/* GENDERED STATS for activities preferred */
ods noproctitle;
ods graphics / imagemap=on;

proc means data=WORK.SPEED chartype mean std min max median var vardef=df 
		qmethod=os;
	var go_out sports tvsports exercise dining museums art hiking gaming clubbing 
		reading tv theater movies concerts music shopping yoga;
	class gender;
run;

/* Goal for Event by Gender */
ods graphics / reset width=7in height=7in imagemap;

proc sgplot data=WORK.SPEED;
	title height=14pt "Primary Goal for the Event";
	footnote2 justify=left height=12pt "1 = Seemed like a fun night out     2 = To meet new people 	3 = To get a date 	4 = Looking for a serious relationship 	5 = To say I did it 	6 = Other";
	vbar goal / group=gender groupdisplay=cluster datalabel stat=percent;
	yaxis grid;
run;

ods graphics / reset;
title;
footnote2;

ods graphics / reset width=7in height=7in imagemap;

/* Output of Event */
proc sgplot data=WORK.SPEED;
	title height=14pt "Outcomes";
	footnote2 justify=left height=12pt "0 = Did Not Match     1 = Matched";
	vbar match / group=dec_o groupdisplay=cluster datalabel stat=percent;
	xaxis label="Match";
	yaxis grid;
run;

ods graphics / reset;
title;
footnote2;

/* Histogram for Age */
ods graphics / reset width=7in height=7in imagemap;

proc sgplot data=WORK.SPEED;
	title height=14pt "Distribution by Age";
	histogram age / showbins nbins=16 fillattrs=(color=CXdc20e2 transparency=0.25);
	xaxis label="Age";
	yaxis grid;
run;

ods graphics / reset;
title;

/* Histogram for Age : Women V Men*/
ods graphics / reset width=7in height=7in imagemap;

proc sort data=WORK.SPEED out=_HistogramTaskData;
	by gender;
run;

proc sgplot data=_HistogramTaskData;
	by gender;
	title height=14pt "Distribution of Age by Gender";
	histogram age / showbins nbins=15 fillattrs=(color=CX248b7f transparency=0.25);
	xaxis grid label="Age";
	yaxis grid;
run;

ods graphics / reset;
title;

proc datasets library=WORK noprint;
	delete _HistogramTaskData;
	run;