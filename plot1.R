#Read data from text file into data frame

complete_data <- 
  fread("household_power_consumption.txt", na.strings = "?", 
        stringsAsFactors = FALSE, sep = ";")

#Convert Date column to Date type and Global_active_power to numeric type
#Select rows with date range between 2007-02-01 and 2007-02-02

selected_data<-complete_data %>% 
  mutate(Date = as.Date(Date,"%d/%m/%Y"), 
         Global_active_power=as.numeric(Global_active_power)) %>% 
  filter(Date >= as.Date("2007-02-01") & Date < as.Date("2007-02-03"))

#Open png device to store plot

png(filename = "plot1.png",width = 480,height = 480)

#Plot histograph for column Global_active_power

hist(selected_data$Global_active_power,col = "red",
     xlab = "Global Active Power (kilowatts)",ylab = "Frequency",
     main = "Global Active Power")

#Turn off png device

dev.off()