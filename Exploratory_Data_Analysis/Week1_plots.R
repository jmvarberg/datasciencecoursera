#Project for Week 1

library(data.table)
library(tidyverse)
library(lubridate)
#read in data

df <- fread("./household_power_consumption.txt")

#filter to only keep the two dates of interest: 2007-02-01 and 2007-02-02

df_clean <- df %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
  filter(Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

#write out subset of data to use for plotting scripts

write.csv(df_clean, "./Week1_cleaned_dataset.csv")

