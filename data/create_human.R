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
hd_df <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gi_df <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore structure and dimensions of both datasets
str(hd_df)
str(gi_df)

# to be continued (but I need a nap first)

# create summaries of the variables
summary(hd_df)
summary(gi_df)

glimpse(hd_df)
glimpse(gi_df)

# rename columns with shorter names
hd_df <- rename(hd_df, c("HDIR" = "HDI.Rank", 
             "Country" = "Country",
             "HDI" = "Human.Development.Index..HDI.", 
             "LE" = "Life.Expectancy.at.Birth", 
             "EDS" = "Expected.Years.of.Education", 
             "MYS" = "Mean.Years.of.Education", 
             "GNIpc" = "Gross.National.Income..GNI..per.Capita",
             "GNIpc-HDIR" = "GNI.per.Capita.Rank.Minus.HDI.Rank"))
gi_df <- rename(gi_df, c("GIIR" = "GII.Rank",
              "Country" = "Country",
              "GII" = "Gender.Inequality.Index..GII.",
              "MMR" = "Maternal.Mortality.Ratio",
              "ABR" = "Adolescent.Birth.Rate",
              "PR" = "Percent.Representation.in.Parliament",
              "SE_f" = "Population.with.Secondary.Education..Female.",
              "SE_m" = "Population.with.Secondary.Education..Male.",
              "LFPR_f" = "Labour.Force.Participation.Rate..Female.",
              "LFPR_m" = "Labour.Force.Participation.Rate..Male."))

# create variables 'SE_fbym' and 'LFPR_fbym' in gi_df
gi_df <- mutate(gi_df, SE_fbym = SE_f / SE_m, LFPR_fbym = LFPR_f / LFPR_m)
colnames(gi_df)

# join hd_df and gi_df by Country
human <- inner_join(hd_df, gi_df, by = "Country")
colnames(human)
str(human)

# save df human in IODS data folder
getwd()
write.csv(human, file = 'data/human.csv', row.names = FALSE)

# read saved df to memory and check that everything is in order 
# (according to exercise instructions should be 195 obs, 19 var)
check <- read.csv(file = 'data/human.csv')
str(check)
# checks out fine
