#Getting and Cleaning Data Project
filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}
# read datasets into workspace
destfile<-"UCI HAR Dataset/test/X_test.txt"
X_test<-read.table(destfile ,  header = FALSE)
destfile<-"UCI HAR Dataset/test/y_test.txt"
Y_test<-read.table(destfile ,  header = FALSE)
destfile<-"UCI HAR Dataset/train/X_train.txt"
X_train<-read.table(destfile ,  header = FALSE)
destfile<-"UCI HAR Dataset/train/y_train.txt"
Y_train<-read.table(destfile ,  header = FALSE)
destfile<-"UCI HAR Dataset/features.txt"
features<-read.table(destfile ,  header = FALSE , stringsAsFactors = FALSE )
features[,1]<-as.numeric(features[,1])
destfile<-"UCI HAR Dataset/activity_labels.txt"
activity<-read.table(destfile ,  header = FALSE , stringsAsFactors = FALSE )
#creating the tidy data frame
library(dplyr)
tidy_test<-cbind(Y_test , X_test)
tidy_train<-cbind(Y_train , X_train)
tidy<-rbind(tidy_train , tidy_test)
tidy_data<-merge(activity , tidy , by = 1 , all = TRUE)
colnames(tidy_data)<- c( "subject", "activity",features[,2])
tidy_data$activity<-tolower(tidy_data$activity)
tidy_data$activity<-gsub("_"," ",tidy_data$activity)
tidy_data$activity<-as.factor(tidy_data$activity)
tidy_data$subject<-as.factor(tidy_data$subject)
# select wanted features mean and standard deviation
selected_tidy<-tidy_data[ , grepl( ".*mean.*|.*std.*" , names( tidy_data) ) ]
selected_tidy_data<-cbind(tidy_data[,c(1,2)],selected_tidy)
# Making header names consistent and tidy
names(selected_tidy_data)<-gsub('[-()]', '',names(selected_tidy_data))
names(selected_tidy_data)<-gsub('mean', 'Mean',names(selected_tidy_data))
names(selected_tidy_data)<-gsub('std', 'Std', names(selected_tidy_data))
# Creating first tidy data with means and standard deviations only
write.table(selected_tidy_data, "tidy_main.txt", row.names = FALSE, quote = FALSE)
library(reshape2)
data.melted <- melt(selected_tidy_data, id = c("subject", "activity"))
# Creating second data set  with the average of each variable for each activity and each subject.
tidy_melted_data <- dcast(data.melted, subject + activity ~ variable, mean)
write.table(tidy_melted_data, "tidy.txt", row.names = FALSE, quote = FALSE)
