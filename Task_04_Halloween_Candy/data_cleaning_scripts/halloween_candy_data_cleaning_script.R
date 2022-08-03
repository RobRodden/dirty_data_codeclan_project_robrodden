# first step is to load in the relevant packages for cleaning the data
## I may not use all of these packages
library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)
library(here)

# test where the top level of the project directory is 
here::here()

# laading in relevant data
boing_boing_candy_2015 <- read_excel(here("raw_data/boing-boing-candy-2015.xlsx"))
boing_boing_candy_2016 <- read_excel(here("raw_data/boing-boing-candy-2016.xlsx"))
boing_boing_candy_2017 <- read_excel(here("raw_data/boing-boing-candy-2017.xlsx"))

# now to take a look at some of the meta data
## loading in the raw data - as a personal preference I also like to view the data at this point
view(boing_boing_candy_2015)
view(boing_boing_candy_2016)
view(boing_boing_candy_2017)

## and how many sheets does the excel file contain
excel_sheets("raw_data/boing-boing-candy-2015.xlsx")  # only 1 sheet contained.
excel_sheets("raw_data/boing-boing-candy-2016.xlsx")  # only 1 sheet contained.
excel_sheets("raw_data/boing-boing-candy-2017.xlsx")  # only 1 sheet contained.

## dimensions of dataset
dim(boing_boing_candy_2015) # 5630  124
dim(boing_boing_candy_2016) # 1259  123
dim(boing_boing_candy_2017) # 2460  120

## total number of missing values in dataset
sum(is.na(boing_boing_candy_2015)) # 127747
sum(is.na(boing_boing_candy_2016)) # 12133
sum(is.na(boing_boing_candy_2017)) # 96592

## how many rows are lost if you drop NAs
nrow(boing_boing_candy_2015) - nrow(drop_na(boing_boing_candy_2015)) # zero rows lost
nrow(boing_boing_candy_2016) - nrow(drop_na(boing_boing_candy_2016)) # zero rows lost
nrow(boing_boing_candy_2017) - nrow(drop_na(boing_boing_candy_2017)) # zero rows lost

# good practice for me to use glimpse, however, results are not happy viewing.
glimpse(boing_boing_candy_2015)
glimpse(boing_boing_candy_2016)
glimpse(boing_boing_candy_2017)

# clean names using janitor
boing_boing_candy_2015_cleaned_names <- clean_names(boing_boing_candy_2015)
boing_boing_candy_2016_cleaned_names <- clean_names(boing_boing_candy_2016)
boing_boing_candy_2017_cleaned_names <- clean_names(boing_boing_candy_2017)
view(boing_boing_candy_2015_cleaned_names)

# at this point I like to have a look at the column names - to try and establish if the column names match up
names(boing_boing_candy_2015_cleaned_names)
names(boing_boing_candy_2016_cleaned_names)
names(boing_boing_candy_2017_cleaned_names)

# awful lot of 2017 start with "q6_" - found this little gem on stack overflow 
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q6_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)

# to save time i'm going to use the above formula to sort out some of the other columns
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q1_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q2_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q3_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q4_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q5_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q7_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q8_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q9_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q10_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q11_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)
colnames(boing_boing_candy_2017_cleaned_names) <- gsub('q12_', '', colnames(boing_boing_candy_2017_cleaned_names), fixed=TRUE)

# now to tidy up some other column names - to note, i've decided to order these chronologically (as opposed to the order I found the issue) as there is a problem that crops up relating to the 2015 file

boing_boing_candy_2015_cleaned_names <- rename(boing_boing_candy_2015_cleaned_names, boxo_raisins = box_o_raisins)

# it is at this point I realised that there appear to be 2 columns in this file (2015) for the same product ie "anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes" - having put out slack to see what others have done there wasn't an answer - update, I've decided to use identical
# update, the issue seems to also exist in the 2016 data

identical(boing_boing_candy_2015_cleaned_names[['anonymous_brown_globs_that_come_in_black_and_orange_wrappers']],boing_boing_candy_2015_cleaned_names[['mary_janes']])
# the response for 2015 is a TRUE therefore I'm going to ignore column 52 "mary_janes"
boing_boing_candy_2015_cleaned_names <- rename(boing_boing_candy_2015_cleaned_names, DO_NOT_USE_DUPLICATE_OF_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = mary_janes)
# quick check that it worked
names(boing_boing_candy_2015_cleaned_names)

# now to do 2016
identical(boing_boing_candy_2016[['anonymous_brown_globs_that_come_in_black_and_orange_wrappers']],boing_boing_candy_2016[['mary_janes']])
# the response for 2016 is a TRUE therefore I'm going to ignore column 52 "mary_janes"
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, DO_NOT_USE_DUPLICATE_OF_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = mary_janes)
# quick check that it worked
names(boing_boing_candy_2016_cleaned_names)


