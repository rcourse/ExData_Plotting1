plot1 <- function() {
  
  # download data if it is not present in the working directory
  if(!file.exists("household_power_consumption.txt")) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,"data.zip",mode="wb")
    unzip("data.zip")
  }
  
  # get data from corresponding dataset
  data <- read.table("household_power_consumption.txt", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), sep=";", header=TRUE, na.strings="?")
  
  # convert dates in format d/m/y to date class
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  
  # subset only data from given days (2007-02-01 and 2007-02-02)
  set <- data[data$Date>="2007-02-01" & data$Date<="2007-02-02",]

  # open png graphics device
  png(file = "plot1.png")

  # set number of plots on device to 1 (1x1)
  par(mfrow=c(1,1))
  
  # plot histogram from required data
  hist(set$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
  
  # close graphics device
  dev.off()
  
}
