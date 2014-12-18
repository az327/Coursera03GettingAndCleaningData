#Getting and Cleaning Data Course Project Code Book

##Objective of the code book

This code book:

* Describes the data and the variables 
* any transformations or work performed to clean up the data  


##Description of the data and the variables 

As mentioned in the READMD.md file, execute the "run_analysis.R" script. That script would download the "getdata-projectfiles-UCI HAR Dataset.zip" file and unzip it to "UCI HAR Dataset" folder.

In the "UCI HAR Dataset" folder:

* 'README.txt' : provides the details of the training set and test set files for data, subject and labels.
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.


##Any transformations or work performed to clean up the data 

The attached R script (run_analysis.R) first downloads the "getdata-projectfiles-UCI HAR Dataset.zip" file and unzips it, if not down earlier.

Then it performs the following to clean up the data:

1. Merges the training and the test sets to create one data set. The following files are merged:

* UCI HAR Dataset/train/y_train.txt  
* UCI HAR Dataset/test/y_test.txt  
* UCI HAR Dataset/train/subject_train.txt  
* UCI HAR Dataset/test/subject_test.txt  
* UCI HAR Dataset/train/X_train.txt  
* UCI HAR Dataset/test/X_test.txt  

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

In the merged data set, the variables containing meand and standard deviation are subsetted, so that the number of variables reduce from 561 to 66

3. Uses descriptive activity names to name the activities in the data set

Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

* walking  
* walkingupstairs  
* walkingdownstairs  
* sitting  
* standing  
* laying  

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




