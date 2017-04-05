getfile <- function(datafile) {

	# read full data set
	data_all <- read.csv("household_power_consumption.txt", header = TRUE, sep =";", na.strings = "?")

	# subset data
	data <- subset(data_all, Date %in% c("1/2/2007", "2/2/2007"))

	# change format of date and time entries, and create a combined date/time field
	data$Date <- as.Date(data$Date, format="%d/%m/%Y")
	datetime <- paste(as.Date(data$Date), data$Time)
	data$Datetime <- as.POSIXct(datetime)

	data
}

Plot4 <- function(data) {
	# set graph configuration and margins

	png("plot4.png", width = 480, height = 480)
	par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

	with(data, {
  		plot(Global_active_power~Datetime, type = "l", 
       		xlab = "", ylab = "Global Active Power")
  		plot(Voltage~Datetime, type = "l", 
       		xlab = "datetime", ylab = "Voltage")
  		plot(Sub_metering_1~Datetime, type = "l", 
       		xlab = "", ylab = "Energy Sub Metering")
  		lines(Sub_metering_2~Datetime,col = 'red')
  		lines(Sub_metering_3~Datetime,col = 'blue')
  
		legend("topright", col = c("black", "red", "blue"), 
			lty = 1, lwd = 2, bty = "n", 
			legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  		plot(Global_reactive_power~Datetime, type = "l", 
       		xlab = "datetime", ylab = "Global_rective_power")
	})

	dev.off()
}

data <- NULL
data <- getfile(data)
Plot4(data)
