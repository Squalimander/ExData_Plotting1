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



##Plot2
plot(data$Datetime, data$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)')
dev.copy(png, 'figures/Plot2.png')
dev.off()
