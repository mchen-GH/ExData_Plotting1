###############################################################################
###     This function creates plot2.png.
###     The working directory must contains the data file 
###     "household_power_consumption.txt".
###############################################################################
drawPlot2 <- function() {
        ###     Step 1 - fast read data into a data.table
        library(data.table)
        data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

        ###     Step 2 - subsetting data to use only the 2 days 2007-02-01 and 2007-02-02.
        subdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

        ###     step 3 - convert Date Time columns to POSIXct
        z <- as.POSIXct(strptime(paste(subdata$Date, subdata$Time), "%d/%m/%Y %H:%M:%S"))
        subdata[, DateTime:=data.table(z)$z]

        ###     step 4 - draw plot2 and save it to plot2.png
        png("plot2.png", 480, 480)
        plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
        dev.off()
}