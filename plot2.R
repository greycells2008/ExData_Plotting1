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

png(filename = "plot2.png",width = 480,height = 480)

#Plot line graph for column Global_active_power and Date

with(selected_data,plot(Date,Global_active_power,type = "l",
                        xlab = "",ylab = "Global Active Power (kilowatts)"))

#Turn off png device

dev.off()