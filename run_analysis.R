{
  rm(list=ls())
  library (dplyr)
  X_test <- read.table("./test/X_test.txt")
  X_train <- read.table("./train/X_train.txt")
  subject_train <- read.table("./train/subject_train.txt")
  subject_test <- read.table("./test/subject_test.txt")
  y_test <- read.table("./test/y_test.txt")
  y_train <- read.table("./train/y_train.txt")
  col_names <- read.table("features.txt")
  names(X_test) <- col_names$V2
  names(X_train) <- col_names$V2
  col_mean <- regexpr("mean()",col_names$V2)!=-1
  col_std <- regexpr("std()",col_names$V2)!=-1
  X <- rbind(X_test, X_train)
  X_mean_std <- X[,col_mean | col_std]
  
  y <- rbind(y_test, y_train)
  names(y) <- c("activity_id")
  activity_labels <- read.table("activity_labels.txt")
  X_activity_labels <- activity_labels[match(y$activity_id,activity_labels[,1]),2]
  
  subject <- rbind(subject_test,subject_train)
  
  X <- cbind(subject,X_activity_labels, X_mean_std)
  names(X) <- c("subject","activity",names(X_mean_std))
  
  
  summarise_each(group_by(X,subject,activity),funs(mean))
  
  
}