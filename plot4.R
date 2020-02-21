  library("data.table")
  
  
  
  power <- data.table::fread(input = "household_power_consumption.txt"
                               , na.strings="?"
  )
  
  
  power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
  
  power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
  
  power<- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
  
  png("plot4.png", width=480, height=480)
  
  par(mfrow=c(2,2))
  
  
  plot(power[, dateTime], power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
  
  
  plot(power[, dateTime],power[, Voltage], type="l", xlab="datetime", ylab="Voltage")
  
  
  plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering",col="purple")
  lines(power[, dateTime], power[, Sub_metering_2], col="yellow")
  lines(power[, dateTime], power[, Sub_metering_3],col="red")
  legend("topright", col=c("purple","yellow","red")
         , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
         , lty=c(1,1)
         , bty="n"
         , cex=.5) 
  
  
  plot(power[, dateTime], power[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.off()