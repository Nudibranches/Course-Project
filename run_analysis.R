#Setting necessary libraries
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
                     col.names = features$Function)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", 
                     col.names = "Code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            col.names = "Subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                      col.names = features$Function)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", 
                      col.names = "Code")

##Step 1:
#Merges the training and the test sets to create one data set.

#Merging data
x<-rbind(x_test,x_train)
y<-rbind(y_test,y_train)
s<-rbind(subject_test,subject_train)
Step1<-cbind(s,y,x)

##Step 2:
#Extracts only the measurements on the mean and standard deviation (std) for each measurement.

#Separating relevant data
Step2<-Step1 %>% select(Subject, Code, contains("mean"), contains("std"))

##Step 3:
#Uses descriptive activity names to name the activities in the data set

#Replacing numerical code with actual descriptions
Step3<-Step2   #Not necessary, just for coherence with variable names
Step3$Code <- activities[Step3$Code, 2]
names(Step3)[2]<-"Activities"   #As is no longer a mysterious number code

##Step 4:
#Appropriately labels the data set with descriptive variable names.

#Getting column names readable
Step4<-Step3   #Not necessary, just for coherence with variable names
names(Step4)<-gsub("Acc", "Accelerometer", names(Step4))
names(Step4)<-gsub("Gyro", "Gyroscope", names(Step4))
names(Step4)<-gsub("BodyBody", "Body", names(Step4))
names(Step4)<-gsub("Mag", "Magnitude", names(Step4))
names(Step4)<-gsub("angle", "Angle", names(Step4),ignore.case = TRUE)
names(Step4)<-gsub("gravity", "Gravity", names(Step4),ignore.case = TRUE)
names(Step4)<-gsub("tBody", "TimeBody", names(Step4))
names(Step4)<-gsub("^t", "Time", names(Step4))
names(Step4)<-gsub("^f", "Frequency", names(Step4))
names(Step4)<-gsub("mean", "Mean", names(Step4), ignore.case = TRUE)
names(Step4)<-gsub("std", "STD", names(Step4), ignore.case = TRUE)
names(Step4)<-gsub("freq", "Frequency", names(Step4), ignore.case = TRUE)
NameComparisson<-matrix(nrow = 88,ncol = 2)     #Just for sanity check
NameComparisson[,1]<-names(Step3)
NameComparisson[,2]<-names(Step4)

##Step 5:
#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.
Step5 <- Step4 %>% group_by(Subject, Activities) %>% summarise_all(list(mean=mean))
write.table(Step5, "CleanDataSet.txt", row.name=FALSE)