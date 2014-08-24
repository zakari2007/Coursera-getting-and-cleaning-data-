Coursera-getting-and-cleaning-data-
===================================
> setwd("~/GSICS/econometrics/COURSERA/getting and cleaning data/UCI HAR Dataset")
> getwd()
[1] "C:/Users/zz/Documents/GSICS/econometrics/COURSERA/getting and cleaning data/UCI HAR Dataset"
> # Read Training and Test Data
> # For the purposes of this analysis, the measurement variables are limited to those containing the substrings "mean()", "meanFreq()", and "std()"
> var_names <- read.table("./features.txt")
> var_names_subset <- var_names[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,516:517,529:530,542:543,552),]
> var_names_only <-var_names_subset[c("V2")]
> var_names_print <- var_names_only$V2
> # Read and Format Test Data
> xTest <- read.table("./test/X_test.txt", sep="")
> xTest_means_and_sds <- xTest[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,516:517,529:530,542:543,552)]
> colnames(xTest_means_and_sds) <- var_names_print
> activity_test <- read.table("./test/y_test.txt", sep="")
> names(activity_test)[1] <- paste("activity_id")
> activity_test$activity[activity_test$activity_id == 1] <- "Walking"
> activity_test$activity[activity_test$activity_id == 2] <- "Walking Upstairs"
> activity_test$activity[activity_test$activity_id == 3] <- "Walking Downstairs"
> activity_test$activity[activity_test$activity_id == 4] <- "Sitting"
> activity_test$activity[activity_test$activity_id == 5] <- "Standing"
> activity_test$activity[activity_test$activity_id == 6] <- "Laying"
> subject_test <- read.table("./test/subject_test.txt", sep="")
> names(subject_test)[1] <- paste("subject_id")
> merged_Test <- cbind(subject_test, activity_test, xTest_means_and_sds)
> # Read and Format Train Data
> xTrain <- read.table("./train/X_train.txt", sep="")
> xTrain_means_and_sds <- xTrain[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,294:296,345:350,373:375,424:429,452:454,503:504,516:517,529:530,542:543,552)]
> colnames(xTrain_means_and_sds) <- var_names_print
> activity_train <- read.table("./train/y_train.txt", sep="")
> names(activity_train)[1] <- paste("activity_id")
> activity_train$activity[activity_train$activity_id == 1] <- "Walking"
> activity_train$activity[activity_train$activity_id == 2] <- "Walking Upstairs"
> activity_train$activity[activity_train$activity_id == 3] <- "Walking Downstairs"
> activity_train$activity[activity_train$activity_id == 4] <- "Sitting"
> activity_train$activity[activity_train$activity_id == 5] <- "Standing"
> activity_train$activity[activity_train$activity_id == 6] <- "Laying"
> subject_train <- read.table("./train/subject_train.txt", sep="")
> names(subject_train)[1]<-paste("subject_id")
> merged_Train <- cbind(subject_train, activity_train, xTrain_means_and_sds)
> 
> # Merge xTest and xTrain Data
> merged_data <- rbind(merged_Test,merged_Train)
> # Compute Average for Each Activity for each Subject
> library(reshape2)
> melted_data <- melt(merged_data,id=c(1,2,3),measure.vars=c(4:79))
> activity_means <- dcast(melted_data, subject_id + activity_id + activity ~ variable,mean)
> 
> # Output Tidy Dataset
> write.table(activity_means, file = "./tidydata.txt")
> tidydata <- read.table("~/GSICS/econometrics/COURSERA/getting and cleaning data/UCI HAR Dataset/tidydata.txt", header=T, quote="\"")
>   View(tidydata)
