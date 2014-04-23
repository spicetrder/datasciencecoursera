# R script run.analysis.R
##
# created for Data Cleaning course
# created: April 15, 2014
# created by John S. Johnson
##
# read test and training sets
X_train <- read.table("~/R/Data Cleaning/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("~/R/Data Cleaning/UCI HAR Dataset/test/X_test.txt")
##
# read activity and feature labels
activity_labels <- read.table("~/R/Data Cleaning/UCI HAR Dataset/activity_labels.txt", quote="\"")
names(activity_labels) <- c("act_key", "activity")
features_list <- read.table("~/R/Data Cleaning/UCI HAR Dataset/features.txt", quote="\"")
names(features_list) <- c("feat_key", "feature")
##
# name the features measured for test and training datasets
names(X_test) <- features_list[,2]
names(X_train) <- features_list[,2]
##
# determine features that are means and stdevs and make a vector of column indices
if(length(i <- grep("mean", features_list[,2]))) mean_idxs <- features_list[i,1]
if(length(i <- grep("std", features_list[,2]))) std_idxs <- features_list[i,1]
idxs_of_interest <- c(mean_idxs, std_idxs)
idxs_of_interest <- idxs_of_interest[order(idxs_of_interest)]
##
# subset test and training sets for only columns of interest
test_subset <- X_test[, idxs_of_interest].
train_subset <- X_train[, idxs_of_interest]
##
# add subject column to each test and train subsets and name column
test_subset <- cbind(subject_test, test_subset)
names(test_subset)[1] <- "subject"
train_subset <- cbind(subject_train, train_subset)
names(train_subset)[1] <- "subject"
##
# add activity column to each test and train subsets and name column
test_subset <- cbind(y_test, test_subset)
names(test_subset)[1] <- "activity"
train_subset <- cbind(y_train, train_subset)
names(train_subset)[1] <- "activity"
##
# replace actitity code with activity name in both test and train subset activity columns
# create a named vector of activity keys
activities <- activity_labels[,1]
names(activities) <- activity_labels[,2]
# assign activity names to activity codes in subset dataframes
test_subset$activity <- names(activities[test_subset$activity])
train_subset$activity <- names(activities[train_subset$activity])
##
# put the test and training subsets into one dataframe
result_subset <- join(train_subset, test_subset, type = "full")
##
# determine mean for each feature by activity and subject
mean_df <- aggregate(result_subset[, - c(1:2)], by=list(subject = result_subset
            $subject, activity = result_subset$activity), mean)
##
# output the resultant dataframe to a csv file
write.csv(mean_df, "SamsungMeans.csv", row.names = FALSE)
##
#end of code








