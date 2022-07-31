# first step is to load in the relevant packages for cleaning the data
1library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)
library(here)

#test where the top level of the project directory is 
here::here()

seabirds_raw_data <- read_excel(here("raw_data/seabirds.xls"))

# now to take a look at some of the meta data and how many sheets does the excel file contain
excel_sheets("raw_data/seabirds.xls")
glimpse(seabirds_raw_data)


# loading in the raw data - as a personal preference I also like to view the data at this point
seabirds_raw_data <- read_excel(here("raw_data/seabirds.xls"))

seabirds_raw_data_Bird_data_by_record_ID <- read_excel(here("raw_data/seabirds.xls",
                                                            sheet = "Bird data by record ID")) #at this point I found a problem, namely that trying to load in an excel sheet doesn't like using the here function.

seabirds_raw_data_Bird_data_by_record_ID <- read_excel("raw_data/seabirds.xls",
                                                            sheet = "Bird data by record ID")
view(seabirds_raw_data_Bird_data_by_record_ID)

# example seedmix_north <- read_excel("data/edinburgh_seedmix.xlsx", sheet = "North Neighbourhood")
view(seabirds_raw_data)



what_does_data_look_like_after_using_clean_names <- clean_names(seabirds_raw_data)

view(what_does_data_look_like_after_using_clean_names)



read_ex

inner_join("Bird data by record ID", "ship by record ID", by = "RECORD ID")
