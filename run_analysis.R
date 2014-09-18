#Load the required libraries
library(dplyr)
library(tidyr)
library(plyr)

#Download the data for question2 from the net
setInternet2(TRUE)
A1 <- "downloaded.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile=d)
A2 <- unzip(A1,exdir = ".")

#Imports the test data into R
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table ("./UCI HAR Dataset/test/X_test.txt",comment.char = "",colClasses="numeric")
y_test <- read.table ("./UCI HAR Dataset/test/y_test.txt",comment.char = "",colClasses="numeric")

subject_test <- tbl_df(subject_test)
X_test <- tbl_df(X_test)
y_test <- tbl_df(y_test)

#Imports the train data into R
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table ("./UCI HAR Dataset/train/X_train.txt",comment.char = "",colClasses="numeric")
y_train <- read.table ("./UCI HAR Dataset/train/y_train.txt",comment.char = "",colClasses="numeric")

subject_train <- tbl_df(subject_train)
X_train <- tbl_df(X_train)
y_train <- tbl_df(y_train)

test_data <- cbind(subject_test, X_test, y_test)
train_data <- cbind(subject_train, X_train, y_train)

#1. Merges the training and the test sets to create one data set.
merged_data <- rbind(test_data,train_data)

column_names <- read.table ("./UCI HAR Dataset/features.txt", header = FALSE)
column_names <- tbl_df(column_names)

#Assign column names to the merged data set
names(merged_data) <- c("SubjectNumber", as.character(column_names$V2), "ActivityType")

#2 Extracts only the measurements on the mean and standard deviation for each measurement
MeansStdMergedData <- select(merged_data, SubjectNumber, contains("Mean"), contains("std"), ActivityType)

#3 Uses descriptive activity names to name the activities in the data set
MeansStdMergedData$ActivityType <- as.factor(MeansStdMergedData$ActivityType)


MeansStdMergedData$ActivityType <- revalue(MeansStdMergedData$ActivityType, 
                                c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", 
                                  "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING", 
                                  "5" = "STANDING", "6" = "LAYING"))


MeansStdMergedData <- tbl_df(MeansStdMergedData)



#5 From the data set MeansStdMergedData, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
Activities <- c("WALKING", "WALKING_UPSTAIRS", 
               "WALKING_DOWNSTAIRS", "SITTING", 
               "STANDING", "LAYING")
Subjects <- c(1:30)

aa <- data.frame()
bb <- data.frame()    
cc <- data.frame()
dd <- data.frame()
for(i in Activities){
    for(j in Subjects){
        aa <- subset(MeansStdMergedData, MeansStdMergedData$ActivityType == i)
        aa <- mutate(aa, ActivityType = as.character(ActivityType) )
        bb <- subset(aa, aa$SubjectNumber == j)
        cc <- summarise_each(bb, funs(mean), -contains("ActivityType"))
        cc <- cbind(cc,i)
        dd <- rbind(dd, cc)
        }
}
TidyData <- rename(dd, c("i"= "ActivityType"))

#4 Appropriately labels the data set with descriptive variable names.
Names <- names(TidyData)
Names <- gsub("tB", "TimeDomainB", Names)
Names <- gsub("tG", "TimeDomainG", Names)
Names <- gsub("fB", "FrequencyDomainB", Names)
names(TidyData) <- Names

#Final tidy data set is written to "TidyData.txt"
TidyData <- tbl_df(TidyData)
write.table(TidyData, "TidyData.txt", row.name=FALSE)


