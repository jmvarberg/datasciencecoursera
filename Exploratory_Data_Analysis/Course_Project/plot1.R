#plot 1

#'Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#'Using the base plotting system, make a plot showing the total PM2.5 emission 
#'from all sources for each of the years 1999, 2002, 2005, and 2008.

#read in packages
library(data.table)
library(tidyverse)

#read in data files provided by Coursera as rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#select/filter data and summarise
q1df <- NEI %>% 
    group_by(year) %>% 
    summarise(across(Emissions, sum, na.rm=TRUE))

png("./plot1.png")
with(q1df, plot(Emissions ~ year, pch=16, cex=2, xlab = "Year", ylab= "Total PM2.5 emissions (tons)", main="Nationwide PM2.5 Emissions, 1999-2008"))    
dev.off()
