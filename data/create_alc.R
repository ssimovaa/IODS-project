# Data wrangling - RStudio exercixe 3 / IODS
#
# Student Performance Data Set from http://archive.ics.uci.edu/ml/datasets/Student+Performance
# P. Cortez and A. Silva. 2008. Using Data Mining to Predict Secondary School Student Performance. 
# http://www3.dsi.uminho.pt/pcortez/student.pdf
#
# Susanna Simovaara
# 2020-11-12
#
###########################################

# access the dplyr library
library(dplyr)

# check working directory
getwd()

# download and unzip datasets
download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip", "data/student.zip")
unzip("data/student.zip")

# read datasets into memory
mat <- read.csv(file = 'data/student-mat.csv', sep = ";")
por <- read.csv(file = 'data/student-por.csv', sep = ";")

# explore structure and dimensions of both datasets
str(mat)
str(por)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".mat", ".por"))

# see the new column names
colnames(mat_por)

# glimpse at the data
glimpse(mat_por)

# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new joined data
glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the joined and modified data
glimpse(alc)

# save dataframe to IODS folder 'data'
write.csv(alc, file = 'data/alc.csv', row.names = FALSE)

# read saved dataframe to memory and check that everything is in order 
# (according to exercise instructions should be 382 obs, 35 var)
check <- read.csv(file = 'data/alc.csv')
str(check)
# checks out fine

