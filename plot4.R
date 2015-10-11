###############################################################################
###     This function creates plot4.png.
###     The working directory must contains the data file 
###     "household_power_consumption.txt".
###############################################################################
drawPlot4 <- function() {
        ###     Step 1 - fast read data into a data.table
        library(data.table)
        data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

        ###     Step 2 - subsetting data to use only the 2 days 2007-02-01 and 2007-02-02.
        subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

        ###     step 3 - convert Date Time columns to POSIXct
        z <- as.POSIXct(strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S"))
        subdata[, DateTime:=data.table(z)$z]

        ###     step 4 - draw plot4 and save it to plot4.png
        png("plot4.png", 480, 480)
        par(mfcol=c(2,2),cex=0.80)
        plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        plot(subdata$DateTime, subdata$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
        lines(subdata$DateTime,subdata$Sub_metering_2,col="red")
        lines(subdata$DateTime,subdata$Sub_metering_3,col="blue")
        legend("topright",pch=c(-1,-1,-1),lty=c(1,1,1),col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.90,bty="n")
        plot(subdata$DateTime, subdata$Voltage, type="l",xlab="datetime",ylab="Voltage")
        plot(subdata$DateTime, subdata$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
        dev.off()
}