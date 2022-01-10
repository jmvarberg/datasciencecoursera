#Week 2 Programming Assignment 2: Complete

#Objective: Write a function that reads a directory full of files and reports the number of completely observed cases in each data file. 
#The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases. 

complete <- function(directory, id=1:332) {
  
  #read in CSV files in directory based on id values
  files <- list.files(directory, full.names = TRUE)
  #read in files in IDs and combine into one df
  df <- data.frame()
  for (monitor in id) {
    data <- read.csv(files[monitor])
    df <- rbind(df, data)
  }
  
  #filter out rows that have NAs for either pollutant
  df.clean <- df[!is.na(df$sulfate & df$nitrate), ]
  
  #loop through IDs, subsetting by ID and counting number of rows in filtered dataframe
  
  #first initialize empty vectors to hold values from loops
  ids <- vector(mode = "numeric", length=length(id))
  obs <- vector(mode = "numeric", length=length(id))
  
  l <- 1
  for (i in id) {
    ids[l] <- i
    obs[l] <- nrow(df.clean[df.clean$ID == i, ])
    l <- l + 1 #advance counter for place holder for holding vectors
  }
  
  #make dataframe with IDs and nobs
  data.frame(id = ids, nobs = obs)
  
}

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

cr <- corr("specdata")                
cr <- sort(cr)   
RNGversion("3.5.1")
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)    
RNGversion("3.5.1")
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out)

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))