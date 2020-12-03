# Data wrangling - RStudio exercixe 6 / IODS
#
# BPRS data originates from Davis, C. S. (2002). Statistical Methods 
# for the Analysis of Repeated Measurements. Springer, New York.

# 40 male subjects were randomly assigned to one of two treatment groups 
# and each subject was rated on the brief psychiatric rating scale (BPRS) 
# measured before treatment began (week 0) and then at weekly intervals 
# for eight weeks. The BPRS assesses the level of 18 symptom constructs 
# such as hostility, suspiciousness, hallucinations and grandiosity; 
# each of these is rated from one (not present) to seven (extremely severe). 
# The scale is used to evaluate patients suspected of having schizophrenia.
#
# RATS data is from a nutrition study conducted in three groups of rats
# by Crowder and Hand (1990). Crowder, M. J. and Hand, D. J. (1990). 
# Analysis of Repeated Measurements. Chapman and Hall, London. 
#
# The three groups were put on different diets, and each animal’s body weight
# (grams) was recorded repeatedly (approximately weekly, except in week seven
# when two recordings were taken) over a 9-week period.

# Susanna Simovaara
# 2020-12-03
#
###########################################

# access libraries
library(dplyr); library(tidyr)

# read datasets into memory
BPRS <- read.table(file = "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)
RATS <- read.table(file = "https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

# check column names in both datasets
names(BPRS)
names(RATS)

# explore structure and dimensions of both datasets
str(BPRS)
str(RATS)

# print summaries of both datasets 
summary(BPRS)
summary(RATS)

# convert character variables to factors in both datasets
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert both datasets to long form
#   the arguments to gather():
#      key: Name of new key column (made from names of data columns)
#      value: Name of new value column
#      ...: Names of source columns that contain values
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <- RATS %>% gather(key = WDs, value = weight, -ID, -Group)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- RATSL %>% mutate(Time = as.integer(substr(WDs,3,4)))

# Take a glimpse at both datasets
glimpse(BPRSL)
glimpse(RATSL)

# explore structure and dimensions of both datasets
str(BPRSL)
str(RATSL)

# print summaries of both datasets 
summary(BPRSL)
summary(RATSL)

# save both datasets in long and wide form in IODS data folder
getwd()
write.csv(BPRS, file = 'data/BPRS.csv', row.names = FALSE)
write.csv(RATS, file = 'data/RATS.csv', row.names = FALSE)
write.csv(BPRSL, file = 'data/BPRSL.csv', row.names = FALSE)
write.csv(RATSL, file = 'data/RATSL.csv', row.names = FALSE)

# read saved dataframes to memory and check that everything is in order 
check_a <- read.csv(file = 'data/BPRS.csv')
check_b <- read.csv(file = 'data/RATS.csv')
check_c <- read.csv(file = 'data/BPRSL.csv')
check_d <- read.csv(file = 'data/RATSL.csv')
head(check_a)
head(check_b)
head(check_c)
head(check_d)
# all check out fine
