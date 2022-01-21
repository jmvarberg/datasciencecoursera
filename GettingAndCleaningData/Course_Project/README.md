README
================
JMV
1/21/2022

## Project Description

This document describes the project for the final project for the
“Getting and Cleaning Data” course on Coursera.

From the course site:

“The purpose of this project is to demonstrate your ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. You will be graded by your peers on a
series of yes/no questions related to the project. You will be required
to submit: 1) a tidy data set as described below, 2) a link to a Github
repository with your script for performing the analysis, and 3) a code
book that describes the variables, the data, and any transformations or
work that you performed to clean up the data called CodeBook.md. You
should also include a README.md in the repo with your scripts. This repo
explains how all of the scripts work and how they are connected.”

"One of the most exciting areas in all of data science right now is
wearable computing. Companies like Fitbit, Nike, and Jawbone Up are
racing to develop the most advanced algorithms to attract new users. The
data linked to from the course website represent data collected from the
accelerometers from the Samsung Galaxy S smartphone. A full description
is available at the site where the data was obtained:

[Link to description of how dataset was
obtained.](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[Link to download dataset for
project](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run\_analysis.R that does the
following.

1)  Merges the training and the test sets to create one data set.

2)  Extracts only the measurements on the mean and standard deviation
    for each measurement.

3)  Uses descriptive activity names to name the activities in the data
    set

4)  Appropriately labels the data set with descriptive variable names.

5)  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject.

## Description of analyis files

Descriptions of the experiment set up and files are found in the
README.txt file. The R script `run_analysis.R` was used to combine the
measurements from test and training subjects into one dataset. The
original datasets contained 561 features that were extracted from the
accelerometer measurements (see description of these in the README.txt
and features\_info.txt files). During processing with `run_analysis.R`,
a subset of these features (the mean and standard deviation) were
retained. The `run_analysis.R` script outputs a tidy datset
`tidy_samsung_accelerometer_data.csv`, that summarises each of the
mean/standard deviation (std) values for each of the 30 subjects in the
study, for each of the six activities for which measurements were
obtained.

As shown in the table below, column names correspond to measured
variables, with variables begining with ‘t’ representing measurements in
the time domain, and those beginning with ‘f’ representing Fourier
transformed
values.

| Subject | Activity            | tBodyAcc.mean.X | tBodyAcc.mean.Y | tBodyAcc.mean.Z | tBodyAcc.std.X | tBodyAcc.std.Y | tBodyAcc.std.Z | tGravityAcc.mean.X |
| ------: | :------------------ | --------------: | --------------: | --------------: | -------------: | -------------: | -------------: | -----------------: |
|       1 | Laying              |       0.2215982 |     \-0.0405140 |     \-0.1132036 |    \-0.9280565 |    \-0.8368274 |    \-0.8260614 |        \-0.2488818 |
|       1 | Sitting             |       0.2612376 |     \-0.0013083 |     \-0.1045442 |    \-0.9772290 |    \-0.9226186 |    \-0.9395863 |          0.8315099 |
|       1 | Standing            |       0.2789176 |     \-0.0161376 |     \-0.1106018 |    \-0.9957599 |    \-0.9731901 |    \-0.9797759 |          0.9429520 |
|       1 | Walking             |       0.2773308 |     \-0.0173838 |     \-0.1111481 |    \-0.2837403 |      0.1144613 |    \-0.2600279 |          0.9352232 |
|       1 | Walking\_Downstairs |       0.2891883 |     \-0.0099185 |     \-0.1075662 |      0.0300353 |    \-0.0319359 |    \-0.2304342 |          0.9318744 |
|       1 | Walking\_Upstairs   |       0.2554617 |     \-0.0239531 |     \-0.0973020 |    \-0.3547080 |    \-0.0023203 |    \-0.0194792 |          0.8933511 |
|       2 | Laying              |       0.2813734 |     \-0.0181587 |     \-0.1072456 |    \-0.9740595 |    \-0.9802774 |    \-0.9842333 |        \-0.5097542 |
|       2 | Sitting             |       0.2770874 |     \-0.0156880 |     \-0.1092183 |    \-0.9868223 |    \-0.9507045 |    \-0.9598282 |          0.9404773 |
|       2 | Standing            |       0.2779115 |     \-0.0184208 |     \-0.1059085 |    \-0.9872719 |    \-0.9573050 |    \-0.9497419 |          0.8969286 |
|       2 | Walking             |       0.2764266 |     \-0.0185949 |     \-0.1055004 |    \-0.4236428 |    \-0.0780913 |    \-0.4252575 |          0.9130173 |
