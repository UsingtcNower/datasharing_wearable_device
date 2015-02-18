
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

#Merge the train and test data into one data set
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test  <- read.table("UCI HAR Dataset/test/X_test.txt")
data  <- rbind(train, test)
head(data)
rm(train)
rm(test)

names <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
colnames(data) <- names[,"V2"]
head(data)
