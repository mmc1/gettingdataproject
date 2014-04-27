##CodeBook.md

This describes the data and clean up steps taken on a UCI HAR dataset.
The dataset comes with the following helpful decriptive files: activity_labels.txt, features.txt, features_info.txt and README.txt.
features_info.txt describes the types of measurement variables.

1. The data files were downloaded as a zip file and extracted to the working directory.
2. Activity labels were read in from "activity_labels.txt" and the resulting data frame columns were labeled.
3. Feature labels for each of 561 measurements were read in from "features.txt", and the names were cleaned up to remove special characters (\ , ().
4. Subject ID numbers were read in from "subject_test.txt" and "subject_train.txt"
5. Measurement data were read in from "Y_Test.txt" and "Y_train.txt"
6. The test and training sets were merged into one data frame
7. Cleaned up feature names were assigned to the dataframe column names
8. Descriptive activity names were given in addition to just including the activityID integer column
9. The measurements on mean and standard deviation were extracted
10. Mean values for each measurement for each subject and activity type were calculated and stored in a tidy dataframe
11. The tidy data frame was written to a tab-delimited text file called "tidy_data.txt"
