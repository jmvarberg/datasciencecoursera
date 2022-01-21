#Week 4 Quiz

#Q1

q1url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q1df <- fread(q1url)
splitNames <- strsplit(names(q1df), split="\\wgtp")
splitNames[[123]]

#Q2
q2url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
q2df <- fread(q2url, select=c(1,2,4,5), skip=5)
colnames(q2df) <- c("CountryCode", "Ranking", "Name", "GDP")

q2df %>% 
  mutate(Ranking = as.numeric(Ranking),
         GDP = as.numeric(str_remove_all(GDP, ","))) %>% 
  filter(Ranking > 0) %>% 
  summarise_at(vars(GDP), mean)

#Q3
countryNames <- q2df$Name
countryNames[grep("*United",countryNames)]

#Q4

q4edurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
q4ed <- fread(q4edurl)

combdf <- left_join(q2df, q4ed)

combdf %>% 
  mutate(FiscalKnown = case_when(str_detect(tolower(`Special Notes`), pattern = "fiscal year end") ~ "Known",
                                 TRUE ~ "Unknown")) %>% 
  filter(FiscalKnown == "Known" & str_detect(tolower(`Special Notes`), pattern = "june")) %>% 
  add_tally()


#Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)

wds <- format(sampleTimes, "%A" )
mons <- format(sampleTimes, "%b")
yrs <- format(sampleTimes, "%Y")

q5df <- data.frame(Day = wds, Month = mons, Year = yrs)

q5df %>% 
  filter(Year == "2012" & Day == "Monday")

