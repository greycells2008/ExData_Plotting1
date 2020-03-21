#Read data from text file into data frame

complete_data <- 
  fread("household_power_consumption.txt", na.strings = "?", 
        stringsAsFactors = FALSE, sep = ";")

#Convert Date column to POSIXct type and Global_active_power to numeric type
#Select rows with date range between 2007-02-01 and 2007-02-02

selected_data<-complete_data %>% 
  mutate(Date = as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"), 
         Global_active_power=as.numeric(Global_active_power)) %>% 
  filter(Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))

#Open png device to store plot

png(filename = "plot4.png",width = 480,height = 480)


par(mfrow=c(2,2),mar=c(4,4,2,1))

#Plot line graph for Date and global_active_power
with(selected_data,plot(Date,Global_active_power,type = "l",
                        xlab = "",ylab = "Global active power"))

#Plot line graph for Date and Voltage
with(selected_data,plot(Date,Voltage,type = "l",
                        xlab = "datetime",ylab = "Voltage"))

#Plot line graph for sub_meter_1, sub_meter_2, sub_meter_3
with(selected_data,plot(Date,Sub_metering_1,type = "l",
                        xlab = "",ylab = "Energy sub metering"))

lines(selected_data$Date,selected_data$Sub_metering_2, col="red")
lines(selected_data$Date,selected_data$Sub_metering_3, col="blue")

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col = c("black","red","blue"),lty=c(1,1),lwd=c(1,1), bty="n"
       , cex=.5)

#Plot line graph for Date and global_reactive_power
with(selected_data,plot(Date,Global_reactive_power,type = "l",
                        xlab = "datetime",ylab = "Global_reactive_power"))

#Turn off png device

dev.off()