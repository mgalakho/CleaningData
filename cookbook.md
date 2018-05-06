# Human activity projec's codebook

This describes the different processing steps of the script

## Varibles used in the script

* labels : dataframe containing the ids and activity names
* features : list of variables of the data Y files
* testData/trainData : dataframes containing raw data from files
* testY/trainY : dataframes containing the activity id for each row in the X files
* finalData : union of formated test and train data
* datacolnames : colum names from finalData dataframe
* meanData : aggregated data from finalData

## Transformations :

* Loading activity labels
* Renaming activity label's column names
* Loading feature list
* Loading test data
* Modifying test data column names from features
* Reading test data activcity ids
* Renaming activity ids dataframe as id
* Adding activity id columns to test dataframe
* Joining test dataframe to activity dataframe to get activity names
* Loading train data
* Modifying train data column names from features
* Reading train data activcity ids
* Renaming activity ids dataframe as id
* Adding activity id columns to train dataframe
* Joining train dataframe to activity dataframe to get activity names
* Joining test and train dataframes
* Keeping only activity and mean/std columns
* Transforming column names to explicit names
* Aggregating columns
* Writing final output file
