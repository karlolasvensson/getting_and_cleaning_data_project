#required packages
library("plyr")
library("knitr")

#clean workspace
rm(list = ls())

#set filename
filename <- "dataset.zip"

#download the data from given source if it not already downloaded
if (!file.exists(filename)) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, filename)
}


#load all the data from the downloaded file
data_train_x <- read.table(unz(filename, "UCI HAR Dataset/train/X_train.txt"))
data_train_y <- read.table(unz(filename, "UCI HAR Dataset/train/y_train.txt"))
data_train_subject <- read.table(unz(filename, "UCI HAR Dataset/train/subject_train.txt"))

data_test_x <- read.table(unz(filename, "UCI HAR Dataset/test/X_test.txt"))
data_test_y <- read.table(unz(filename, "UCI HAR Dataset/test/y_test.txt"))
data_test_subject <- read.table(unz(filename, "UCI HAR Dataset/test/subject_test.txt"))

features <- read.table(unz(filename, "UCI HAR Dataset/features.txt"))
activity <- read.table(unz(filename, "UCI HAR Dataset/activity_labels.txt"))

#concatenate the data and make one large data set
data_subject <- rbind(data_train_subject, data_test_subject)
data_activity <- rbind(data_train_y, data_test_y)
data_features <- rbind(data_train_x, data_test_x)

data_all <- cbind(data_features, data_subject, data_activity)


#Extracts the measurements on the mean and standard deviation for each measurement. 
mean_std <- grep("-(mean|std)\\(\\)", data_features[, 2])

data_features <- data_features[, mean_std]

names(data_features) <- features[mean_std, 2]

#Descriptive activity names to name the activities in the data set
data_activity[, 1] <- activity[data_activity[, 1], 2]
names(data_activity) <- "activity"

#Appropriately labels the data set with descriptive variable names
names(data_subject) <- "subject"

#Independent tidy data set
data_average <- ddply(data_all, .("subject", "activity"), function(x) colMeans(x[, 1:66]))
write.table(data_average, file = "data_tidy.txt",row.name=FALSE)

#remove downloaded file
unlink(filename)