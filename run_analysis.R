# 1.reading data
# train data
x_train <- read.table("C:/Users/Bruker/Desktop/datascience/train/X_train.txt")
y_train <- read.table("C:/Users/Bruker/Desktop/datascience/train/Y_train.txt")
subject_train <- read.table("C:/Users/Bruker/Desktop/datascience/train/subject_train.txt")
# read test data
y_test <- read.table("C:/Users/Bruker/Desktop/datascience/test/Y_test.txt")
x_test <- read.table("C:/Users/Bruker/Desktop/datascience/test/X_test.txt")
subject_test <- read.table("C:/Users/Bruker/Desktop/datascience/test/subject_test.txt")
# read data description
features <- read.table("C:/Users/Bruker/Desktop/datascience/features.txt")
# read activity labels
activityLabels <- read.table("C:/Users/Bruker/Desktop/datascience/activity_labels.txt")
# Assigning column names:
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c('activityId','activityType')
# 2.Merging all data in one set:
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)
#  3.Extracting only the measurements on the mean and standard deviation for each measurement
colNames <- colnames(setAllInOne)
mean_and_std <- (grepl("activityId",colNames)| grepl("subjectId",colNames)| grepl("mean..",colNames)|grepl("std..",colNames))
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
# 4.Using descriptive activity names to name the activities in the data set:
setWithActivityNames <- merge(setForMeanAndStd,activityLabels,by= "activityId",all.x = TRUE)
# 5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
write.table(secTidySet,"secTidySet.txt",row.names = FALSE)
