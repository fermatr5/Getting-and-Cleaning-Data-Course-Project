#import dplyr
library(dplyr)

#import and load data
setwd("C:/Users/rboll/Desktop/UCI HAR Dataset/train")
training.subject <- read.csv("subject_train.txt", sep = "", header = FALSE)
training.x <- read.csv("X_train.txt", sep = "", header = FALSE)
training.y <- read.csv("y_train.txt", sep = "", header = FALSE)
setwd("C:/Users/rboll/Desktop/UCI HAR Dataset/test")
testing.subject <-  read.csv("subject_test.txt", sep = "", header = FALSE)
testing.x <- read.csv("X_test.txt", sep = "", header = FALSE)
testing.y <- read.csv("y_test.txt", sep = "", header = FALSE)

#combine columns into single dataframe
training <- data.frame(training.subject, training.y, training.x)
testing <- data.frame(testing.subject, testing.y, testing.x)

#combine data together into a single dataframe
data <- rbind(testing, training)

#read labels in features
setwd("C:/Users/rboll/Desktop/UCI HAR Dataset")
features <- read.table("features.txt")
label <- features[,2]
names(data) <- c(as.character(label), "activity", "subject")
#data_table <- tbl_df(data)

#remove duplicates
data_table <- data_table[!duplicated(names(data_table))]

#isolate mean and standard deviation for measurements
data_table <- select(data_table, matches('std|mean|activity|subject'))


#add meaningful labels
data_table$activity[data_table$activity == 1] <- "WALKING"
data_table$activity[data_table$activity == 2] <- "WALKING UPSTAIRS"
data_table$activity[data_table$activity == 3] <- "WALKING DOWNSTAIRS"
data_table$activity[data_table$activity == 4] <- "SITTING"
data_table$activity[data_table$activity == 5] <- "STANDING"
data_table$activity[data_table$activity == 6] <- "LAYING"

#add additional labels for each measurement
names(data_table) <- gsub('Acc',"Acceleration",names(data_table))
names(data_table) <- gsub('tGravity|gravity',"Gravity",names(data_table))
names(data_table) <- gsub('mean',"Mean",names(data_table))
names(data_table) <- gsub('std',"StandardDev",names(data_table))
names(data_table) <- gsub('^t',"TimeDomain.",names(data_table))
names(data_table) <- gsub('^f',"FreqDomain.",names(data_table))
names(data_table) <- gsub('\\(|\\)',"",names(data_table), perl = TRUE)
names(data_table) <- gsub('-|,',"",names(data_table))

#find means for each group
data.summary <- data_table %>%
  group_by(activity, subject) %>%
  summarise_each(funs(mean))

#write table
write.table(data.summary, file = "data_table.txt", sep = "\t", row.names = FALSE)


