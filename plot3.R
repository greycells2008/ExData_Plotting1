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

png(filename = "plot3.png",width = 480,height = 480)



#Plot line graph for sub_meter_1, sub_meter_2, sub_meter_3
with(selected_data,plot(Date,Sub_metering_1,type = "l",
                        xlab = "",ylab = "Energy sub metering"))

lines(selected_data$Date,selected_data$Sub_metering_2, col="red")
lines(selected_data$Date,selected_data$Sub_metering_3, col="blue")

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col = c("black","red","blue"),lty=c(1,1),lwd=c(1,1))


#Turn off png device

dev.off()