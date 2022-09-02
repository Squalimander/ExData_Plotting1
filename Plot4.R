##Load Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 'energy_data.zip')
unzip('energy_data.zip')
data<-read.csv('household_power_consumption.txt', sep=";")
head(data)

#Format Date and numeric columns and subset data
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data<-subset(data, Date>=as.Date("01/02/2007", "%d/%m/%Y") & Date<=as.Date("02/02/2007", "%d/%m/%Y"))
data[,-1:-2]<-lapply(data[,-1:-2], as.numeric)

##Create Datetime column
data$Datetime<-paste(data$Date,data$Time)
data$Datetime[1]
as.POSIXct(strptime(data$Datetime[1], "%Y-%m-%d %T"))
data$Datetime<-as.POSIXct(strptime(data$Datetime, "%Y-%m-%d %T"))


str(data)


par(mfrow=c(2,2))

##Plot4.1
plot(data$Datetime, data$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)')

##Plot4.2
plot(data$Datetime, data$Voltage, type='l', xlab='datetime', ylab='Voltage')

##Plot4.3
plot(data$Datetime, data$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(data$Datetime, data$Sub_metering_2, col='red')
lines(data$Datetime, data$Sub_metering_3, col='blue')
legend('topright', lty=c(1,1,1), col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), bty='n')

##Plot4.4
plot(data$Datetime, data$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')


##Save
dev.copy(png, 'figures/Plot4.png')
dev.off()
