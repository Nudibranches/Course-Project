#Setting neccesary libraries
library(dplyr)

#Getting the dataset

#Importing/assigning data frames
features <- read.table("UCI HAR Dataset/features.txt", 
                       col.names = c("n","Function"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", 
                         col.names = c("Code", "Activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names = "Subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "Code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "Code")

##Step 1:
#Merges the training and the test sets to create one data set.

#Merging data
x<-rbind(x_test,x_train)
y<-rbind(y_test,y_train)
s<-rbind(subject_test,subject_train)
NewData<-cbind(s,y,x)

##Step 2:
#Extracts only the measurements on the mean and standard deviation for each measurement.

##Step 3:
#Uses descriptive activity names to name the activities in the data set

##Step 4:
#Appropriately labels the data set with descriptive variable names.

##Step 5:
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
