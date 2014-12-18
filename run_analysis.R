# This R script does the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# 0: Downloand and unzip the data files

if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = "getdata-projectfiles-UCI HAR Dataset.zip" )
}
if(!file.exists("UCI HAR Dataset")) {unzip("getdata-projectfiles-UCI HAR Dataset.zip")}

# 1. Merges the training and the test sets to create one data set.

# load and merge label train and test dataset
label_train <- read.table("UCI HAR Dataset/train/y_train.txt")
label_test <- read.table("UCI HAR Dataset/test/y_test.txt")
label <- rbind(label_train, label_test)
rm(label_train, label_test)

# load and merge subject train and test dataset
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject <- rbind(subject_train, subject_test)
rm(subject_train, subject_test)

# load and merge train and test data
data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
data <- rbind(data_train, data_test)
rm(data_train, data_test)



# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")

meanStdFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
meanStdData <- data[, meanStdFeatures]
#assign names to variables
names(meanStdData) <- features[meanStdFeatures, 2]
names(meanStdData) <- gsub("\\(|\\)", "", names(meanStdData))
names(meanStdData) <- tolower(names(meanStdData))
rm(features)

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
label[,1] = activities[label[,1], 2]
names(label) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(subject) <- "subject"
mergedData <- cbind(subject, label, meanStdData)
write.table(mergedData, "MergedData.txt")


# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
library("plyr")
featurMeanBySubjectActivity = ddply(mergedData, .(subject, activity), numcolwise(mean))
write.table(featurMeanBySubjectActivity, "FeatureMeanBySubjectActivity.txt", row.name=FALSE)

