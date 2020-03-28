/********************* Correlations part 2 - Interests vs ratings ****************************/
/* Save data in table */
data correlations2; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep age income; /* compare with age and income */
run;

/******* for males *******/
/* Save data in table */
data correlations2_m; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep age income; /* compare with age and income */
	if gender = 1;
run;

/******* for females ******/
data correlations2_f; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
	keep age income; /* compare with age and income */
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
   title 'Correlations: Participants Interests vs Ratings by Partner';
   proc corr kendall data=correlations2 noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
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
   title 'Correlations: Participants Interests vs Ratings by Partner (MALE)';
   proc corr kendall data=correlations2_m noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
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
   title 'Correlations: Participants Interests vs Ratings by Partner (FEMALE)';
   proc corr kendall data=correlations2_f noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr_o sinc_o intel_o fun_o amb_o shar_o; /* ratings by partner */
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;
   
   
   
   
/* Save data in table */
data correlations22; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep age income; /* compare with age and income */
run;

/******* for males *******/
/* Save data in table */
data correlations22_m; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep age income; /* compare with age and income */
	if gender = 1;
run;

/******* for females ******/
data correlations22_f; set WORK.speeddate;
	keep sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater
	movies concerts music shopping yoga; /* interests of participant */
	keep attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
	keep age income; /* compare with age and income */
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
   title 'Correlations: Participants Interests vs Importance to Participant';
   proc corr kendall data=correlations22 noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
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
   title 'Correlations: Participants Interests vs Importance to Participant (MALE)';
   proc corr kendall data=correlations22_m noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
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
   title 'Correlations: Participants Interests vs Importance to Participant (FEMALE)';
   proc corr kendall data=correlations22_f noprob;
	var sports tvsports exercise dining museums art hiking gaming clubbing reading tv theater movies concerts music shopping yoga age; /* interests of participant */
	with attr1_1 sinc1_1 intel1_1 fun1_1 amb1_1 shar1_1; /* importance to participant */
      ods select KendallCorr;
   run;
   ods listing;
   ods html close;
   
   proc template;
      delete Base.Corr.StackedMatrix;
   run;