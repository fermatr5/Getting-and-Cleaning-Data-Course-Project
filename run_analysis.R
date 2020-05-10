#import dplyr
library(dplyr)

#import and load data
setwd("/Desktop/UCI HAR Dataset/train")
training.subject <- read.csv("subject_train.txt", sep = "", header = FALSE)
training.x <- read.csv("X_train.txt", sep = "", header = FALSE)
training.y <- read.csv("y_train.txt", sep = "", header = FALSE)
setwd("/Desktop/UCI HAR Dataset/test")
testing.subject <-  read.csv("subject_test.txt", sep = "", header = FALSE)
testing.x <- read.csv("X_test.txt", sep = "", header = FALSE)
testing.y <- read.csv("y_test.txt", sep = "", header = FALSE)

#combine data together into a single dataframe
training <- data.frame(training.subject, training.y, training.x)
testing <- data.frame(testing.subject, testing.y, testing.x)
data <- rbind(training, testing)

#read lables in features dataset
setwd("/Desktop/UCI HAR Dataset/")
features <- read.csv("features.txt", sep= "", header=FALSE)
#convert to vector
column.names <- as.vector(features[, 2])
#add column labels
colnames(data) <- c("subject_id", "activity_labels", column.names)

#select appropriate columns needed
data <- select(data, contains("subject"), contains("label"), contains("mean"), contains("std"), -contains("freq"), -contains("angle"))

#read activity labels
activity.labels <- read.csv("activity_labels.txt", sep = "", header = FALSE)
#add activity lables instead of codes
data$activity_labels <- as.character(activity.labels[match(data$activity_labels, activity.labels$V1), 'V2'])

#clean up data by removing extraneous characters
setnames(data, colnames(data), gsub("\\(\\)", "", colnames(data)))
setnames(data, colnames(data), gsub("-", "_", colnames(data)))
setnames(data, colnames(data), gsub("BodyBody", "Body", colnames(data)))

#group data by subject and activity, calculate mean for the measurements
data.summary <- data %>% group_by(subject_id, activity_labels) %>% summarise_each(funs(mean))

#write table
write.table(data.summary, file = "run_data_summary.txt", row.name = FALSE)

