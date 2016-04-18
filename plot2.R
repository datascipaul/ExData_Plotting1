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
png("plot2.png")

#creates plot
plot(working_data$realdate,working_data$Global_active_power,type="l",xlab=NA,ylab="Global Active Power (kilowatts)")

#close PNG device
dev.off()