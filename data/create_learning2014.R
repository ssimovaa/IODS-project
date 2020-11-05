# My first R script
#
# learning2014 data from http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt 
#
# Susanna Simovaara
# 2020-11-05
#
###########################################

# read data into R
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# explore dataset dimensions
dim(lrn14)    
# nr of observations (rows), nr of variables (columns)
## [1] 183  60

# explore dataset structure
str(lrn14)   
# list of variables with sample of observations
## 'data.frame':	183 obs. of  60 variables:
## $ Aa      : int  3 2 4 4 3 4 4 3 2 3 ...
## ...
## $ Age     : int  53 55 49 53 49 38 50 37 37 42 ...
## $ Attitude: int  37 31 25 35 37 38 35 29 38 21 ...
## $ Points  : int  25 12 24 10 22 21 21 31 24 26 ...
## $ gender  : chr  "F" "M" "F" "M" ...

# Access package 'dplyr'
library(dplyr)

# create variables gender, age, attitude, deep, stra, surf, points

# questions related to deep, surface and strategic learning
# as defined in http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt 
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# check structure of the new dataset
str(learning2014)

# print out the column names
colnames(learning2014)

# change column names
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

# print out the new column names
colnames(learning2014)

# filter out zeros
learning2014 <- filter(learning2014, points > 0)

# check structure of the dataset
str(learning2014)
## 'data.frame':	166 obs. of  7 variables:
## $ gender  : chr  "F" "M" "F" "M" ...
## $ age     : int  53 55 49 53 49 38 50 37 37 42 ...
## $ attitude: int  37 31 25 35 37 38 35 29 38 21 ...
## $ deep    : num  3.58 2.92 3.5 3.5 3.67 ...
## $ stra    : num  3.38 2.75 3.62 3.12 3.62 ...
## $ surf    : num  2.58 3.17 2.25 2.25 2.83 ...
## $ points  : int  25 12 24 10 22 21 21 31 24 26 ...

# check current working directory
getwd()

# export dataset as .csv-file project folder
write.csv(learning2014, "C:/Users/Susanna/Documents/IODS/IODS-project/learning2014.csv", row.names = FALSE)

#check readability of exported data frame
learn <- read.csv("C:/Users/Susanna/Documents/IODS/IODS-project/learning2014.csv")
head(learn)
str(learn)
