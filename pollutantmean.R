#Week 2 Programming Assignment 1: Air Pollution

#Objective: write a function named "pollutantmean" that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors.

pollutantmean <- function(directory, pollutant, id=1:332) {
  files <- list.files(directory, full.names = TRUE)
  #read in CSV file for ids in id and calculate the mean of column named pollutant
  #initialize a vector for holding individual means
  means <- vector(mode="numeric", length = length(id))
  p <- 1
  for (monitor in id) {
    df <- read.csv(files[monitor])
    colpol <- which(colnames(df) == pollutant) #find index value for column matching pollutant variable name
    means[p] <- mean(df[,colpol], na.rm=TRUE) #assign mean value for that id to means vector
    p <- p+1
    print(means)
  }
  mean(means, na.rm = TRUE) #calculate overall mean value from means of id's
}

pollutantmean("./specdata/", "sulfate", id=22:23)


(2.980696 + 0.8310505)/2
