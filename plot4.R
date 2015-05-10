library(dplyr)
datafile<-"household_power_consumption.txt"
if (!file.exists(datafile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
        unzip("household_power_consumption.zip")
        
}  else {
        power<-read.table("household_power_consumption.txt",header = TRUE, sep = ";",nrows = 100000)
        
}
power<-read.table("household_power_consumption.txt",header = TRUE, sep = ";",nrows = 100000)
power1<-tbl_df(power)
power1$datetime<-paste(power1$Date,power1$Time)
power1$datetime<- as.POSIXct(power1$datetime, format = "%d/%m/%Y %H:%M:%S")
power_sub<-filter(power1,datetime >="2007-02-01 00:00:00",datetime <"2007-02-03 00:00:00")

power_sub$Global_active_power<-as.numeric(as.character(power_sub$Global_active_power))
power_sub$Global_reactive_power<-as.numeric(as.character(power_sub$Global_reactive_power))
power_sub$Voltage<-as.numeric(as.character(power_sub$Voltage))
power_sub$Global_intensity<-as.numeric(as.character(power_sub$Global_intensity))
power_sub$Sub_metering_1<-as.numeric(as.character(power_sub$Sub_metering_1))
power_sub$Sub_metering_2<-as.numeric(as.character(power_sub$Sub_metering_2))
power_sub$Sub_metering_3<-as.numeric(as.character(power_sub$Sub_metering_3))

png("plot4.png")
par(mfrow=c(2,2))
plot(power_sub$datetime,power_sub$Global_active_power,type = "l",xlab = "", ylab = "Global active power(kilowatts)")
plot(power_sub$datetime,power_sub$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(power_sub$datetime,power_sub$Sub_metering_1,type = "l",xlab="",ylab="Energy sub metering",col = "black")
lines(power_sub$datetime,power_sub$Sub_metering_2,type = "l",xlab="",ylab="Energy sub metering",col = "red")
lines(power_sub$datetime,power_sub$Sub_metering_3,type = "l",xlab="",ylab="Energy sub metering",col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = c(1,1))
plot(power_sub$datetime,power_sub$Global_reactive_power, type = "l",ylab = "Gloabl_reactive_power", xlab = "datetime")

dev.off()
