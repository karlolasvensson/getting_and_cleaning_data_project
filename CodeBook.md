# Script

The script has 5 different steps to get a tidy data set.

* First step is to merge training and test data to one data set
* Second step extracts the mean and standard deviation for each measurement
* Third step adds descriptive names to the data set
* Fourth step adds labels with descriptive variable names to the data set
* Fifth step is a tidy data set created

# Variables

* *data_train_x*,  *data_train_y*, *data_train_subject*, *data_test_x*, *data_test_y*, *data_test_subject* is data extracted from the downlaoded data set
* *data_subject*, *data_activity*, *data_features* is the merged data from data in the previous step
* *data_features* contains the name for *data_subject*
* *data_activities* is done in the same way as *data_features* 
* *data_all* is the merged data set from *data_subject*, *data_activity*, *data_features*
