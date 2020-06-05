##download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("pm25data.zip")){download.file(url,destfile = "pm25data.zip")}

unzip("./pm25data.zip")

## read unzipped  data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##compute yearly totals
yearlyData<-aggregate(Emissions~year, data=NEI, sum)

##plotting
png("plot1.png")
with(yearlyData,plot(year,Emissions/1000000,ylab="Total PM2.5 Emissions(million tons)",
                     xlab="Year",main="Total pm2.5 Emissions in US",
                     type="b",pch=19, lwd=2))
dev.off()
