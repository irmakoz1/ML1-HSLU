library(tidyr)
library(stringr)

setwd("C:/Users/irmak/Desktop/datascience/lulzern/ML/ML1-HSLU")
GEM<-read.csv("Global_Economic_monitor.csv")
GEM<-na.omit(GEM)
f <- GEM %>% select(-"Series.Code")
f$Series<-as.factor(f$Series)
# Convert wide format to long format
df_long <- f %>%
  pivot_longer(
    cols = starts_with("X"),   # Select columns that start with 'X' followed by a year
    names_to = "year",
    values_to = "Value",
    values_drop_na=TRUE) 

df_long$country_name[df_long$country_name == "Egypt Arab Rep."] <- "Egypt"
df_long$country_name[df_long$country_name == "Korea Rep."] <- "South Korea"
df_long$country_name[df_long$country_name == "Macedonia FYR"] <- "North Macedonia"
df_long$country_name[df_long$country_name == "Slovak Republic"] <- "Slovakia"
df_long$country_name[df_long$country_name == "Russian Federation"] <- "Russia"
df_long$country_name[df_long$country_name == "Taiwan China"] <- "Taiwan"
df_long$country_name[df_long$country_name == "United States"] <- "United States of America"
"


df_long[df_long == ".."] <- NA

df_long[df_long == ""] <- NA
df_long[df_long == NULL] <- NA

df_clean <- df_long %>%
  select(where(~!all(is.na(.))))

df_clean <- df_long %>%
  filter(!is.na(Value))
df_long<-df_clean %>%
pivot_wider(names_from =Series, values_from = Value)
colnames(df_long)[colnames(df_long) == 'Country'] <- 'country_name'
df_long$year <- substr(df_long$year, 2, 5)
df_long$year<-as.integer(df_long$year)
election<-read.csv("global_leader_ideologies.csv")
new_data<-
  election %>%
  full_join(df_long, by = c("country_name","year"))  
new_data<-subset(new_data, year >= 2000 & year<=2020)
new_data <- new_data %>%
  filter(!is.na(`CPI Price, % y-o-y, not seas. adj.,,`))
new_data <- new_data %>%
  filter(!is.na(`Stock Markets, US$,,,`))
write.csv(new_data,"new_data2.csv")
