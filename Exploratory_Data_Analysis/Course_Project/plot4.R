#plot 4:

#'Across the United States, how have emissions from coal 
#'combustion-related sources changed from 1999–2008?

#read in packages
library(data.table)
library(tidyverse)
library(cowplot)

#read in data files provided by Coursera as rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


#filter SCC dataframe to get the SCC codes for coal combustion sources
sccdf <- SCC %>% 
    filter(str_detect(SCC.Level.One, "combustion | Combustion")) %>% 
    filter(str_detect(SCC.Level.Three, "coal | Coal"))
    
#filter NEI dataframe to only keep SCC codes of interest

q4df <- inner_join(NEI, sccdf, by="SCC") %>% 
    group_by(year) %>% 
    summarise_at(vars(Emissions), sum, na.rm=TRUE)

#make plot

ggplot(q4df, aes(x=year, y=Emissions)) +
    geom_point() +
    geom_path() +
    labs(title="Annual emissions from coal combustion sources, 1999-2008", y="PM2.5 Emissions (tons)", x="Year") +
    theme_cowplot(font_size=10)
ggsave2("./plot4.png")

