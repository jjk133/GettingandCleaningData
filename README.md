### Introduction

This script "run_analysis.R" reads in the raw data set from the "Human Activity Recognition Using Smartphones Data Set" project
URL - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- it takes the relevant data to be studied and builds a dataframe "fulldata" that contains the merged data sets
- additionally it builds a 2nd data frame "tidy_data" that contains the means of the mean & std variables grouped by activity and subject.
- it assumes all of the files are in the working R directory
- NOTE!!! The script assumes the user has constructed a separate data file "which_features.csv" that specifies with a TRUE or FALSE value which measurements the user wishes to retain or discard when building the dataframe.
I could or maybe should have built code within the script that identified the variables that were to be selected based on string search.
However, I thought this would be a more general way of selecting variables that may not easily conform to a string search.


### Building the "which_features.csv" file - SCRIPT WILL NOT RUN WITHOUT THIS FILE!!!

This file is derived from the raw data set "features.txt" file.
It adds a 3rd variable to the file which is a logical TRUE or FALSE,
depending on whether the user wants to include that measurement in their data analysis or not.
For the purpose of this project, only those measurements with "mean()" or "std()" were included in the analysis.
It is stored in the working directory as a comma delimited .csv file.


### Dependencies of run_analysis.R

The script assumes you have the "dplyr" and "plyr" packages installed.
It also assumes you have all the necessary raw data files residing in your working directory.
Those files are:
- X_test.txt            measurement data for the "test" data samples
- X_train.txt           measurement data for the "train" data samples
- subject_test.txt		specifies the subject for which a "test" measurement observation corresponds
- subject_train.txt     specifies the subject for which a "test" measurement observation corresponds
- y_test.txt            specifies the activity for which a "test" measurement observation corresponds
- y_train.txt           specifies the activity for which a "train" measurement observation corresponds

IT ALSO ASSUMES YOU HAVE THE USER-CREATED "which_features.csv" file IN YOUR WORKING DIRECTORY.


### Description of run_analysis.R flow

- load the dplyr library
- load the dplyr library
- read in the activities types ("activity_labels.txt") and assign them column names
- read in user-created file ("which_features.csv") that specifies which of the data measurements we want to retain
- read in the test data measurements file("X_test.txt") and only select the data specified in "which_features.csv"
- read in the test data file ("subject_test.txt") specifying who the subject is for a given measurement
- read in the test data file ("y_test.txt") specifying what the activity is for a given measurement
- join the test data activity code with the activity
- create a dataframe of appropriate length designating this is "TEST" data
- combine all the test dataframes into a single test dataframe (testdata)
- read in the training data measurements file("X_train.txt") and only select the data specified in "which_features.csv"
- read in the training data file ("subject_train.txt") specifying who the subject is for a given measurement
- read in the training data file ("y_train.txt") specifying what the activity is for a given measurement
- join the training data activity code with the activity
- create a dataframe of appropriate length designating this is "TRAIN" data
- combine all the training dataframes into a single training dataframe (traindata)
- combine the test and train dataframes into a single dataframe (fulldata)
- create the "tidy_data" dataframe, derived from "fulldata", which contains means of all observations grouped by activity/subject.
