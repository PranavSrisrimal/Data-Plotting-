    library("data.table")
    
    
    
    
    powe <- data.table::fread(input = "household_power_consumption.txt"
                                 , na.strings="?"
    )
    
    
    powe[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
    
    
    powe[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
    
    
    powe <- powe[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
    
    png("plot1.png", width=480, height=480)
    
    
    hist(powe[, Global_active_power], main="Global Active Power", 
         xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
    
    dev.off()