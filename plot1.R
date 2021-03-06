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
subdata$Date <- as.Date(subdata$Date,"%d/%m/%Y")
subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))

##Plot the histogram
hist(subdata$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="Red",cex.axis=0.75,cex.main=0.9,cex.lab=0.8)

##Write the plot to a png file
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()