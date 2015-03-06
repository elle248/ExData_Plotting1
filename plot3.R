##Plot1.R
##Running the code below will read the Electric Power Consumption data from an online location.
##Using this data, a plot will be created showing Frequency by Global Active Power (kW)

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

##Plot the line graph
with(subdata,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8))
with(subdata,points(DateTime,Sub_metering_2,type="l",col="Red"))
with(subdata,points(DateTime,Sub_metering_3,type="l",col="Blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7)

##Write the plot to a png file
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()