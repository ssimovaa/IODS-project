# Data wrangling cont. - RStudio exercixe 5 / IODS
#
# The `human` dataset originates from the United Nations Development Programme. 
# Original data from http://hdr.undp.org/en/content/human-development-index-hdi
#
# Retrieved, modified and analyzed by 
# Susanna Simovaara
# 2020-11-25
#
# Most of the variable names in the data have been shortened 
# and two new variables have been computed.
#
# For IODS exercise 5 only following variables are needed:
# `Country` = Country name  
# `GNIpc` = Gross National Income per capita  
# `LE` = Life expectancy at birth  
# `EDS` = Expected years of schooling   
# `MMR` = Maternal mortality ratio  
# `ABR` = Adolescent birth rate  
# `PR` = Percentage of female representatives in parliament  
# `SE_f` = Proportion of females with at least secondary education  
# `LFPR_f` = Proportion of females in the labour force 
#
###########################################

# access libraries
library(dplyr); library(countrycode)

# read dataset into memory
human <- read.csv(file = 'data/human.csv')

# explore structure and dimensions of the dataset
str(human)
# df `human` has 195 observations (rows) of 19 variables (columns). 

# keep selected variables only
myvars <- c("Country", "GNIpc", "LE", "EDS", "MMR", "ABR", "PR", "SE_f", "LFPR_f")
human <- human[myvars]

# explore df structure again 
str(human)
# `human` now contains 195 rows and 9 columns.
## Most columns have numeric or integer values but 
### `Country` and `GNIpc` are character variables.
### `Country` appears to have a unique value for each row.
### `GNIpc` actually has numeric values but with commas.

# check for missing data
sum(is.na(human))
# There are 55 missing cases.

# remove commas in `GNIpc`, then mutate as numeric 
human$GNIpc <- as.numeric(gsub(",", "", human$GNIpc))
str(human$GNIpc)

# check 'Country' names and add column with proper country names only
human$countrycheck <- countrycode(human$Country, origin="country.name", 
                                  destination = "country.name")

# print rows where `Country` is not a country
subset(human, is.na(human$countrycheck))
# The dataset includes rows (189-195) with data on regional or global level. 
# "Non-country" rows are now marked by NA in column `countrycheck`.

# Keep only rows with complete data i.e. remove all rows with NA
human <- filter(human, complete.cases(human))

# remove 'countrycheck' column
human <- select(human, -countrycheck)

# Use 'Country' as row names
human <- data.frame(human, row.names = 1)

# check first rows and df dimensions
head(human)
dim(human)
# df `human` now has 155 rows of 8 columns, and countries as row names

# save df human in IODS data folder as `new_human`
getwd()
write.csv(human, file = 'data/new_human.csv')

# read saved df to memory and check that everything is in order 
check <- read.csv(file = 'data/new_human.csv', row.names = 1)
head(check)
# checks out fine

