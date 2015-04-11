#plot1. Building histogram for "Global_active_power" variable

#download and unzip file, library(utils) should be loaded and "data" dir created
url_file<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url_file, "./data/p_cons.zip")
unzip("./data/p_cons.zip",exdir = "./data")

#read data. set colClasses for faster reading and na.strings to define NA class. 
#fread can be used instead, for even faster processing
p_cons_rt<-read.table("./data/household_power_consumption.txt",header = TRUE, sep = ";",
                      na.strings=c('?',"NA","N/A","",NULL),
                      colClasses=c("character","character","numeric","numeric","numeric",
                                   "numeric","numeric","numeric","numeric"))

#convert time and Date fields to appropriate class
p_cons_rt$Time = strptime(paste(p_cons_rt$Date,p_cons_rt$Time),'%d/%m/%Y %H:%M:%S')
p_cons_rt$Date = as.Date(p_cons_rt$Date,'%d/%m/%Y')

#subset requested time frame
df_subset<- p_cons_rt[p_cons_rt$Date %in% (as.Date(c("2007-02-01","2007-02-02"))),]


#open png device
png(file = "ass1_plot3.png")

#reset graphics parameters to default state, set plotting region to square(pty = "s")
#set plotting background to transparent
par(mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1), oma = c(0,0,0,0), bg = "transparent",pty = "s")

#build plot to png file
with(df_subset,{
        plot(Time,Sub_metering_1,type = "l", ylab = "Energy sub metering",xlab=NA)
        lines(x = Time,y = Sub_metering_2,col = "Red")
        lines(x = Time,y = Sub_metering_3,col = "Blue")
        legend("topright", lty=1, col=c("Black","Red","Blue"),
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}  )
#close png-device
dev.off()
