library(lubridate)
#download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "temp.zip")
unzip(zipfile = "temp.zip")

#load data and clean up
power <- read.table("household_power_consumption.txt", header = TRUE, nrows = 69516,
                    sep = ";", colClasses = c(rep("character",2), rep("numeric", 7)),
                    na.strings = "?")
power$datetime <- strptime(paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S")
#optimize memory footprint by removing unused data
power <- subset(power, power$datetime >= strptime("2007-02-01", format = "%Y-%m-%d"))

#generate plot
png(file = "plot4.png", bg="transparent", width = 480, height = 480)

#set up canvas
par(mfrow = c(2,2))

with(power, plot(datetime, Global_active_power, type="n", xlab = "",
                 ylab = "Global active power"))
with(power, lines(datetime, Global_active_power))

with(power, plot(datetime, Voltage, type="n", xlab = "datetime",
                 ylab = "Voltage"))
with(power, lines(datetime, Voltage))

with(power, plot(datetime, Sub_metering_1, type="n", xlab = "",
                 ylab = "Energy sub metering"))
with(power, lines(datetime, Sub_metering_1, col="black"))
with(power, lines(datetime, Sub_metering_2, col="red"))
with(power, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")

with(power, plot(datetime, Global_reactive_power, type="n", xlab = "datetime",
                 ylab = "Global_reactive_power"))
with(power, lines(datetime, Global_reactive_power))

dev.off()