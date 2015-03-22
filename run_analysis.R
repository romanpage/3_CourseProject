###################################
# course project
# R script
###################################

# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Good luck!

## load packages
library(dplyr)

## set work directory
setwd(".../3_Getting and Cleaning Data/data")

## check for and creating directories
file.exists(".../3_Getting and Cleaning Data/data")

## download file from the web
#temp <- tempfile()
#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, temp)
#data <- read.table(unz(temp, "a1.dat"))
#unlink(temp)
#dateDownloaded <- date()
#dateDownloaded

## read files into work directory
subject_test <- read.table(".../3_Getting and Cleaning Data/data/UCI HAR Dataset/test/subject_test.txt",
                           col.names="subject")
x_test <- read.table("../3_Getting and Cleaning Data/data/UCI HAR Dataset/test/x_test.txt")
y_test <- read.table(".../3_Getting and Cleaning Data/data/UCI HAR Dataset/test/y_test.txt",
                     col.names="activity")

subject_train <- read.table(".../3_Getting and Cleaning Data/data/UCI HAR Dataset/train/subject_train.txt",
                            col.names="subject")
x_train <- read.table(".../3_Getting and Cleaning Data/data/UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("../3_Getting and Cleaning Data/data/UCI HAR Dataset/train/y_train.txt",
                      col.names="activity")

features_dataset <- read.table(".../3_Getting and Cleaning Data/data/UCI HAR Dataset/features.txt",
                               stringsAsFactors=FALSE)
features_names <- features_dataset$V2

# name columns
colnames(x_test) <- features_names
colnames(x_train) <- features_names

# check
ls()

tbl_df(subject_test)
str(subject_test)
tbl_df(x_test)
str(x_test)
tbl_df(y_test)
str(y_test)
tbl_df(subject_train)
str(subject_train)
tbl_df(x_train)
str(x_train)
tbl_df(y_train)
str(y_train)

## 1. Merges the training and the test sets to create one data set.

test_dataset <- cbind(subject_test, y_test, x_test)
train_dataset <- cbind(subject_train, y_train, x_train)
test_train_dataset <- rbind(test_dataset, train_dataset)
tbl_df(test_train_dataset)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement (only the 79 variables that contain "mean()" and "std()") 
one_dataset <- test_train_dataset[, c(1, 2, grep("mean()", names(test_train_dataset)), grep("std()", names(test_train_dataset)))]
tbl_df(one_dataset)

## 3. Uses descriptive activity names to name the activities in the data set
one_dataset$activity <- factor(one_dataset$activity,
                               levels = c(1,2,3,4,5,6),
                               labels = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")) 
tbl_df(one_dataset)

## 4. Appropriately labels the data set with descriptive variable names.
#Done within read.table()

## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (perform a groupby for the two fields you identified then a summarise_each to execute the function 'mean'). And then generates a tidy data text file that meets the principles of tidy data (tidy_dataset (local data frame [180 x 81])).
grouped <- group_by(one_dataset, subject, activity)
summarised <- summarise_each(grouped, funs(mean))

tidydata <- summarised
tbl_df(tidydata)

## upload data set
write.table(tidydata, file = ".../3_Getting and Cleaning Data/data/tidy_dataset.txt", row.name=FALSE)

# test view
test_data <- read.table(".../3_Getting and Cleaning Data/data/tidy_dataset.txt", header = TRUE) 
View(test_data)

