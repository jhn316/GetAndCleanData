---
title: "README"
author: "jhn316"
date: "Saturday, September 13, 2014"
---
###Viewing the tidy data file
To upload the supplied tidy data into RStudio, save the file "TidyData.txt" to your
RStudio working directory and then run the following code snippet.


_TidyData <- read.table("TidyData.txt", header = TRUE)_

_View(TidyData)_

###Description of the run_analysis.R code

The raw data in the form of a zip file is downloaded to the current working directory and upon unzipping is located in a subdirectory named "UCI HAR Dataset". This directory contains four .txt files, "activity_labels.txt", "features.txt", "features_info.txt", "README.txt". This directory also contains two subdirectories named "test" and "train". Each of these subdirectories contain three .txt files named "X_train.txt", "y_train.txt" and "subject_train.txt" which will be used in the analysis.

The libraries dplyr, tidyr and plyr are used in the analysis. The wrapper tbl_df is used throught the analysis for ease of display. The files "X_train.txt", "y_train.txt" and "subject_train.txt" are read into the data frames X_train, y_train and subject_train respectively. "X_test.txt", "y_test.txt" and "subject_test.txt" are read into the data frames X_test, y_test and subject_test respectively. Both operations are done using read.csv() with header=FALSE.

Next, the data frames test_data and train_data data frames are created by using cbind() on X_test/train, y_test/train and subject_test/train. respectively.

**As requested in question #1, the test and training data are next merged using rbind() into data frame merged_data**

The column names of the features are read in using read.table() on "features.txt" and the column names are assigned to the merged data set using names(merged_data) <- c(...).

**As requested in question #2, the measurements on the mean and standard deviation for each measurement are extracted using select() with contains("Mean") and contains("std") and read into the data frame MeansStdMergedData this results in 86 features (i.e.columns) plus 2 more columns for Activity type and subject number**

**As requested in question #3, descriptive activity names were used to name the activities in the data set using revalue()**

**As requested in question #5 is addressed with a nested for loop code segment. From the data set MeansStdMergedData, a second, independent tidy data set with the average of each variable for each activity and each subject i.e. 6 acitivities times 30 subjects which produces 6x30 = 180 rows with 88 columns. The resulting data is read into a data frame called TidyData**

**As requested in question #4 descriptive variable names are assigned to the features using the information provided in the "features_info.txt" file.**

Finally, the tidy data output is written to a text file using write.table() with row.name=FALSE
