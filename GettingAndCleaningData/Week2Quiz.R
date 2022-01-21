#Week 2 Quize

#Q1: github API

library(jsonlite)
library(httpuv)
library(httr)

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
