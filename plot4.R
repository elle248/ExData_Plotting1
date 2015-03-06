##Plot4.R
##Running the code below will read the Electric Power Consumption data from an online location.
##Using this data, a plot will be created

##Read in the data
temp <- tempfile()
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,temp)
data <- read.table(unzip(temp),sep=";",header=TRUE)
unlink(temp)

##Subset the data to show data only from the dates of interest
subdata <- subset(data,data$Date %in% c("1/2/2007","2/2/2007"))

##Convert columns to required formats
subdata$DateTime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage))
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))

##Define the grid in which the plots will be assigned
par(mfrow=c(2,2))
par(mar=c(4,4,3,2))

##Plot the top left graph
with(subdata,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power",cex.lab=0.6,cex.axis=0.6))

##Plot the top right graph
with(subdata,plot(DateTime,Voltage,type="l",ylab="Voltage",xlab="datetime",cex.lab=0.6,cex.axis=0.6))

##Plot the bottom left graph
with(subdata,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",cex.lab=0.6,cex.axis=0.6))
with(subdata,points(DateTime,Sub_metering_2,type="l",col="Red"))
with(subdata,points(DateTime,Sub_metering_3,type="l",col="Blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5,bty='n')

##Plot the bottom right graph
with(subdata,plot(DateTime,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",cex.lab=0.6,cex.axis=0.6))

##Write the plot to a png file
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()