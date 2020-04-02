# Credits: https://github.com/jeffrey-anderson/getting-cleaning-data-course-project/blob/master/run_analysis.R

# data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

library (dplyr)
library(tidyr)
library(reshape2)

#File Paths
dataRootDir <- file.path("data", "UCI HAR Dataset")
activityLabelFilePath <- file.path(dataRootDir, "activity_labels.txt")
featureFilePath <- file.path(dataRootDir, "features.txt")
testXFilePath <- file.path(dataRootDir, "test", "X_test.txt")
testYFilePath <- file.path(dataRootDir, "test", "Y_test.txt")
testSubjectFilePath <- file.path(dataRootDir, "test", "subject_test.txt")


trainXFilePath <- file.path(dataRootDir, "train", "X_train.txt")
trainYFilePath <- file.path(dataRootDir, "train", "Y_train.txt")
trainSubjectFilePath <- file.path(dataRootDir, "train", "subject_train.txt")

outputDataFilePath <- file.path("data", "outputTidyData.txt")

#' Get a data frame with activities
#' @param activityLabelFile the path to the activity labels 
#' @return A data frame representation of the \code{activityLabelFile} with two columns: \code{activity_id} and \code{activity}
#'

getActivityLabels <- function(activityLabelFile){
        activities <- read.csv(activityLabelFile, header = FALSE, sep = " ")
        colnames(activities) <- c("activity_id", "activity")
        return(activities)
}


#' Get a data frame with features
#' @param featureFile the path to the list of features 
#' @return A data framehelp  representation of the \code{featureFile} with two columns: \code{activity_id} and \code{activity}

getFeatures <- function(featureFile){
        read.csv(featureFile, header = FALSE, sep = " ", stringsAsFactors = FALSE, col.names = c("id", "feature"))
        
}

#' Get a data frame with a complete set of training data with proper column names
#' @param features feature data 
#' @param activities activity data 
#' @return data frame with a complete set of training data with proper column names
#'

getTrainingData <- function(features, activities){
        # Get Main Data:
        trainingMeasures <- read.table(trainXFilePath)
        colnames(trainingMeasures) <- features[,2]
        
        #Get Activity Data:
        trainingActivitiesRaw <- read.table(trainYFilePath, col.names = c("activity_id"))
        #Join adding activity decription
        trainingActivities <- right_join(trainingActivitiesRaw, activities, by = "activity_id")

        #Add in the subject Id rows:
        trainingSubjectData <- read.table(trainSubjectFilePath, col.names = c("subject_id"))
        
        #finally join all three sets of columns and return the result
        cbind(trainingSubjectData, trainingActivities, trainingMeasures)
}


#' Get a data frame with a complete set of test data with proper column names
#' @param features feature data 
#' @param activities activity data 
#' @return data frame with a complete set of test data with proper column names
#'

getTestData <- function(features, activities){
        #Get Main Data:
        testMeasures <- read.table(testXFilePath)
        colnames(testMeasures) <- features[,2]
        
        #Get Activity data:
        testActivitiesRaw <- read.table(testYFilePath, col.names = c("activity_id"))
        #Join adding activity decription
        testActivities <- right_join(testActivitiesRaw, activities, by = "activity_id")
        
        #Add in the subject Id rows:
        testSubjectData <- read.table(testSubjectFilePath, col.names = c("subject_id"))
        
        #Finaly combine all three sets of columns, join in activity name and the result
        cbind(testSubjectData, testActivities, testMeasures)
        
}

# MAIN CODE:

# Get features and activites once and pass as parameters
features <- getFeatures(featureFilePath)
activities <- getActivityLabels(activityLabelFilePath)

# Get complete set of training and test data and concatinate into one unified list.
# Per the instructions, this step does the following:
# 1. Merges the training and the test sets to create one data set.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.


allData <- rbind(getTrainingData(features, activities), getTestData(features, activities))


# 2. Extracts only the measurements on the -mean() and -std() standard deviation for each measurement.
meanStdData <- allData[,grepl('subject_id|activity|-(mean\\(\\)|std\\(\\))', colnames(allData), ignore.case = TRUE )]


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject.
acvMelt <- melt(meanStdData, id = c("subject_id", "activity"),
                measure.vars = colnames(meanStdData[1,grepl('-(mean\\(\\)|std\\(\\))',
                                                            colnames(meanStdData), ignore.case=TRUE)]))

tidyData <- acvMelt %>% group_by(subject_id, activity, variable) %>% summarise(mean = mean(value))
colnames(tidyData)[3] <- "feature"

#Write the tidy data to an output file:
write.table(tidyData, outputDataFilePath, row.names= FALSE)