#plot 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#read in packages
library(data.table)
library(tidyverse)
library(cowplot)

#read in data files provided by Coursera as rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#filter SCC dataframe to get the SCC codes for motor vehicles - only use categories related to motor vehicle use, not production (i.e., solvents during manufacturing)
sccdf <- SCC %>% 
    filter(if_any(everything(), ~str_detect(., "Vehicles | Motor Vehicles"))) %>% 
    filter(!str_detect(EI.Sector, "Solvent"))

#filter NEI dataframe to only keep SCC codes of interest and filter for Baltimore City

q5df <- inner_join(NEI, sccdf, by="SCC") %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise_at(vars(Emissions), sum, na.rm=TRUE)

ggplot(q5df, aes(x=year, y=Emissions)) +
    geom_point() +
    geom_path() +
    labs(title="Annual emissions from motor vehicles, Baltimore City, MD, 1999-2008", y="PM2.5 Emissions (tons)", x="Year") +
    theme_cowplot(font_size=10)
ggsave2("./plot5.png")
