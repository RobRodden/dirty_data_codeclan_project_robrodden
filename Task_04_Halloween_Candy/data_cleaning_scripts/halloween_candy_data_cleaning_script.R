# first step is to load in the relevant packages for cleaning the data
## I may not use all of these packages
library(tidyverse)
library(dplyr)
library(readxl)
library(janitor)
library(here)
library(lubridate)
library(stringr)

# test where the top level of the project directory is 
here::here()

# laading in relevant data
boing_boing_candy_2015 <- read_excel(here("raw_data/boing-boing-candy-2015.xlsx"))
boing_boing_candy_2016 <- read_excel(here("raw_data/boing-boing-candy-2016.xlsx"))
boing_boing_candy_2017 <- read_excel(here("raw_data/boing-boing-candy-2017.xlsx"))

# having learned that at a later point I want 2017 to have a timestamp column i'm going to add it here (I reference this again at line 159):
boing_boing_candy_2017 <- boing_boing_candy_2017 %>% 
  mutate(timestamp   = ymd_hm("2017-01-01 12:00"))
glimpse(boing_boing_candy_2017)
view(boing_boing_candy_2017)

    # working version - but bad way of doing it
    # timestamp <- c(2017-01-01)
    # boing_boing_candy_2017 <- cbind(boing_boing_candy_2017, timestamp)
    # boing_boing_candy_2017$timestamp <- ymd(boing_boing_candy_2017$timestamp)
    # class(boing_boing_candy_2017$timestamp)

    # all my failed attempts
    # boing_boing_candy_2017$timestamp <- as.Date(boing_boing_candy_2017$timestamp , format = "%m/%d/%y")
    # as.Date(boing_boing_candy_2017$timestamp,format = "%y-%m-%d")
    # mutate(boing_boing_candy_2017, timestamp = as.Date(timestamp, format = "%m/%d/%Y"))
    # class(boing_boing_candy_2017$timestamp)

    # nope didn't work
    # boing_boing_candy_2017 %>% 
    # mutate(timestamp = ymd(timestamp))


# back to our cleaning
view(boing_boing_candy_2017)
glimpse(boing_boing_candy_2017)
glimpse(boing_boing_candy_2016)


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


# at this point I like to have a look at the column names - to try and establish if the column names match up; I also like to open the files if possible; and see if there are any missing values
names(boing_boing_candy_2015_cleaned_names)
names(boing_boing_candy_2016_cleaned_names)
names(boing_boing_candy_2017_cleaned_names)
view(boing_boing_candy_2015_cleaned_names)
view(boing_boing_candy_2016_cleaned_names)
view(boing_boing_candy_2017_cleaned_names)
boing_boing_candy_2015_cleaned_names %>% 
  summarise(across(.fns = ~ sum(is.na(.x))))
boing_boing_candy_2016_cleaned_names %>% 
  summarise(across(.fns = ~ sum(is.na(.x))))
boing_boing_candy_2017_cleaned_names %>% 
  summarise(across(.fns = ~ sum(is.na(.x))))


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
# the response for 2015 is a FALSE therefore I'm going to ignore column 52 "mary_janes" - if I had some more expertise / and time at this point I would probably look to see if one column was a more complete version of the other.

boing_boing_candy_2015_cleaned_names <- rename(boing_boing_candy_2015_cleaned_names, DO_NOT_USE_DUPLICATE_PRODUCT_OF_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = mary_janes)
# quick check that it worked
names(boing_boing_candy_2015_cleaned_names)

# now to do 2016
identical(boing_boing_candy_2016_cleaned_names[['anonymous_brown_globs_that_come_in_black_and_orange_wrappers']],boing_boing_candy_2016_cleaned_names[['mary_janes']])
# the response for 2016 is a TRUE therefore I'm going to ignore column 52 "mary_janes"
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, DO_NOT_USE_DUPLICATE_PRODUCT_OF_anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = mary_janes)
# quick check that it worked
names(boing_boing_candy_2016_cleaned_names)


# we can now continue with renaming columns
boing_boing_candy_2015_cleaned_names <- rename(boing_boing_candy_2015_cleaned_names, anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, gender = your_gender)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, sweetums = sweetums_a_friend_to_diabetes)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, country = which_country_do_you_live_in)
boing_boing_candy_2016_cleaned_names <- rename(boing_boing_candy_2016_cleaned_names, anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes = anonymous_brown_globs_that_come_in_black_and_orange_wrappers)
boing_boing_candy_2017_cleaned_names <- rename(boing_boing_candy_2017_cleaned_names, how_old_are_you = age)
boing_boing_candy_2017_cleaned_names <- rename(boing_boing_candy_2017_cleaned_names, x100_grand_bar = "100_grand_bar")
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
view(joined_bbc_2015_2016_2017_column_alphab)

