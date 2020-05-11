# CodeBook

Steps:

The R script, run_analysis.R, reads the data, processes it, and writes a file in the desired form.

1. Training and Testing data is combined into a single data frame. 
2. Data columns are added based on features.
3. Mean and standard deviations are calculated where needed.
4. Activity labes are given.
5. Mean is calculated for each measurement after grouping subject and activity.
6. Dataset is written to data_table.txt.

Measurement types that are found in the features file are listed here:

tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z, tGravityAcc_mean_X, tGravityAcc_mean_Y, tGravityAcc_mean_Z, tBodyAccJerk_mean_X, tBodyAccJerk_mean_Y, tBodyAccJerk_mean_Z, tBodyGyro_mean_X, BodyGyro_mean_Y, tBodyGyro_mean_Z, tBodyGyroJerk_mean_X, tBodyGyroJerk_mean_Y, tBodyGyroJerk_mean_Z, tBodyAccMag_mean, tGravityAccMag_mean, tBodyAccJerkMag_mean, tBodyGyroMag_mean, tBodyGyroJerkMag_mean, fBodyAcc_mean_X, fBodyAcc_mean_Y, fBodyAcc_mean_Z, fBodyAccJerk_mean_X, fBodyAccJerk_mean_Y, fBodyAccJerk_mean_Z, fBodyGyro_mean_X, fBodyGyro_mean_Y, fBodyGyro_mean_Z, fBodyAccMag_mean, fBodyAccJerkMag_mean, etc.
