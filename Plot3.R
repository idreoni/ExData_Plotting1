#For each plot you should

#Construct the plot and save it to a PNG file with a width of 480
#pixels and a height of 480 pixels.
#Name each of the plot files as `plot1.png`, `plot2.png`, etc.

#Create a separate R code file (`plot1.R`, `plot2.R`, etc.) that
#constructs the corresponding plot, i.e. code in `plot1.R` constructs
#the `plot1.png` plot. Your code file **should include code for reading
#the data** so that the plot can be fully reproduced. You should also
#include the code that creates the PNG file.

dat <- read.table("exdata_data_household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
dat <- subset(dat,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

dat <- dat[complete.cases(dat),]

dateTime <- paste(dat$Date, dat$Time)
names(dateTime) <- c("DateTime")
dat <- dat[ ,!(names(dat) %in% c("Date","Time"))]
dat <- cbind(dateTime, dat)
dat$dateTime <- as.POSIXct(dateTime)

par(yaxp  = c(0, 1200, 6))

png("plot3.png",width = 480,height=480)
plot(dat$dateTime,dat$Sub_metering_1, type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(dat$dateTime,dat$Sub_metering_2, col = 'Red')
lines(dat$dateTime,dat$Sub_metering_3, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
