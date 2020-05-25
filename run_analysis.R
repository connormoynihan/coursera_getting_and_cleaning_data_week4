# This program downloads the samsung data, keeps the variables of interest and outputs a tidy data set

# clear and set options
rm(list=ls())
cat("\f")

# file paths
directory <- "[YOUR DIRECTORY]"
setwd(directory)

# load commonly used packages
packages_load <- c("plyr","dplyr","stringr","lubridate","readxl","xlsx","haven")
lapply(packages_load,require,character.only=TRUE) # another way to load packages

# get version info
sessionInfo()

#####################################################################
# Header
#####################################################################

file <- "full_data.zip"
path <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


#####################################################################
# Program
#####################################################################

# download and save data
download.file(path, file)
unzip(file)

#read all data sets
      activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
      features <- read.table("UCI HAR Dataset/features.txt")
      test <- read.table("UCI HAR Dataset/test/X_test.txt")
      test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
      test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
      training <- read.table("UCI HAR Dataset/train/X_train.txt")
      training_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
      training_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
      
# Extract relevant columns
      features <- subset(features, grepl("mean",V2) | grepl("std",V2))
      test <- test[,features[,1]]
      training <- training[,features[,1]]

# Rename columns
      colnames(test) <- features[,2]
      colnames(training) <- features[,2]
      colnames(test_labels) <- "Labels_ID"
      colnames(test_subjects) <- "Subject"
      colnames(training_labels) <- "Labels_ID"
      colnames(training_subjects) <- "Subject"
      colnames(activity_labels) <- c("Labels_ID", "Activity_Labels")
      
# Merge labels
      test <- cbind(test_subjects,test_labels, test)
      training <- cbind(training_subjects,training_labels, training)
      
# Stack data and merge activity labels
      Full_Data_Initialize <- rbind(test, training)
      Full_Data <- left_join(Full_Data_Initialize,activity_labels, by=c("Labels_ID"="Labels_ID"))
      
      # Reorder
      Full_Data <- select(Full_Data,Subject, Labels_ID, Activity_Labels, everything())

# Create tidy data set with averages
      
      average <- aggregate(Full_Data[,4:ncol(Full_Data)], 
                           by = list(Subject=Full_Data$Subject,
                                     Labels_ID=Full_Data$Labels_ID, 
                                     Activity_Labels=Full_Data$Activity_Labels),
                           FUN = "mean") %>%
            arrange(Subject, Labels_ID)
      
# Export Data
write.table(average, "Tidy Means.txt", row.names = FALSE)
