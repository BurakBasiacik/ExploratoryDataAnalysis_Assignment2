##download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("pm25data.zip")){download.file(url,destfile = "pm25data.zip")}

unzip("./pm25data.zip")

## read unzipped  data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset and aggregate data
subsetData<-subset(NEI,fips=="24510")
yearlyBData<-aggregate(Emissions~year,data=subsetData,sum)

##plotting
##plotting
png("plot2.png")
with(yearlyBData,plot(year,Emissions,ylab="Total PM2.5 Emissions(tons)",
                     xlab="Year",main="Total pm2.5 Emissions in Baltimore City, MD",
                     type="b",pch=19, lwd=2))
dev.off()
