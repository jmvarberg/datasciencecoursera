#Week 2 Programming Assignment 3: Correlation

#Objective: Write a function that takes a directory of data files and a threshold 
#for complete cases and calculates the correlation between sulfate and nitrate 
#for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. 
#The function should return a vector of correlations for the monitors that meet the threshold requirement. 
#If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.


corr <- function(directory, threshold=0) {
  
  #read in CSV files in directory based on id values
  files <- list.files(directory, full.names = TRUE)
  
  #make holding vector for correlation values
  corrvals <- vector("numeric", length=length(files))
  
  l <- 1 #start loop counter
  for (f in files) {
    data <- read.csv(f) #read in file
    data.clean <- data[complete.cases(data), ] #filter out incomplete rows
    
    if(nrow(data.clean) >= threshold){  #if nrow > threshold value, then compute correlation value and add to holding dataframe
        corr <- cor(data.clean$sulfate, data.clean$nitrate) #calculate correlation value
        corrvals[l] <- corr #add value to vector
    }
      else {
        corrvals[l] <- NA #if below threshold, then add placeholder NA value, will be filtered out later
      }
    
    l <- l + 1 #advance loop counter
  }
  
  #return vector without NA values
  corrvals[!is.na(corrvals)]
  
}

