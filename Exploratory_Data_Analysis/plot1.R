#plot 1

#read in cleaned up dataset

df <- read.csv("./Week1_cleaned_dataset.csv")

#make histogram with formating to match Coursera


png("./plot1.png", width = 480, height=480, units = "px")
with(df, hist(Global_active_power, col="red", main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)"))
dev.off()
