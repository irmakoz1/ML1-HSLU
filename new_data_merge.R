rm(list = ls())



library(tidyr)
library(stringr)
library(dplyr)
setwd("C:/Users/irmak/Desktop/datascience/lulzern/ML/ML1-HSLU")
GEM<-read.csv("raw_data/global_economy_indicators.csv")
GEM<-na.omit(GEM)

election<-read.csv("raw_data/global_leader_ideologies.csv")
colnames(election)[colnames(election) == "country_name"] <- "Country"
colnames(election)[colnames(election) == "year"] <- "Year"
elections<-subset(election, Year >= 1990 & Year<=2020)

 
gem_data<-subset(GEM, Year >= 1990 & Year<=2020)
gem_data <- gem_data %>% select(-"CountryID")
gem_data <- gem_data %>%
  mutate(Country = trimws(Country, which = "right"))
gem_data <- gem_data %>%
  mutate(Country = trimws(Country, which = "left"))
gem_data$Country[gem_data$Country == "Egypt Arab Rep."] <- "Egypt"
gem_data$Country[gem_data$Country == "Korea Rep."] <- "South Korea"
gem_data$Country[gem_data$Country == "Macedonia FYR"] <- "North Macedonia"
gem_data$Country[gem_data$Country == "Slovak Republic"] <- "Slovakia"
gem_data$Country[gem_data$Country == "Russian Federation"] <- "Russia"
gem_data$Country[gem_data$Country == "Taiwan China"] <- "Taiwan"
gem_data$Country[gem_data$Country == "United States"] <- "United States of America"

elecions<-
  elections %>%
  full_join(gem_data, by = c("Country","Year")) 

MS<-read.csv("raw_data/military_spending_dataset.csv")
MS_long <- MS %>%
  pivot_longer(
    cols = starts_with("X"),   # Select columns that start with 'X' followed by a year
    names_to = "Year",
    values_to = "Military expenditure (% of GDP)",
    values_drop_na=TRUE) 
MS_long$Year <- substr(MS_long$Year, 2, 5)
MS_long$Year<-as.numeric(MS_long$Year)

MS_long <- MS_long %>% select(c(-"Country.Code",-"Indicator.Code"))
colnames(MS_long)[colnames(MS_long) == "Country.Name"] <- "Country"
new_data3<-
  elecions %>%
  full_join(MS_long, by = c("Country","Year")) 
new_data3 <- new_data3 %>%
  filter(!is.na("Currency"))
new_data3<-na.omit(new_data3)
drops1y<-c("hog_ideology_num_full","hog_ideology_num_redux","leader_party_abbr","hog_title", "hog_party_id", "hog_party_abbr", "Indicator.Name","leader", "hog_party","hog","hog_right" ,"country_code_cow","hog_ideomiss","hog_party_eng","hog_left", "hog_center","hog_noideo","hog_noinfo","leader_party","leader_party_eng","leader_party_id","leader_position","leader_ideomiss","match_hog_hog_bls","leader_ideology_num_full", "leader_ideology_num_redux","leader_right","leader_left","leader_center","leader_noideo","leader_noinfo","match_hog_leader_m","match_leader_leader_m","match_hog_leader_chi","match_leader_leader_chi","hog_ideology_bls", "match_leader_hog_bls","leader_ideology_m","execrlc_dpi","hog_party_lr_ord_vdem")
new_data3<-new_data3[ , !(names(new_data3) %in% drops1y)]



new_data3<-subset(new_data3, Year >= 2000 & Year<=2020)
