library("data.table")


power <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

power<- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering",col="blue")
lines(power[, dateTime], power[, Sub_metering_2],col="magenta")
lines(power[, dateTime], power[, Sub_metering_3],col="black")
legend("topright"
       , col=c("blue","magenta","black")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()