# first step is to load in the relevant packages for cleaning the data
## I may not use all of these packages
library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)
library(here)

# test where the top level of the project directory is 
here::here()

seabirds_raw_data <- read_excel(here("raw_data/seabirds.xls"))

# now to take a look at some of the meta data
## loading in the raw data - as a personal preference I also like to view the data at this point
seabirds_raw_data <- read_excel(here("raw_data/seabirds.xls"))
## and how many sheets does the excel file contain
excel_sheets("raw_data/seabirds.xls")

## dimensions of dataset
dim(seabirds_raw_data)

## investigate columns 
view(seabirds_raw_data)

## total number of missing values in dataset
sum(is.na(seabirds_raw_data))

## how many rows are lost if you drop NAs
nrow(seabirds_raw_data) - nrow(drop_na(seabirds_raw_data))
glimpse(seabirds_raw_data)

# discovered that this doesn't work eg can't use the here command and load in a specific sheet
seabirds_raw_data_Bird_data_by_record_ID <- read_excel(here("raw_data/seabirds.xls",
                                                            sheet = "Bird data by record ID"))

# so at present I'm just loading in the data and not using the here command

Bird_data_by_record_ID <- read_excel("raw_data/seabirds.xls",
                                     sheet = "Bird data by record ID")
Bird_data_by_record_ID <- read_excel(here("raw_data/seabirds.xls"), sheet = "Bird data by record ID") # receiving error message "warning message: expecting logical in I21756 / R21756C9: got 'M'"; having looked at the data I can see there is one entry 

# this error can be resolved by upping the guess_max from it's default 1000 to 30000 - taking it past the issue.
Bird_data_by_record_ID <- read_excel(here("raw_data/seabirds.xls"), sheet = "Bird data by record ID", guess_max = 30000)


Ship_data_by_record_ID <- read_excel("raw_data/seabirds.xls",
                                                       sheet = "Ship data by record ID")
Ship_data_by_record_ID <- read_excel(here("raw_data/seabirds.xls"), sheet = "Ship data by record ID")

Ship_data_codes <- read_excel("raw_data/seabirds.xls",
                                                       sheet = "Ship data codes")
Ship_data_codes <- read_excel(here("raw_data/seabirds.xls"), sheet = "Ship data codes")

Bird_data_codes <- read_excel("raw_data/seabirds.xls",
                                                       sheet = "Bird data codes")
Bird_data_codes <- read_excel(here("raw_data/seabirds.xls"), sheet = "Bird data codes")


# just a personal prefernce to view the data
view(seabirds_raw_data)
view(Bird_data_by_record_ID)
view(Ship_data_by_record_ID)
view(Ship_data_codes)
view(Bird_data_codes)




what_does_data_look_like_after_using_clean_names <- clean_names(seabirds_raw_data)

view(what_does_data_look_like_after_using_clean_names)


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

# picking up the file needing missing lat and long values addressed

# replacing any missing values in latitude (LAT) or longitude (LONG) with 0
lat_long_NA_replaced_by_mutate <- cleaned_seabird_data %>% mutate(LAT = coalesce(LAT, 0, na.rm = TRUE),
                                                                  LONG = coalesce(LONG, 0, na.rm = TRUE))

# writing this back to our clean data folder
write_csv(lat_long_NA_replaced_by_mutate, "clean_data/cleaned_seabird_data_lat_long_zeros.csv")
