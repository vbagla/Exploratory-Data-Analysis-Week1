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

Plot1 <- function(data) {
	# create histogram for Global Active Power

	png("plot1.png", width=480, height=480)
	hist(data$Global_active_power, main = "Global Active Power", 
		xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
		col = "red")
	dev.off()
}

data <- NULL
data <- getfile(data)
Plot1(data)
