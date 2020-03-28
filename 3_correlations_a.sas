FILENAME REFFILE '/folders/myfolders/Project/Speed Dating Data-1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.speeddate;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.speeddate; RUN;

data work.speeddate; set work.speeddate;
	if wave<6 or wave>9;

data work.speeddate; set work.speeddate;
	attr5_12 = input(attr5_1, 10.);
	sinc5_12= input(sinc5_1, 10.);
	fun5_12 = input(fun5_1, 10.);
	intel5_12 = input(intel5_1, 10.);
	amb5_12 = input(amb5_1, 10.);
	rename attr5_12 = attr5_1
		sinc5_12 = sinc5_1
		fun5_12 = fun5_1
		intel5_12 = intel5_1
		amb5_12 = amb5_1;
	drop attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1;
run;

/********************* Correlations part 1 - relationship between participants self-ratings vs rating by others ****************************/
/* Save data in table */
data correlations1; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr3_1 sinc3_1 intel3_1 fun3_1 amb3_1; /* participant self ratings */
	keep exphappy imprace imprelig like;
run;

/******* for males *******/
/* Save data in table */
data correlations1_m; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr3_1 sinc3_1 intel3_1 fun3_1 amb3_1; /* participant self ratings */
	keep exphappy imprace imprelig like;
	if gender = 1;
run;

/******* for females ******/
data correlations1_f; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr3_1 sinc3_1 intel3_1 fun3_1 amb3_1; /* participant self ratings */
	keep exphappy imprace imprelig like;
	if gender = 0;
run;

/********* Compare partner vs participant *************/
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings vs Partners Ratings';
   proc corr pearson kendall data=correlations1 noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select PearsonCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Male */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings vs Partners Ratings (MALE)';
   proc corr kendall data=correlations1_m noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Female */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings vs Partners Ratings (FEMALE)';
   proc corr kendall data=correlations1_f noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
   

/********* Compare partner vs participant (self percieved) *************/
/* Save data in table */
data correlations11; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1; /* participant thinks perceived */
run;

/******* for males *******/
/* Save data in table */
data correlations11_m; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1; /* participant thinks perceived */
	if gender = 1;
run;

/******* for females ******/
data correlations11_f; set WORK.speeddate;
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1; /* participant self ratings */
	if gender = 0;
run;

   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: How Participant Believes Theyre Perceived vs Partners Ratings';
   proc corr kendall data=correlations11 noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o;
	with attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Male */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: How Participant Believes Theyre Perceived vs Partners Ratings (MALE)';
   proc corr kendall data=correlations11_m noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o;
	with attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Female */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: How Participant Believes Theyre Perceived vs Partners Ratings (FEMALE)';
   proc corr kendall data=correlations11_f noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o;
	with attr5_1 sinc5_1 fun5_1 intel5_1 amb5_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run; 
   
   
   
   
   
/********* Participant ratings *************/
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings';
   proc corr kendall data=correlations1 noprob;
	var attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Male */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings (MALE)';
   proc corr kendall data=correlations1_m noprob;
	var attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Female */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Participants Self Ratings (FEMALE)';
   proc corr kendall data=correlations1_f noprob;
	var attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
   
   
   
   
   
/********* Partners ratings *************/
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Partners Ratings';
   proc corr kendall data=correlations1 noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Male */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Partners Ratings (MALE)';
   proc corr kendall data=correlations1_m noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Female */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Partners Ratings (FEMALE)';
   proc corr kendall data=correlations1_f noprob;
   	var attr_o sinc_o intel_o fun_o amb_o shar_o imprace imprelig exphappy like;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
   
   
   
   
/********* Compare quality important to participant vs participant (self rating) *************/
/* Save data in table */
data correlations12; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1; /* participant thinks perceived */
run;

/******* for males *******/
/* Save data in table */
data correlations12_m; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1; /* participant thinks perceived */
	if gender = 1;
run;

/******* for females ******/
data correlations12_f; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1; /* participant self ratings */
	if gender = 0;
run;

   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Importance of Quality to Participant vs Participant Self Ratings';
   proc corr kendall data=correlations12 noprob;
   	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Male */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Importance of Quality to Participant vs Participant Self Ratings (MALE)';
   proc corr kendall data=correlations12_m noprob;
   	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
/* Female */
   proc template;
      edit Base.Corr.StackedMatrix;
         column (RowName RowLabel) (Matrix) * (Matrix2);
         edit matrix;
            cellstyle _val_  = -1.00 as {backgroundcolor=CXEEEEEE},
                      _val_ <= -0.75 as {backgroundcolor=green},
                      _val_ <= -0.50 as {backgroundcolor=lightgreen},
                      _val_ <= -0.25 as {backgroundcolor=lightorange},
                      _val_ <= -0.10 as {backgroundcolor=lightyellow},
                      _val_ <= 0.10 as {backgroundcolor=white},
                      _val_ <=  0.25 as {backgroundcolor=lightyellow},
                      _val_ <=  0.50 as {backgroundcolor=lightorange},
                      _val_ <=  0.75 as {backgroundcolor=lightgreen},
                      _val_ <   .99 as {backgroundcolor=green},
                      _val_ >   .99 as {backgroundcolor=CXEEEEEE},
                      _val_  =  1.00 as {backgroundcolor=CXEEEEEE};
            end;
         end;
      run;
   
   ods listing close;
   ods graphics on;
   title 'Correlations: Importance of Quality to Participant vs Participant Self Ratings (FEMALE)';
   proc corr kendall data=correlations12_f noprob;
   	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1;
	with attr3_1 sinc3_1 fun3_1 intel3_1 amb3_1;
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run; 