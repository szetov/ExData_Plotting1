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
png(file = "plot1.png", bg="transparent", width = 480, height = 480)
with(power, hist(Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
                 main = "Global Active Power"))
dev.off()