# glad I did this, found a column straight away that needs changed - have added this to the other name changes above

# I will make a note that I think there's a potential issue around [76] "licorice", [77] "licorice_not_black" and [78] "licorice_yes_black" ie there's overlap

# at this point I've decided to add data to the 'Timestamp' field specifically so there is a 'date' attached to 2017 - I've checked previously and i know that the 'Timestamp' colummns in both 2015 and 2016 are full (so no chance of adding the wrong date to them) - I've done this at line 18.

# now to remove those columns that we don't think we need - yes, I could probably have done this earlier but I want to see the columns fixed first to ensure I didn't remove any inadvertently.

# this helps me identify which columns to select
names(joined_bbc_2015_2016_2017_column_alphab)

## I should also point out that there is a boing boing article on the dataset which is a good guide for which columns to pick.
joined_bbc_2015_2016_2017_column_alphab_specific_columns <- joined_bbc_2015_2016_2017_column_alphab %>% 
  select(anonymous_brown_globs_that_come_in_black_and_orange_wrappers_a_k_a_mary_janes, any_full_sized_candy_bar, black_jacks, blue_m_ms, bonkers_the_board_game:boxo_raisins, broken_glow_stick:caramellos, chick_o_sticks_we_don_t_know_what_that_is, chiclets, coffee_crisp, country, dark_chocolate_hershey, fuzzy_peaches:glow_sticks, goo_goo_clusters:green_party_m_ms, gum_from_baseball_cards:hard_candy, heath_bar:how_old_are_you, independent_m_ms, internal_id:jolly_ranchers_good_flavor, junior_mints, kinder_happy_hippo:maynards, mike_and_ike:nown_laters, peanut_butter_bars:peeps, pixy_stix, red_m_ms:sourpatch_kids_i_e_abominations_of_nature, starburst, swedish_fish:take_5, third_party_m_ms:vials_of_pure_high_fructose_corn_syrup_for_main_lining_into_your_vein, whatchamacallit_bars, x100_grand_bar, york_peppermint_patties)
view(joined_bbc_2015_2016_2017_column_alphab_specific_columns)

# writing the cleaned data to a markdown file
write_csv(joined_bbc_2015_2016_2017_column_alphab_specific_columns, "clean_data/cleaned_halloween_candy_data.csv")

HC_data_cleaning_v2 <- read_csv(here("clean_data/cleaned_halloween_candy_data.csv"))
view(HC_data_cleaning_v2)
names(HC_data_cleaning_v2)

# now lets condense the information as we can make it more compact and user friendly - to do this we first need to get the columns in a suitable order

HC_data_cleaning_v2 <- HC_data_cleaning_v2 %>% select(c(98,19,22,36,38), everything())

names(HC_data_cleaning_v2)
view(HC_data_cleaning_v2)

HC_data_cleaning_v2_long <- HC_data_cleaning_v2 %>% 
  pivot_longer(6:105, names_to = "Candy", values_to = "Rating")
names(HC_data_cleaning_v2_long)
view(HC_data_cleaning_v2_long)

# right, now to try cleaning the actual data in the columns:
HC_data_cleaning_v2_long %>% 
  filter(str_replace_all(country, pattern = "\\'merica", USA))


filter(str_detect(species_common_name_taxon_age_sex_plumage_phase, pattern = "[Pp]enguin")) 


# and am going to see if there are any "easy wins" 

joined_bbc_2015_2016_2017_column_alphab %>% 
  summarise(across(.fns = ~ sum(is.na(.x))))

# comparison code from a colleague - this was so that I could check my identical usage was correct, which it wasn't
# candy_2015 <- read_xlsx(here("raw_data/boing-boing-candy-2015.xlsx")) %>% 
#  clean_names()
# identical(candy_2015$anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
#          candy_2015$mary_janes)
# candy_2015 %>% 
#  select(anonymous_brown_globs_that_come_in_black_and_orange_wrappers,
#         mary_janes)

# checking if there are any rows that can be dropped due to lack of data 
nrow(HC_data_cleaning_v2) - nrow(drop_na(HC_data_cleaning_v2)) # 9,349 - so not at this stage


view(joined_BD_record_ID_and_SD_record_ID_IJ)


# as indicated at line 43 in the file 'documentation_and_analysis.Rmd" picking up the file needing missing lat and long values addressed.

# replacing any missing values in latitude (LAT) or longitude (LONG) with 0
lat_long_NA_replaced_by_mutate <- cleaned_seabird_data %>% mutate(LAT = coalesce(LAT, 0, na.rm = TRUE),
                                                                  LONG = coalesce(LONG, 0, na.rm = TRUE))


