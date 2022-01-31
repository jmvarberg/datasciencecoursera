#plot 2

#read in cleaned up dataset

df <- read.csv("./Week1_cleaned_dataset.csv")

#add weekday column

df$day_time <- strptime(paste(df$Date, df$Time, sep =" "), format = "%Y-%m-%d %H:%M:%S")


#make plot

png("./plot2.png", width=480, height=480, units="px")
plot(x=df$day_time, y=df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
