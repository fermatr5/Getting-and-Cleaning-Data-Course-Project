#import dplyr
library(dplyr)

#import and load data
setwd("C:/Users/rboll/Documents/UCI HAR Dataset/train")
training.subject <- read.csv("subject_train.txt", sep = "", header = FALSE)
training.x <- read.csv("X_train.txt", sep = "", header = FALSE)
training.y <- read.csv("y_train.txt", sep = "", header = FALSE)
setwd("C:/Users/rboll/Documents/UCI HAR Dataset/test")
testing.subject <-  read.csv("subject_test.txt", sep = "", header = FALSE)
testing.x <- read.csv("X_test.txt", sep = "", header = FALSE)
testing.y <- read.csv("y_test.txt", sep = "", header = FALSE)

#combine data together into a single dataframe
training <- data.frame(training.subject, training.y, training.x)
testing <- data.frame(testing.subject, testing.y, testing.x)
data <- rbind(training, testing)

#get mean and standard deviation information
apply(training, 1, mean)
apply(training, 1, sd)
apply(testing, 1, mean)
apply(testing, 1, sd)

#change labels
data$V1[data$V1 == 1] <-"WALKING"
data$V1[data$V1 == 2] <-"WALKING UPSTAIRS"
data$V1[data$V1 == 3] <- "WALKING DOWNSTAIRS"
data$V1[data$V1 == 4] <- "SITTING"
data$V1[data$V1 == 5] <- "STANDING"
data$V1[data$V1 == 6] <- "LAYING"

#read lables in features dataset
setwd("C:/Users/rboll/Documents/UCI HAR Dataset")
features <- read.csv("features.txt", sep= "", header=FALSE)
#reformat to get activity and subject headers
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))
#add column labels
colnames(data) <- feature[,2]

#group data by subject and activity, calculate mean for the measurements
activitymean <- aggregate(data$activity, data, mean)
subjectmean <- aggregate(activitymean$subject, activitymean, mean)
data.summary <- subjectmean[,c(564,565)]

#write table
write.table(data.summary, file = "data_table.txt", row.name = FALSE)


