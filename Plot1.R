
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
#creating plot number 1
############################
#creating the png file
png("Plot1.png", width=480, height=480, bg="transparent")
#ploting the histogram into the file
plt1<-hist(data$Global_active_power, col="red", main= "Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylim = c(0, 1200))
dev.off()

