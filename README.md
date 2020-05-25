# coursera_getting_and_cleaning_data_week4
Week 4 - Assignment

=============================
What is Included in this Repository?
=============================

This repository includes four (4) files, including this README:
  1) - README - The purpose of this README file is to relay to the reader the contents of each file, and the process undertaken to create the data
  2) - Tidy Means.txt - This data set is output from the program labelled "run_analysis.R". The data set represents the average values of the variables of interest, and includes identifiers for subjects and activities.
  3) - Code Book.txt - The code book file includes a description of the variables contained in "Tidy Means.txt". 
  4) - run_analysis.R - This program contains the code which downloads raw data, cleans the data, manipulates and calculates the variables of interest, and outputs the dataset "Tidy Means.txt"
  
=============================
Description of Data Build Steps
=============================

*Within the code "run_analysis.R", the follwing data manipulation steps are undertaken:

  1) - Downloaded and unzip the relevant data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  2) - Import the following text files named
    a) - "UCI HAR Dataset/activity_labels.txt"
    b) - "UCI HAR Dataset/features.txt"
    c) - "UCI HAR Dataset/test/X_test.txt"
    d) - "UCI HAR Dataset/test/y_test.txt"
    e) - "UCI HAR Dataset/test/subject_test.txt"
    f) - "UCI HAR Dataset/train/X_train.txt"
    g) - "UCI HAR Dataset/train/y_train.txt"
    h) - "UCI HAR Dataset/train/subject_train.txt"
  3) - Select all variables from features.txt that contain "mean" or "std" in the name
  4) - Limit the X_test.txt and X_training.txt file to the variables identified in step 3) 
  5) - Give descriptive names to all the variables in each data set
  6) - Left join the X_test and y_test files onto the subject_test data
  7) - Left join the X_training and y_training files onto the subject_training data
  8) - Stack the test and training data sets together
  9) - Left join the activity labels information onto the full stacked data from step 8)
  10) - Average the data using the aggregate() function to calculate the mean of each relevant variable across each subject ID and Activity ID and Name
  11) - Export the data to a file called "Tidy Means.txt"
  
=============================
Description of Dataset Output
=============================

*The dataset ("Tidy Means.txt") that is output by the program "run_analysis.R" is unique by the test or training subject's ID number, and the ID and description of the activity that was undertaken while measurements were taken. The variables measured come from an accelerometer and gyroscope 3-axial signals. These signals are summarized into means and standard deviations and are averaged across each subject and activity.
