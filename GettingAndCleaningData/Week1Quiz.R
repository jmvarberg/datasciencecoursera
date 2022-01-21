#Week 1 Quiz
library(data.table)
library(xlsx)
library(XML)


#Q1
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./question1.csv", method="curl")
data1 <- fread("./question1.csv")

nrow(data1[VAL == 24, ])

#Q3
data3 <- read.xlsx("./getdata-data-DATA.gov_NGAP.xlsx", sheetIndex=1, rowIndex = 18:23, colIndex = 7:15)
sum(data3$Zip*data3$Ext,na.rm=T)

#Q4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile = "./question4.xml", method="curl")
data4 <- xmlTreeParse("./question4.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(data4)
names(rootNode)
zipCodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipCodes == 21231)

#Q5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile="./question5.csv", method="curl")
DT <- fread("./question5.csv")
DT[,mean(pwgtp15),by=SEX]

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#mean(DT$pwgtp15,by=DT$SEX)
#system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(data5[,mean(pwgtp15),by=SEX])
system.time(mean(data5$pwgtp15,by=DT$SEX))
sapply(split(DT$pwgtp15,DT$SEX),mean)
