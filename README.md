# Final project for "Getting and cleaning Data Course" 
This is the course project for the Getting and Cleaning Data Coursera course. 
The R script, run_analysis.R, does the following:
  - Download zipped folder, unzip itinto the workspace
  - Read the datasets {X_train, Y_train, X_test, Ytest, features, activity labels} into work space
  - Combine and Merge the datasets "train" and "test". Starting with the train dataset rows followed by test
  - Merge the subject and activity columns into the result data set from last step
  - The columns representing the "activity" and "subject" are changed into factor levels
  - Tidy the header names and the activity levels names for consistency and readability
  - Selecting columns for the first dataset that represent means and standard deviations of observations
  - Writing and saving first data set "tidy.txt"
  - Calculating the mean of each variable for each activity and each subject.
  - Writing and saving second dataset "tidy_average.txt"
 
The end result datasets  are  shown in the file tidy.txt" and "tidy_average.txt".