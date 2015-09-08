run_analysis <- function() {
  
  ## this functions aims at producing a tidy data set based on the Samsung datas
  ## it requires the dplyr package
  
  ## it merges the training and the test sets to create one data set.
  ## it extracts only the measurements on the mean and standard deviation for each measurement. 
  ## it sets descriptive activity names to name the activities in the data set
  ## it appropriately labels the data set with descriptive variable names. 
  ## the, from the data set in step 4, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  rm(list=ls())
  library (dplyr)
  
  # read all the required files
  X_test <- read.table("./test/X_test.txt")
  X_train <- read.table("./train/X_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  subject_test <- read.table("./test/subject_test.txt")
  y_test <- read.table("./test/y_test.txt")
  y_train <- read.table("./train/y_train.txt")
  col_names <- read.table("features.txt")
  
  # name the column
  names(X_test) <- col_names$V2
  names(X_train) <- col_names$V2
  
  # bind the test and train files, and extracts only the mean and standard deviations variables
  col_mean <- regexpr("mean()",col_names$V2)!=-1
  col_std <- regexpr("std()",col_names$V2)!=-1
  X <- rbind(X_test, X_train)
  X_mean_std <- X[,col_mean | col_std]
  
  
  # bind with the activity and use the activity labels
  y <- rbind(y_test, y_train)
  names(y) <- c("activity_id")
  activity_labels <- read.table("activity_labels.txt")
  X_activity_labels <- activity_labels[match(y$activity_id,activity_labels[,1]),2]
  
  # bind with the subject 
  subject <- rbind(subject_test,subject_train)
  X <- cbind(subject,X_activity_labels, X_mean_std)
  
  # rename all the columns
  names(X) <- c("subject","activity",names(X_mean_std))
  
  # and finally summarise all the variables with the mean functions, group by subject and activity
  summarise_each(group_by(X,subject,activity),funs(mean))
  
  
}