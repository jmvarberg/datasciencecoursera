#plot 3

#'Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#'which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#'Which have seen increases in emissions from 1999–2008? 
#'Use the ggplot2 plotting system to make a plot answer this question.

#read in packages
library(data.table)
library(tidyverse)
library(cowplot)

#read in data files provided by Coursera as rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#aggregate and summarise data
q3df <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year, type) %>% 
    summarise_at(vars(Emissions), sum, na.rm=TRUE)

#make plot

ggplot(q3df, aes(x=year, y=Emissions)) +
    geom_point() +
    geom_path() +
    facet_wrap(vars(type), scales="free_y") +
    labs(title="Emissions by type, Baltimore City, MD, 1999-2008", y="PM2.5 Emissions (tons)", x="Year") +
    theme_cowplot(font_size=10)
ggsave2("./plot3.png")
