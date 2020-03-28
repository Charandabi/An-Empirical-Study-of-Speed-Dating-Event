/********************* Correlations part 3 - Preference vs Selection ****************************/
/* Save data in table */
data correlations3; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	keep attr sinc intel fun amb shar; /* ratings of partner */
	if dec = 1;
run;

/******* for males *******/
/* Save data in table */
data correlations3_m; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	keep attr sinc intel fun amb shar; /* ratings of partner */
	if dec = 1;
	if gender = 1;
run;

/******* for females ******/
data correlations3_f; set WORK.speeddate;
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	keep attr sinc intel fun amb shar; /* ratings of partner */
	if dec = 1;
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
   title 'Correlations: Preferences of Participants vs Participants Ratings of Matches ';
   proc corr kendall data=correlations3 noprob;
	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	with attr sinc intel fun amb shar; /* ratings by partner */
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
   title 'Correlations: Preferences of Participants vs Participants Ratings of Matches (MALE)';
   proc corr kendall data=correlations3_m noprob;
	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	with attr sinc intel fun amb shar; /* ratings by partner */
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
   title 'Correlations: Preferences of Participants vs Participants Ratings of Matches (FEMALE)';
   proc corr kendall data=correlations3_f noprob;
	var attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* participant looks for */
	with attr sinc intel fun amb shar; /* ratings by partner */
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;