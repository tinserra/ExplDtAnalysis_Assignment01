setwd("C:/Users/Thiago Inserra/Documents/GitHub/ExplDtAnalysis_Assignment01")

# Read all files needed for the project
dataset <- read.table("./household_power_consumption.txt", header=TRUE, 
                      sep=";", na.strings = "?")

datesVar <- dataset$Date
timesVar <- dataset$Time

## Creates "NewDate" column so I can use it to subset the data:
dataset$NewDate <- as.Date(datesVar, "%d/%m/%Y")

## Concatenates date and time and creates a new col formated as "Date and Time":
dataset$NewDateTime <- strptime(paste(datesVar,timesVar), "%d/%m/%Y %H:%M:%S")

## Subset dataset using the "NewDate" column:
newdata <- subset(dataset, NewDateTime >= "2007-02-01" & NewDateTime < "2007-02-03", 
          select = c(NewDateTime, Global_active_power, Global_reactive_power, 
                     Voltage, Global_intensity, Sub_metering_1, Sub_metering_2,
                     Sub_metering_3))

## Get weekdays:
newdata$Wkdays <- weekdays(newdata$NewDateTime)

## Draw 3rd Graph:
png(file = "plot3.png", width = 480, height = 480, units = "px")
par(bg = "transparent")

plot (newdata$NewDateTime, newdata$Sub_metering_1, type = "l", xlab = "", 
      ylab = "Energy sub metering")
lines(newdata$NewDateTime, newdata$Sub_metering_2, col = "red")
lines(newdata$NewDateTime, newdata$Sub_metering_3, col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()