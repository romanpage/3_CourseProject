## Course Project

### Introduction

R script called run_analysis.R that does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### R script

* loads packages
* sets work directory
* checks for and creates directories
* downloads file from the web
* reads files into work directory and names columns
* checks datasets
* merges the training and the test sets to create one_dataset
* extracts only the measurements on the mean and standard deviation for each measurement (only the 79 variables that contain "mean()" and "std()"
* changes activity numbers to descriptive activity labels
* performs a groupby for the two fields you identified then a summarise_each to execute the function 'mean').
*generates tidy_dataset.txt that meets the principles of tidy data (local data frame [180 x 81])).
* uploads tidy_dataset.txt
* control reads and views tidy_dataset.txt



