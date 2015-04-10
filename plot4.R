plot4 <- function() {
  
  # download data if it is not present in the working directory
  if(!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,"data.zip",mode="wb")
    unzip("data.zip")
  }
  
  # get data from corresponding dataset
  data <- read.table("household_power_consumption.txt", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), sep=";", header=TRUE, na.strings="?")
  
  # add timestamp column and convert dates and times
  data$timestamp <- paste(data$Date,data$Time)
  data$timestamp <- strptime(data$timestamp,format="%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$timestamp)
  
  # subset only data from given days (2007-02-01 and 2007-02-02)
  set <- data[data$Date>="2007-02-01" & data$Date<="2007-02-02",]
  
  # set locale to get day labels in English
  Sys.setlocale("LC_ALL","C")
  
  # open png graphics device
  png(file = "plot4.png")
  
  # set number of plots on device to 4 (2x2)  
  par(mfrow=c(2,2))
  
  # plot 1 construction
  plot(set$timestamp, set$Global_active_power, type="l", xlab=NA, ylab="Global Active Power")

  # plot 2 construction
  plot(set$timestamp, set$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # plot 3 construction
  plot(set$timestamp, set$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
  lines(set$timestamp, set$Sub_metering_2, col="red")
  lines(set$timestamp, set$Sub_metering_3, col="blue")
  legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # plot 4 construction
  plot(set$timestamp, set$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  # close graphics device
  dev.off()
  
}
