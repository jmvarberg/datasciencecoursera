#plot 3

#read in cleaned up dataset

df <- read.csv("./Week1_cleaned_dataset.csv")

#add weekday column

df$day_time <- strptime(paste(df$Date, df$Time, sep =" "), format = "%Y-%m-%d %H:%M:%S")
plot(x=df$day_time, y=df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

#make plot

png("./plot3.png", width=480, height=480, units="px")
plot(x=df$day_time, y=df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(x = df$day_time, y=df$Sub_metering_2, type="l", col="red")
lines(x = df$day_time, y=df$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()
