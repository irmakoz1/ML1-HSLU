# Clear workspace
rm(list = ls())

# Load required libraries
library(tidyr)
library(stringr)
library(dplyr)

# Set working directory
setwd("C:/Users/irmak/Desktop/datascience/lulzern/ML/ML1-HSLU")

# ------------------------------
# 1. Load and Clean Global Economy Indicators
# ------------------------------
GEM <- read.csv("raw_data/global_economy_indicators.csv") %>%
  na.omit() %>%
  subset(Year >= 1990 & Year <= 2020) %>%
  select(-CountryID) %>%
  mutate(Country = str_trim(Country, side = "both"))

# Rename country names
GEM$Country[GEM$Country == "Egypt Arab Rep."] <- "Egypt"
GEM$Country[GEM$Country == "Korea Rep."] <- "South Korea"
GEM$Country[GEM$Country == "Macedonia FYR"] <- "North Macedonia"
GEM$Country[GEM$Country == "Slovak Republic"] <- "Slovakia"
GEM$Country[GEM$Country == "Russian Federation"] <- "Russia"
GEM$Country[GEM$Country == "Taiwan China"] <- "Taiwan"
GEM$Country[GEM$Country == "United States"] <- "United States of America"

# ------------------------------
# 2. Load and Clean Election Data
# ------------------------------
election <- read.csv("raw_data/global_leader_ideologies.csv")
colnames(election)[colnames(election) == "country_name"] <- "Country"
colnames(election)[colnames(election) == "year"] <- "Year"
elections <- subset(election, Year >= 1990 & Year <= 2020)

# Merge election and GEM data
merged_data <- full_join(elections, GEM, by = c("Country", "Year"))

# ------------------------------
# 3. Load and Clean Military Spending Data
# ------------------------------
MS <- read.csv("raw_data/military_spending_dataset.csv")

MS_long <- MS %>%
  pivot_longer(cols = starts_with("X"),
               names_to = "Year",
               values_to = "Military expenditure (% of GDP)",
               values_drop_na = TRUE) %>%
  mutate(Year = as.numeric(substr(Year, 2, 5))) %>%
  select(-Country.Code, -Indicator.Code) %>%
  rename(Country = Country.Name)

# Merge with previous data
merged_data <- full_join(merged_data, MS_long, by = c("Country", "Year"))

# Filter out NA in Currency column and remove remaining NAs
merged_data <- merged_data %>%
  filter(!is.na(Currency)) %>%
  na.omit()

# Drop irrelevant columns
drops1 <- c("hog_ideology_num_full","hog_ideology_num_redux","leader_party_abbr","hog_title",
            "hog_party_id", "hog_party_abbr", "Indicator.Name","leader", "hog_party","hog",
            "hog_right", "country_code_cow","hog_ideomiss","hog_party_eng","hog_left",
            "hog_center","hog_noideo","hog_noinfo","leader_party","leader_party_eng",
            "leader_party_id","leader_position","leader_ideomiss","match_hog_hog_bls",
            "leader_ideology_num_full", "leader_ideology_num_redux","leader_right","leader_left",
            "leader_center","leader_noideo","leader_noinfo","match_hog_leader_m",
            "match_leader_leader_m","match_hog_leader_chi","match_leader_leader_chi",
            "hog_ideology_bls", "match_leader_hog_bls","leader_ideology_m","execrlc_dpi",
            "hog_party_lr_ord_vdem")

merged_data <- merged_data[ , !(names(merged_data) %in% drops1)]
merged_data <- subset(merged_data, Year >= 2000 & Year <= 2020)

# ------------------------------
# 4. Load and Clean Population Data
# ------------------------------
population <- read.csv("raw_data/World Population and Unemployment Dataset (1960-2023).csv")

population <- population %>%
  rename(Country = country, Year = date) %>%
  select(Country, Year, Urban.population, Rural.population) %>%
  na.omit() %>%
  subset(Year >= 1990 & Year <= 2020) %>%
  mutate(Country = str_trim(Country, side = "both"))

# Rename country names
population$Country[population$Country == "Egypt Arab Rep."] <- "Egypt"
population$Country[population$Country == "Korea Rep."] <- "South Korea"
population$Country[population$Country == "Macedonia FYR"] <- "North Macedonia"
population$Country[population$Country == "Slovak Republic"] <- "Slovakia"
population$Country[population$Country == "Russian Federation"] <- "Russia"
population$Country[population$Country == "Taiwan China"] <- "Taiwan"
population$Country[population$Country == "United States"] <- "United States of America"

# Merge with existing dataset
merged_data <- full_join(merged_data, population, by = c("Country", "Year"))

# ------------------------------
# 5. Rename Long Variable Names
# ------------------------------
rename_columns <- c(
  "X.Agriculture..hunting..forestry..fishing..ISIC.A.B.." = "agriculture_and_hunting_fishing_isic",
  "Construction..ISIC.F." = "construction_isic",
  "X.Mining..Manufacturing..Utilities..ISIC.C.E.." = "mining_manifacturing_isic",
  "X.Wholesale..retail.trade..restaurants.and.hotels..ISIC.G.H.." = "wholesale_trade_restaurant_hotel_isic",
  "X.Transport..storage.and.communication..ISIC.I.." = "transport_storage_communication_isic"
)
colnames(merged_data) <- recode(colnames(merged_data), !!!rename_columns)

# ------------------------------
# 6. Drop Additional Unwanted Columns
# ------------------------------
drops2 <- c("Total.Value.Added","Other.Activities..ISIC.J.P.","Manufacturing..ISIC.D.",
            "Household.consumption.expenditure..including.Non.profit.institutions.serving.households.",
            "Gross.fixed.capital.formation..including.Acquisitions.less.disposals.of.valuables.",
            "General.government.final.consumption.expenditure", "AMA.exchange.rate",
            "X", "Final.consumption.expenditure")

merged_data <- merged_data[ , !(names(merged_data) %in% drops2)]

# ------------------------------
# 7. Export Cleaned Dataset
# ------------------------------
write.csv(merged_data, "new_data_with_count.csv", row.names = FALSE)

# ------------------------------
# 8. Reload and Finalize Dataset
# ------------------------------
final_data <- read.csv("new_data_with_count.csv") %>%
  na.omit()

# Final Checks
print(ncol(final_data))
print(nrow(final_data))
print(colnames(final_data))
print(as.factor(final_data$Country))
