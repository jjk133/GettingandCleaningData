# run_analysis.R
# 
# This script reads in the raw data set from the "Human Activity Recognition Using Smartphones Data Set" project
# URL - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# - it takes the relevant data to be studied and builds a dataframe "fulldata" that contains the merged data sets
# - additionally it builds a 2nd data frame "tidy_data" that contains the means of the mean & std variables
#   grouped by activity and subject.
# - it assumes all of the files are in the working R directory
# - NOTE!!! The script assumes the user has constructed a separate data file "which_features.csv" that specifies
#           with a TRUE or FALSE value which measurements the user wishes to retain or discard when building the dataframe.
#
# load the dplyr library
library(dplyr)
# load the plyr library
library(plyr)
# read in the activities types and assign them column names
activity_labels <- read.csv("activity_labels.txt", header = FALSE, sep = "")
colnames(activity_labels) <- c("activity_code","activity")
# read in user-created file that specifies which of the data measurements we want to retain.
which_features <- read.csv("which_features.csv",header = FALSE)
colnames(which_features) <- c("measurement_colnum","measurement","select_measurement")
#
# TEST Data
# read in the test data measurements and only select the data specified in "which_features.csv"
testdata.measurements <- select(read.csv("X_test.txt", header = FALSE, sep = ""),
                                which_features$measurement_colnum[which_features$select_measurement])
colnames(testdata.measurements) <- which_features$measurement[which_features$select_measurement]
# read in the test data specifying who the subject is for a given measurement
testdata.subject <- read.csv("subject_test.txt",header = FALSE)
colnames(testdata.subject) <- c("subject")
# read in the test data specifying what the activity is for a given measurement
testdata.activity <- read.csv("y_test.txt",header = FALSE)
colnames(testdata.activity) <- c("activity_code")
# join the activity code with the activity
testdata.activity <- select(join(testdata.activity,activity_labels,by=NULL,type="left",match="all"),activity)
# create a dataframe that labels the test data as "TEST"
testdata.datatype <- data.frame(matrix(ncol = 1, nrow = nrow(testdata.activity)))
testdata.datatype[,] <- "TEST"
colnames(testdata.datatype) <- c("datatype")
# combine all the test dataframes into a single test dataframe
testdata <- cbind(testdata.datatype,testdata.activity,testdata.subject,testdata.measurements)
#
# TRAIN Data
# read in the test data measurements and only select the data specified in "which_features.csv"
traindata.measurements <- select(read.csv("X_train.txt", header = FALSE, sep = ""),
                                which_features$measurement_colnum[which_features$select_measurement])
colnames(traindata.measurements) <- which_features$measurement[which_features$select_measurement]
# read in the train data specifying who the subject is for a given measurement
traindata.subject <- read.csv("subject_train.txt",header = FALSE)
colnames(traindata.subject) <- c("subject")
# read in the train data specifying what the activity is for a given measurement
traindata.activity <- read.csv("y_train.txt",header = FALSE)
colnames(traindata.activity) <- c("activity_code")
# join the activity code with the activity
traindata.activity <- select(join(traindata.activity,activity_labels,by=NULL,type="left",match="all"),activity)
# create a dataframe that labels the test data as "TRAIN"
traindata.datatype <- data.frame(matrix(ncol = 1, nrow = nrow(traindata.activity)))
traindata.datatype[,] <- "TRAIN"
colnames(traindata.datatype) <- c("datatype")
# combine all the train dataframes into a single train dataframe
traindata <- cbind(traindata.datatype,traindata.activity,traindata.subject,traindata.measurements)
# combine the test and train dataframes into a single fulldata dataframe
fulldata <- rbind(testdata,traindata)
# clean up interim data sets
rm(testdata.datatype,testdata.activity,testdata.subject,testdata.measurements)
rm(traindata.datatype,traindata.activity,traindata.subject,traindata.measurements)
# create tidy_data
tidy_data <- aggregate(fulldata[c(4:69)], by=fulldata[c("activity","subject")], FUN=mean, na.rm=TRUE)
