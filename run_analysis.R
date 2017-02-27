#Course Project for Getting and Cleaning Data
#Student: Catherine Howell
#Date: 26-Feb-2017

library(reshape2)
#0. Get training set and test set
X_test<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",sep="", header=F)
X_train<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",sep="",header=F)
features<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/features.txt",sep="", header=F)
test_labels<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",header=F, col.names="label")
train_labels<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",header=F, col.names="label")

#1. Merge the training and test sets to create one data set.
X_all<-rbind(X_train,X_test)
names(X_all)<-features[,2]

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
selectedCols<-grep("mean|std",names(X_all))
mean_std_data<-X_all[,selectedCols]

#3. Uses descriptive activity names to name the activities in the data set
activities<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names=c("code","description"),sep="",header=F)
test_labels<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",header=F, col.names="label")
train_labels<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",header=F, col.names="label")
all_labels<-rbind(train_labels, test_labels)
lbled_Data<-cbind(mean_std_data,all_labels)

#4.Appropriately labels the data set with descriptive variable names.
lbled_Data<-mutate(lbled_Data, "Activity" = activities[lbled_Data$label,2]) 

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subject_train<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",header=F,col.names="Subject")
subject_test<-read.csv("FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",header=F,col.names="Subject")
subjects<-rbind(subject_train,subject_test)
DataToAverage<-cbind(lbled_Data, subjects)
moltenData<-melt(DataToAverage, id.vars= c("Subject", "Activity"))
castData<-dcast(moltenData, Subject + Activity ~ variable, fun.aggregate = mean)
write.table(castData, file = "Step5_dataset.txt",row.names=FALSE)
