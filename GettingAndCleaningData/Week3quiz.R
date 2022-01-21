#Week 3 Quize

#Q1

q1url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
q1data <- fread(q1url)

#create logical vector to ID houses on >10 acres sold more than $10,000 worth of ag products

agricultureLogical <- with(q1data, ACR == 3 & AGS == 6)

which(agricultureLogical)

#Q2
library(jpeg)
q2url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
#create temp file to hold
tf <- tempfile()
#Downloding the file
download.file(q2url,tf,mode="wb")
pic <- readJPEG(tf, native = TRUE)
summary(pic)
quantile(pic, c(0.3, 0.8))

#Q3
q3url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
q3df1 <- fread(q3url, skip = 5, select = c(1,2,4,5), col.names = c("CountryCode", "Ranking", "Country", "GDP"))
q3df1 <- q3df1 %>% 
  mutate(Ranking = as.numeric(Ranking),
         GDP = as.numeric(str_remove_all(GDP, ","))) %>% #have to remove commas to be able to convert to numeric
  dplyr::filter(CountryCode != "") #filter to remove rows that dont have a country code



q3url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
q3df2 <- fread(q3url2)

combdf <- inner_join(q3df1, q3df2, by="CountryCode") %>% filter(!is.na(Ranking)) %>% arrange(GDP)

combdf %>% 
  filter(`Income Group` == "High income: OECD" | `Income Group` == "High income: nonOECD") %>% 
  group_by(`Income Group`) %>% 
  summarise_at(vars(Ranking), mean)
  
q5 <- combdf %>% 
  mutate(quartile = ntile(Ranking, n = 5)) %>% 
  group_by()

q5tab <- table(q5$quartile, q5$`Income Group`)
