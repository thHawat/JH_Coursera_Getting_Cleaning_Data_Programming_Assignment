# JH_Coursera_Getting_Cleaning_Data_Programming_Assignment
Programming Assignment of the Getting and Cleaning Data Course from John Hopkins University

The run_analysis script contains one functions aiming at producing a tidy data set based on the Samsung datas

## What does it do ?
  
* it merges the training and the test sets to create one data set.
* it extracts only the measurements on the mean and standard deviation for each measurement. 
* it sets descriptive activity names to name the activities in the data set
* it appropriately labels the data set with descriptive variable names. 
* then, from the data set in the previous step 4, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## How does it work ?

it requires the dplyr package.

* it reads all the required files
* it names the columns
* it binds the test and train files, and extracts only the mean and standard deviations variables
* it binds with the activity and use the activity labels. For this, it uses the match function, which associates each activity_id from the train and test files with the right label from the activity_labels file
* it binds with the result with the subject 
* it renames all the columns
* and it finally summarises all the variables with the mean functions, group by subject and activity. In order to avoid to make a loop on the columns, the summarise_each functions is used to apply a mean function on all the columns except the subject and activity ones

truc
  
