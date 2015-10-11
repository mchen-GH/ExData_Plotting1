###############################################################################
###     This function creates plot3.png.
###     The working directory must contains the data file 
###     "household_power_consumption.txt".
###############################################################################
drawPlot3 <- function() {
        ###     Step 1 - fast read data into a data.table
        library(data.table)
        data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

        ###     Step 2 - subsetting data to use only the 2 days 2007-02-01 and 2007-02-02.
        subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

        ###     step 3 - convert Date Time columns to POSIXct
        z <- as.POSIXct(strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S"))
        subdata[, DateTime:=data.table(z)$z]

        ###     step 4 - draw plot3 and save it to plot3.png
        png("plot3.png", 480, 480)
        plot(subdata$DateTime, subdata$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")
        lines(subdata$DateTime,subdata$Sub_metering_2,col="red")
        lines(subdata$DateTime,subdata$Sub_metering_3,col="blue")
        legend("topright",pch=c(-1,-1,-1),lty=c(1,1,1),col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
}