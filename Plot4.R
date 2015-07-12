
####################################
#importing the data and cleanig it
####################################

#sets the working directory
setwd("/Users/alineguilloux/Documents/DataScienceCoursera/4Exploratory")

#saves a link to the file and dowloads it
link<-c("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip") 
download.file(link, "eletricpower.zip", method="curl")

#Unzip and read the file to be used
unzip("eletricpower.zip", exdir="data")
list.files("/Users/alineguilloux/Documents/DataScienceCoursera/4Exploratory/data")
dataimp<-read.table("data/household_power_consumption.txt", header=T, sep=";", na.strings = "?", comment.char="", nrows=2075259)

#subsets the data
str(dataimp)
library(lubridate)
data<-subset(dataimp, Date=="1/2/2007"|Date=="2/2/2007", select= c(1:9))

#Creates a POSIXct column
data<-cbind(dt_hm=0, data)
data$dt_hm <- dmy(data$Date) + hms(data$Time)

#############################
#creating plot number 4
############################

#creating the output file
png("Plot4.png", width=480, height=480, bg="transparent")

#setting 2x2 output
par(mfcol=c(2,2))

#ploting the graph 2 into col1, row1
plt2<-plot(data$dt_hm, data$Global_active_power, type="n", 
           ylab= "Global Active Power (kilowatts)", xlab="")
lines(data$dt_hm, data$Global_active_power)

#plotting graph 3 into col1, row2
plt3<-plot(data$dt_hm, data$Sub_metering_1, type="n", 
           ylab= "Energy sub metering", xlab="")
lines(data$dt_hm, data$Sub_metering_1)
lines(data$dt_hm, data$Sub_metering_2, col="red")
lines(data$dt_hm, data$Sub_metering_3, col="blue")
legend("topright", lwd=1, lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty="n" )
#plotting new graph 4
plt4<-plot(data$dt_hm, data$Voltage, xlab="datetime", ylab="Voltage", type="n")
lines(data$dt_hm, data$Voltage)
#plotting new graph 5
plt5<-plot(data$dt_hm, data$Global_reactive_power, xlab="datetime", 
           ylab="Global_reactive_power", type="n")
lines(data$dt_hm, data$Global_reactive_power)
dev.off()

