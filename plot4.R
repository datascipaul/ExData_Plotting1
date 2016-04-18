#reads in data and keeps it (file must be in working directory)
original_data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",colClasses="character",na.strings="?")

#passes to data to be manipulated
correct_date<-original_data

#concatenate dates from original file
correct_date$concatdate<-paste(original_data$Date,"/",original_data$Time)

#create correct date format
correct_date$realdate<-strptime(correct_date$concatdate,"%d/%m/%Y / %H:%M:%S")

#subsets data to appropriate timeframe
working_data<-correct_date[correct_date$realdate>="2007-02-01 00:00:00" & correct_date$realdate<="2007-02-02 23:59:59",]

#opens PNG device and creates file
png("plot4.png")

#create plots
par(mfrow=c(2,2)) #set plot paramaters at 2 by 2 plots
with(working_data, {
  plot(realdate,Global_active_power,type="l",xlab=NA,ylab="Global Active Power")
  plot(realdate,Voltage,type="l",xlab="datetime",ylab="Voltage")
  plot(realdate,Sub_metering_1,type="n",xlab=NA,ylab="Energy sub metering")
    lines(realdate,Sub_metering_1,type="l",col="black")
    lines(realdate,Sub_metering_2,type="l",col="red")
    lines(realdate,Sub_metering_3,type="l",col="blue")
    legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(realdate,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})

#close PNG device
dev.off()