### How the script works.

#### 0. Get the data
Download and unzip the FUCI HAR dataset.
Read the training and test data into list object called X_test and X_train
Read the variable names from features.txt into a list object called features.
Read the activity IDs for the training and test datasets into lists train_labels and test_labels.

### 1. Merge the training and test sets into one big data set.
Use rbind to append X_test to the bottom of X_train, into one big list called X_all
Use the second column of features to give column names to the variables of X_all

### 2. Subset the data so that we keep all observations of mean and standard deviations of measurements.
Use grep to find the character pattern "mean" or "std" in the column names of X_all.
Create mean_std_data to contain only the columns of X_all returned by the grep function.

### 3. Name the activities with descriptive names.
Read the activity codes and descriptions from activity_labels.txt into a list called activities.
Read the activity codes for each row of the training and test data sets into respective vectors.
Append test_labels to train_labels with an rbind, like we did for the datasets.
Add a column to mean_std_data containing the labels, using cbind, and name the new object lbled_Data

### 4. Label the data set with descriptive variable names.
Add a column to lbled_Data that looks up the value of each label in the activities table and records the description. The new column is called Activity and is added with the mutate function.

### 5. Create a second dataset with the average of each variable by activity and subject.
This will require the reshape2 package.
First add the subject ID from the subject_train and subject_test lists. Rbind again into one column.
Add the subject column to lbled_Data using cbind, combining them into the DataToAverage table.
Melt the DataToAverage table by subject and activity.
Cast the molten DataToAverage table by subject and activity variables, and apply the mean function to aggregate the data.
Write the cast DataToAverage table to an output file.
