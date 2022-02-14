#plot 6 

#'Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California 
#'(fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
#'


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

#filter NEI dataframe to only keep SCC codes of interest and filter for Baltimore City and LA

q6df <- inner_join(NEI, sccdf, by="SCC") %>% 
    filter(fips == "24510" | fips == "06037") %>% 
    mutate(City = case_when(fips == "24510" ~ "Baltimore City",
                            fips == "06037" ~ "Los Angeles County",
                            TRUE ~ "other")) %>% 
    group_by(year, City) %>% 
    summarise_at(vars(Emissions), sum, na.rm=TRUE)

#make plot
ggplot(q6df, aes(x=year, y=Emissions)) +
    geom_point() +
    geom_path() +
    facet_wrap(vars(City), scales="free_y") +
    labs(title="Annual emissions from motor vehicles, 1999-2008", y="PM2.5 Emissions (tons)", x="Year") +
    theme_cowplot(font_size=10)
ggsave2("./plot6.png")
