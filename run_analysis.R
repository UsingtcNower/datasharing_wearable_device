
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

#join the subject, activity, observe data together
joinData <- function(datatype) {
  x_file <- paste("UCI HAR Dataset/", datatype, "/X_", datatype, ".txt", sep="")
  y_file <- paste("UCI HAR Dataset/", datatype, "/Y_", datatype, ".txt", sep="")
  subject_file <- paste("UCI HAR Dataset/", datatype, "/subject_", datatype, ".txt", sep="")
  
  x <- read.table(x_file)
  y <- read.table(y_file)
  subject <- read.table(subject_file)
  
  x <- cbind(subject, y, x)
  x
}

#Merge the train and test data into one data set
train <- joinData("train")
test  <- joinData("test")
data  <- rbind(train, test)
head(data)
rm(train)
rm(test)

names <- read.table("UCI HAR Dataset/features.txt", header=FALSE, stringsAsFactors = FALSE)
colnames(data) <- c("Subject", "Activity", names[,"V2"])

#extract only the mean and sd
idx <- c(1,2, c(1,2,3,4,5,6, 41,42,43,44,45,46, 81,82,83,84,85,86, 161,162,163,164,165,166,
         201,202, 214,215, 227,228, 240,241, 253,254, 266,267,268,269,270,271,
         294,295,296, 345,346,347,348,349,350, 373,374,375, 424,425,426,427,428,429,
         452,453,454, 503,504, 516,517, 529,530, 542,543, 552)+2)
data <- data[, idx]

#maps to activity name
activity_map <- read.table("UCI HAR Dataset/activity_labels.txt")
data[, "Activity"] <- activity_map[data[,"Activity"], "V2"]

#get the mean for each activity and each subject
data_cleaned <- aggregate(subset(data, select=-c(Subject,Activity)),
                          by=list(Subject=data$Subject, Activity=data$Activity), FUN=mean)

