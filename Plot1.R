
##Load Data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 'energy_data.zip')
unzip('energy_data.zip')
data<-read.csv('household_power_consumption.txt', sep=";")
head(data)

##Format Datatypes
data$Date<-as.Date(data$Date,"%d/%m/%Y")
data[,-1:-2]<-lapply(data[,-1:-2], as.numeric)

##subset by timeframe
data<-subset(data, Date>=as.Date("01/02/2007", "%d/%m/%Y") & Date<=as.Date("02/02/2007", "%d/%m/%Y"))


##Plot1
hist(data$Global_active_power,
     xlim=c(0,6),
     ylim=c(0,1200), 
     col='red',
     main="Global Active Power", 
     xlab='Global Active Power (kilowatts)'
)

dev.copy(png, "figures/Plot1.png")
dev.off()
