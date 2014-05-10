plot2 <- function(){
  #Download, unzip and read data into a DataTable
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(fileUrl,temp, method="curl")
  dt <- read.table(unz(temp,"household_power_consumption.txt"), header=TRUE, sep=";")
  unlink(temp)
  
  #Filter out only data for 2007-02-01 to 2007-02-02
  dt$Date2 <- as.Date(dt$Date,"%d/%m/%Y")
  dt <- subset(dt, Date2 <= as.Date("2007-02-02") & Date2 >= as.Date("2007-02-01"))
  
  dt$Global_active_power <- as.double(as.character(dt$Global_active_power))
  dt$DateTime <- as.POSIXct(paste(dt$Date2,dt$Time))
  dt$Day <- as.POSIXlt(dt$Date2)$wday
  
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  plot(dt$DateTime, dt$Global_active_power, col="black", 
       ylab="Global Active Power (kilowatts)", type="l", xlab=""
  )
  axis(2,labels=c("0","2","4","6"),at=c(0,2,4,6))
  axis(1,
       labels=c("Thu","Fri","Sat"),
       at=c(as.POSIXct("2007-02-01 00:00:00"),as.POSIXct("2007-02-02 00:00:00"),as.POSIXct("2007-02-02 23:59:59")),
       dt$DateTime)
  dev.off()
}