---
title: "CodeBook"
author: "jhn316"
date: "Saturday, September 13, 2014"
output: html_document
---

### General points to note
I have followed the guidlines given for the project by community TA David Hood in 
the following thread 

https://class.coursera.org/getdata-007/forum/thread?thread_id=49

The raw data is read contains four .txt files, "activity_labels.txt", "features.txt", "features_info.txt", "README.txt". This directory also contains two subdirectoies named "test" and "train". Each of these subdirectories contain three .txt files named "X_train.txt", "y_train.txt", "subject_train.txt" and "X_test.txt", "y_test.txt", "subject_test.txt"etc..which will be used in the analysis. 


*y_train/test* - data labels are from 1 to 6 (type of activity), 1 col, 2947 rows
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

*X_train/test* -  measured parameters  561 col, 2947 rows which corresponds to the list of 561 features named in features.txt. A detailed description of the features and the naming convention is found in the "feature_info.txt" file.

*Subject_test/train* -  data labels from 1 to 30 (corresponds to 30 persons on which the experiments were performed identified by the numbers 1 through 30), 1 col, 2947 rows

The data in *subject_test*, *X_test*, *y_test* are bound together by columns to form a *test_data dataset* and also the data in *subject_train*, *X_train*, *y_train* are bound together by columns to form a *train_data dataset*. 

The *test_data* and *train_data* datasets are then bound together by rows to form the 
*merged_data* dataset.

The names of the features (i.e. the column names) are taken from the "feature.txt" file and input to the merged_data dataset. The activity type and subject number heading are manually input to the appropriate columns.

The features which contain means and standard deviations are selected by using the select() funtion on the column names searching for the strings "Mean" and "std" (using the contains() parameter of the select() function) and saved in a data set
*MeansStdMergedData*. The activites signified by the numbers 1 thourgh 6 are manually replaced with descriptive words using the data labels in *y_train/test*.

A nested for loop is used to calculate the the average of each variable for each activity and each subject in the *MeansStdMergedData* dataset and is saved into the *TidyData* data set. 

The feature names of the *TidyData* dataset are renamed using gsub() to be more easily understood (the feature names are changed thus, "t" is replaced by "TimeDomain" and "f" by "FrequencyDomain").

Finally, the appropriately named, tidy data set *TidyData*, is written to a text file. 


###Feature Selection 

**The following is copied from "feature_info.txt" file.**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

