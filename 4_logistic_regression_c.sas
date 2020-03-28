
/*
filename ref1 "/folders/myfolders/Project/Data/speed-dating_zip/data/speed-dating_json.json";
libname proj JSON fileref=ref1;
*/

/*Investigation of this JSON file shows that it doesn't include all important variables we need for the study.
Thus, we import the CSV file.*/

FILENAME REFFILE '/folders/myfolders/Project/Data/speed-dating_zip/data/Speed Dating Data-1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.speeddate;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.speeddate; RUN;

/*Total rows: 8378Total columns: 195*/

/*8.The effect of self-perception */

data WORK.SPEEDDATE; set WORK.SPEEDDATE;
	attrdiff=abs(attr3_1 - attr_o); 
	sincdiff=abs(sinc3_1 - sinc_o);
	inteldiff=abs(intel3_1-intel_o);
	fundiff=abs(fun3_1-fun_o);
	ambdiff=abs(amb3_1-amb_o); 
run;	

ods noproctitle;
ods graphics / imagemap=on;

proc logistic data=WORK.SPEEDDATE plots=(effect);
	class gender / param=glm;
	model dec_o(event='1')=attrdiff sincdiff inteldiff fundiff ambdiff 
	attrdiff*gender sincdiff*gender inteldiff*gender fundiff*gender ambdiff*gender/ lackfit rsquare  
		link=logit technique=fisher;
run;

