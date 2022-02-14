#question 2 plot script
#'Q2:Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#' from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#read in packages
library(data.table)
library(tidyverse)

#read in data files provided by Coursera as rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#select/filter data and summarise
q2df <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise(across(Emissions, sum, na.rm=TRUE))

#make and save plot png
png("./plot2.png")
with(q2df, plot(Emissions ~ year, pch=16, cex=2, xlab = "Year", ylab= "Total PM2.5 emissions (tons)", main="Emissions for Baltimore City, Maryland, 1999-2008")) 
dev.off()
