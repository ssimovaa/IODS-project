# Data wrangling - RStudio exercixe 5 / IODS
#
# Meta data and technical details available at http://hdr.undp.org/en/content/human-development-index-hdi
# 
#
# Susanna Simovaara
# 2020-11-19
#
###########################################

# access the dplyr library
library(dplyr)

# read datasets into memory
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore structure and dimensions of both datasets
str(hd)
str(gii)

# to be continued (but I need a nap first)

