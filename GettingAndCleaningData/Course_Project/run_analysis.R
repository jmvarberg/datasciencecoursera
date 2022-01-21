#Course Project: Getting and Cleaning Data, Samsung Galaxy S accelerometer data

#Instructions:
#Create one R script called 'run_analysis.R' that does the following:
# 1) Merges the training and test sets to one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement
# 3) Uses descriptive activity names to name the activities in the data set.
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data in step 4, creates a separate, independent tidy data set with the average of each variable for each activity and each subject.

#load in required packages
library(tidyverse)
library(data.table)


#Read in training and test sets based on description from README in UCI HAR Dataset

test <- fread("./test/X_test.txt")
train <- fread("./train/X_train.txt")

#descriptors for each column are provided in features.txt file. read in and assign column names accordingly
features <- fread("./features.txt", select=c(2))
colnames(test) <- as.character(features$V2)
colnames(train) <- as.character(features$V2)

#read in activity_labels.txt
activity_labels <- fread("./activity_labels.txt")

#read in activity labels for test and train sets and add as new columns

test_activity_labels <- fread("./test/y_test.txt")
train_activity_labels <- fread("./train/y_train.txt")

test$ActivityLabel <- test_activity_labels$V1
train$ActivityLabel <- train_activity_labels$V1

#read in subject IDs for test and train and add to data sets

test_subjects <- fread("./test/subject_test.txt")
train_subjects <- fread("./train/subject_train.txt")

test$Subject <- test_subjects$V1
train$Subject <- train_subjects$V1

#add group identifiers prior to merging to allow to separate back out if needed
test$Group <- c("Test")
train$Group <- c("Train")

#combined two datasets into single dataset using rbind, since same columns in each dataframe
combdf <- rbind(test, train)

#filter combined dataframe to only keep columns that contain mean and standard deviation measurements

colNames.new <- colnames(combdf) #get new column names vector since we have added some new columns

#clean up column names to be more readable
colNames.new <- sapply(colNames.new, str_replace_all, pattern = "-|\\(\\)-|\\(\\)", replacement = ".")
#rename columns with cleaned versions
colnames(combdf) <- colNames.new

#filter to only keep columns with mean, std or Group/Subject?ActivityLabel info
keep.index <- sapply(colNames.new, str_detect, pattern=regex("mean|std|Group|Subject|ActivityLabel", ignore_case = TRUE)) #make logical vector for selecting columns based on column names matching one of the provided patterns

#make new filtered dataframe
combdf.clean <- combdf[, ..keep.index]

#add descriptive labels for activities based on activity label descriptions in activity_labels.txt

combdf.clean <- combdf.clean %>% 
  mutate(Activity = case_when(ActivityLabel == 1 ~ "Walking",
                              ActivityLabel == 2 ~ "Walking_Upstairs",
                              ActivityLabel == 3 ~ "Walking_Downstairs",
                              ActivityLabel == 4 ~ "Sitting",
                              ActivityLabel == 5 ~ "Standing",
                              ActivityLabel == 6 ~ "Laying", 
                              TRUE ~ "Missing"))

#make tidy dataframe with average value for each variable, grouped by subject and activity

tidydf <- combdf.clean %>% 
  select(-ActivityLabel) %>% 
  group_by(Subject, Activity) %>% 
  summarise_if(is.numeric, mean)

#save out tidy dataset
write.csv(tidydf, "./tidy_samsung_accelerometer_data.csv")
write.table(tidydf, "./tidy_samsung_accelerometer_data.txt", row.names = FALSE)
