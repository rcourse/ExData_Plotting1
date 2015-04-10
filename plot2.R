plot2 <- function() {
  
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
  png(file = "plot2.png")
  
  # set number of plots on device to 1 (1x1)
  par(mfrow=c(1,1))
  
  # plot construction
  plot(set$timestamp, set$Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)")

  # close graphics device
  dev.off()
  
}
