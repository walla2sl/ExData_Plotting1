plot3 <- function(){
  #Download, unzip and read data into a DataTable
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(fileUrl,temp, method="curl")
  dt <- read.table(unz(temp,"household_power_consumption.txt"), header=TRUE, sep=";")
  unlink(temp)
  
  #Filter out only data for 2007-02-01 to 2007-02-02
  dt$Date2 <- as.Date(dt$Date,"%d/%m/%Y")
  dt <- subset(dt, Date2 <= as.Date("2007-02-02") & Date2 >= as.Date("2007-02-01"))
  
  dt$Sub_metering_1 <- as.double(as.character(dt$Sub_metering_1))
  dt$Sub_metering_2 <- as.double(as.character(dt$Sub_metering_2))
  dt$Sub_metering_3 <- as.double(as.character(dt$Sub_metering_3))
  dt$DateTime <- as.POSIXct(paste(dt$Date2,dt$Time))
  dt$Day <- as.POSIXlt(dt$Date2)$wday
  
  png(filename = "plot3.png", width = 480, height = 480, units = "px")
  plot(dt$DateTime, dt$Sub_metering_1, col="black", 
       ylab="Energy sub metering", type="l", xlab=""
  )
  legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
  
  lines(dt$DateTime, dt$Sub_metering_2, col="red")
  lines(dt$DateTime, dt$Sub_metering_3, col="blue")
  axis(2,labels=c("0","10","20","30"),at=c(0,10,20,30))
  
  
  axis(1,
       labels=c("Thu","Fri","Sat"),
       at=c(as.POSIXct("2007-02-01 00:00:00"),as.POSIXct("2007-02-02 00:00:00"),as.POSIXct("2007-02-02 23:59:59")),
       dt$DateTime)
  dev.off()   
}