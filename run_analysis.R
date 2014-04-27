#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "Dataset.zip")
#unzip("Dataset.zip")

#Read in activity labels and give them the column names "i.label" for the integer ID and "activity" for
#the descriptive label
act.labels <- read.table(file="code\\UCI HAR Dataset\\activity_labels.txt", sep="", header=FALSE,
                         colClasses=c("integer", "character"))
names(act.labels) <- c("i.label", "activity")

#Read in feature labels and give them the column names "i.feature" for the feature integer ID and "feature" for
#the description of the features
feature.labels <- read.table(file="code\\UCI HAR Dataset\\features.txt", sep="", header=FALSE,
                             colClasses=c("integer", "character"))
names(feature.labels) <- c("i.feature", "feature")

#Clean up feature names to remove "()" and replace "-" with "_" and "," with "."
#(feature.labels$fnamesCleaned will be used as variable names to be assigned 
#to the merged dataset)
feature.labels$fnamesCleaned <- feature.labels$feature
feature.labels$fnamesCleaned <- gsub("\\(\\)", "", feature.labels$fnamesCleaned)
feature.labels$fnamesCleaned <- gsub("-", "_", feature.labels$fnamesCleaned)
feature.labels$fnamesCleaned <- gsub(",", ".", feature.labels$fnamesCleaned)

#Read in subject ID numbers from test and train sets and give them the column name "subject"
subjectTest <- read.table(file="code\\UCI HAR Dataset\\test\\subject_test.txt", sep="", header=FALSE,
                          colClasses=c("integer"))
names(subjectTest) <- "subject"
subjectTrain <- read.table(file="code\\UCI HAR Dataset\\train\\subject_train.txt", sep="", header=FALSE,
                          colClasses=c("integer"))
names(subjectTrain) <- "subject"

#Read in the X_test and X_train datasets
xTest <- read.table(file="code\\UCI HAR Dataset\\test\\X_test.txt", sep="", header=FALSE)
xTrain <- read.table(file="code\\UCI HAR Dataset\\train\\X_train.txt", sep="", header=FALSE)

#Read in the Y_test and Y_train labels
yTest <- read.table(file="code\\UCI HAR Dataset\\test\\Y_test.txt", sep="", header=FALSE)
yTrain <- read.table(file="code\\UCI HAR Dataset\\train\\Y_train.txt", sep="", header=FALSE)

# Merge the training and the test sets to create one data set (assignment requirement #1):
subjectTotal <- rbind(subjectTest, subjectTrain)
xTotal <- rbind(xTest, xTrain)
yTotal <- rbind(yTest, yTrain)

#clean up dataframe names on yTotal:
#(assignment requirement #3 & 4)
names(yTotal) <- "activityID"

#give xTotal dataframe descriptive variable names by feature labels:
#(assignment requirement #3 & 4)
names(xTotal)  <- feature.labels$fnamesCleaned

#Add descriptive activity names to yTotal to name the activies in the data
#set and make as factor (assignment requirement #3 & 4):
yTotal$activityDescription <- act.labels$activity[yTotal$activityID]
yTotal$activityDescription  <-  as.factor(yTotal$activityDescription)


# Combined subjectTotal, xTotal, and yTotal into one dataframe
dfTotal <- cbind(subjectTotal, yTotal, xTotal)

# Extract only the measurements on the mean and standard deviation for each measurement.
mask <- grepl("mean", feature.labels$fnamesCleaned)|grepl("std", feature.labels$fnamesCleaned)
xsub <- xTotal[, mask]
dfsub <- cbind(subjectTotal, yTotal, xsub)

#Create a second, independent tidy data set with the average of each variable for 
#each activity and each subject.
dfsort <- dfsub[order(dfsub$subject, dfsub$activityID), ]
#set up a dataframe to store the tidy data:
dftidy <- dfsort[1, ]

#calculate the means of each measurement for each subject and activity:
irow <- 1
for (i in 1:max(dfsort$subject)){
  for (j in 1:6){
    dftidy[irow, 1] <- i
    dftidy[irow, 2] <- j
    dftidy[irow, 3] <- act.labels[j, 2]
    for (k in 4:82){
      dftidy[irow, k] <- mean(dfsort[dfsort$subject==i & dfsort$activityID==j, k])
    }
    irow <- irow+1
  }
}
#check for any NA values:
sum(is.na(dftidy))

#store tidy data in a tab-delimited text file:
write.table(dftidy, "tidy_data.txt", row.names=FALSE, sep="\t")


