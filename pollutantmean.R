#Week 2 Programming Assignment 1: Air Pollution

#Objective: Write a function named "pollutantmean" that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors.

pollutantmean <- function(directory, pollutant, id=1:332) {
  files <- list.files(directory, full.names = TRUE)
  #read in files in IDs and combine into one df
  df <- data.frame()
  for (monitor in id) {
    data <- read.csv(files[monitor])
    df <- rbind(df, data)
  }
  dfpol <- df[ , pollutant] #subset on the pollutant column
  mean(dfpol, na.rm = TRUE) #calculate mean with NAs removed
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
