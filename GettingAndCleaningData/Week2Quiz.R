#Week 2 Quiz

#Q1: github API

library(jsonlite)
library(httpuv)
library(httr)
library(tidyverse)

oauth_endpoints("github")

#create an OAuth application
myapp <- oauth_app(appname = "testgithubAPI",
                   key = "b49bf34dc44b6fd6662f",
                   secret = "e97ceea6f3e8e258b0d0b2090314239ee052100c")

#get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#Use API

gtoken <- config(token=github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)

#extract content from request
js1 <- content(req)

#convert to JSON object, then convert from JSON to a dataframe
ghdf <- fromJSON(toJSON(js1))

#subset dataframe to get desired output
ghdf[ghdf$full_name == "jtleek/datasharing", "created_at"] 


#Q4
library(xml2)

#download html file using base readLines function. Each line read in to a character vector

q4data <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
nchar(q4data[c(10, 20, 30, 100)])

#Q5 reading in fixed-width fortran .for document and parsing

daturl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for" 
q5data <- read_fwf(file = daturl, skip=4,
                   fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))