# we can now continue with renaming columns
boing_boing_candy_2015_cleaned_names <- rename(boing_boing_candy_2015_cleaned_names, anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, gender = your_gender)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, sweetums = sweetums_a_friend_to_diabetes)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, country = which_country_do_you_live_in)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers)
boing_boing_candy_2017_cleaned_names <- rename(boing_boing_candy_2017_cleaned_names, how_old_are_you = age)
boing_boing_candy_2017_cleaned_names <- rename(boing_boing_candy_2017_cleaned_names, sweetums = sweetums_a_friend_to_diabetes)

# quick review of our work
names(boing_boing_candy_2015_cleaned_names)
names(boing_boing_candy_2016_cleaned_names)
names(boing_boing_candy_2017_cleaned_names)


# going to try joining
joined_bbc_2015_2016_2017 <- bind_rows(boing_boing_candy_2015_cleaned_names, boing_boing_candy_2016_cleaned_names, boing_boing_candy_2017_cleaned_names)
view(joined_bbc_2015_2016_2017)
names(joined_bbc_2015_2016_2017)

# decided that things would be a lot easier if the columns were order alphabetically
joined_bbc_2015_2016_2017_column_alphab <- joined_bbc_2015_2016_2017[,order(colnames(joined_bbc_2015_2016_2017))]
names(joined_bbc_2015_2016_2017_column_alphab)
# glad I did this, found a column straight away that needs changed - have added this to the other name changes above



candy_2015 <- read_xlsx(here("raw_data/boing-boing-candy-2015.xlsx")) %>% 
  clean_names()

identical(candy_2015$anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
          candy_2015$mary_janes)

candy_2015 %>% 
  select(anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
         mary_janes)



# testing how the data looks once joined
joined_BD_record_ID_and_SD_record_ID_IJ <- inner_join(Bird_data_by_record_ID, Ship_data_by_record_ID, by = "RECORD ID")
joined_BD_record_ID_and_SD_record_ID_LJ <- left_join(Bird_data_by_record_ID, Ship_data_by_record_ID, by = "RECORD ID")
joined_BD_record_ID_and_SD_record_ID_RJ <- right_join(Bird_data_by_record_ID, Ship_data_by_record_ID, by = "RECORD ID")
## interesting to note that there is only one difference in the number of rows between these joins eg innner join results in 49,018 rows (by 52) where as the LJ results in 49,019 (by 52); at a later point I decided to add a right join as a comparison - only learned that 
## given that we are interested in the bird data then I'm goin to use the LJ - I can then work out what relevance that extra line has and remove it if necessary.

view(joined_BD_record_ID_and_SD_record_ID)


nrow(joined_BD_record_ID_and_SD_record_ID_IJ) - nrow(drop_na(joined_BD_record_ID_and_SD_record_ID_IJ))
view(joined_BD_record_ID_and_SD_record_ID_IJ)


# At this point I'm going to select only the columns that I think I need
names(joined_BD_record_ID_and_SD_record_ID_LJ)
## interesting to note that there are 2 columns that don't appear when you view the data but are there when you invoke the names command eg LATCELL AND LONGCELL.
joined_BD_record_ID_and_SD_record_ID_LJ_specific_columns <- joined_BD_record_ID_and_SD_record_ID_LJ %>% 
  select(RECORD.x, `RECORD ID`, `Species common name (taxon [AGE / SEX / PLUMAGE PHASE])`, `Species  scientific name (taxon [AGE /SEX /  PLUMAGE PHASE])`, `Species abbreviation`, COUNT, DATE, LAT, LONG, LATCELL, LONGECELL)
view(joined_BD_record_ID_and_SD_record_ID_LJ_specific_columns)

# writing the cleaned data to a markdown file
write_csv(joined_BD_record_ID_and_SD_record_ID_LJ_specific_columns, "clean_data/cleaned_seabird_data.csv")

# as indicated at line 43 in the file 'documentation_and_analysis.Rmd" picking up the file needing missing lat and long values addressed.

# replacing any missing values in latitude (LAT) or longitude (LONG) with 0
lat_long_NA_replaced_by_mutate <- cleaned_seabird_data %>% mutate(LAT = coalesce(LAT, 0, na.rm = TRUE),
                                                                  LONG = coalesce(LONG, 0, na.rm = TRUE))

# writing this back to our clean data folder
write_csv(lat_long_NA_replaced_by_mutate, "clean_data/cleaned_seabird_data_lat_long_zeros.csv")




### alt version
test_specific_columns <- joined_BD_record_ID_and_SD_record_ID_LJ %>% 
  select(`Species abbreviation`, COUNT)
view(test_specific_columns)
write_csv(test_specific_columns, "clean_data/test_specific_columns.csv")
