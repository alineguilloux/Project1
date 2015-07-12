
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
#creating plot number 2
############################
#creating the png file
png("Plot2.png", width=480, height=480, bg="transparent")
#ploting the line graph into the file
plt2<-plot(data$dt_hm, data$Global_active_power, type="n", 
           ylab= "Global Active Power (kilowatts)", xlab="")
lines(data$dt_hm, data$Global_active_power)
dev.off()

