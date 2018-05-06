#Reading labels
labels <- read.table("UCI HAR Dataset/activity_labels.txt",sep = " ");

#Changing labels
colnames(labels) <- c("id","activity")

##########################
######  TEST  DATA  ######  
##########################

#Loading dataset features
features <- read.table("UCI HAR Dataset/features.txt",sep = "") 

#loading test Data
testData <- read.table("UCI HAR Dataset/test/X_test.txt",sep = "")

colnames(testData) <- features$V2

#Loading Y test file
testY <- read.table("UCI HAR Dataset/Test/Y_test.txt",sep = "")

colnames(testY) <- "id"

testData <- cbind(testY,testData)

testData <- merge(labels,testData)


##########################
######  TRAIN DATA  ######  
##########################
#loading train Data
trainData <- read.table("UCI HAR Dataset/Train/X_train.txt",sep = "")

colnames(trainData) <- features$V2

#Loading Y train file
trainY <- read.table("UCI HAR Dataset/Train/Y_train.txt",sep = "")

colnames(trainY) <- "id"

trainData <- cbind(trainY,trainData)

trainData <- merge(labels,trainData)


##########################
######  UNION DATA  ######  
##########################

finalData <- rbind(trainData,testData)

#Extracting only mean and std columns
finalData <- finalData[grepl('activity|mean|std',colnames(finalData))]

finalData <- finalData[!grepl('meanFreq',colnames(finalData))]


datacolnames <- colnames(finalData)


datacolnames <- sapply(datacolnames,sub,pattern="tBodyAccJerk",replacement="Body accelerometer jerk time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyAcc",replacement="Body accelerometer time")
datacolnames <- sapply(datacolnames,sub,pattern="tGravityAccMag",replacement="Gravity accelerometer magnitude time")
datacolnames <- sapply(datacolnames,sub,pattern="tGravityAcc",replacement="Gravity accelerometer time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyGyroJerk",replacement="Body gyroscope jerk time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyGyro",replacement="Body gyroscope time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyAccMag",replacement="Body accelerometer magnitude time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyAccJerkMag",replacement="Body accelerometer magnitude jerk time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyGyroMag",replacement="Body gyroscope magnitude time")
datacolnames <- sapply(datacolnames,sub,pattern="tBodyGyroJerkMag",replacement="Body accelerometer magnitude time")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyAccJerk",replacement="Body accelerometer jerk frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyAcc",replacement="Body accelerometer frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyBodyGyroMag",replacement="Body gyroscope magnitude frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyBodyAccMag",replacement="Body accelerometer magnitude frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyBodyAccJerkMag",replacement="Body accelerometer magnitude jerk frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyBodyGyroJerkMag",replacement="Body gyroscope magnitude jerk frequency")
datacolnames <- sapply(datacolnames,sub,pattern="fBodyBodyGyro",replacement="Body gyroscope frequency")

datacolnames <- sapply(datacolnames,sub,pattern="()",replacement="",fixed=TRUE)

datacolnames <- sapply(datacolnames,sub,pattern="std",replacement="Standard deviation")

datacolnames <- sapply(datacolnames,gsub,pattern="-",replacement=" ")

colnames(finalData) <- datacolnames

##########################
######  MEAN        ######  
##########################
meanData <- aggregate(finalData,list(finalData$activity),mean)
meanData$activity <- meanData$Group.1
meanData <- meanData[,-1]


write.table(meanData,"outputdata.txt",row.name=FALSE)