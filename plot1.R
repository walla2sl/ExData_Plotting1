plot1 <- function(){
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
  
  png(filename = "plot1.png",
      width = 480, height = 480, units = "px")
  hist(dt$Global_active_power, col="red", main="Global Active Power", 
       xlab="Global Active Power (kilowatts)"
       )
  axis(2,labels=c("0","200","400","600","800","1000","1200"),at=c(0,200,400,600,800,1000,1200))
  dev.off()
}