##download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("pm25data.zip")){download.file(url,destfile = "pm25data.zip")}

unzip("./pm25data.zip")

## read unzipped  data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##subset and aggregate data
subsetData<-subset(NEI,fips=="24510") ##baltimore city
yearlyBData<-aggregate(Emissions~year+type,data=subsetData,sum)

##plotting
library(ggplot2)
png("plot3.png")
ggplot(data=yearlyBData,aes(year,Emissions,color=type))+
      geom_line()+xlab("Year")+ylab("Total PM2.5 Emissions(tons)")+
      ggtitle("Total pm2.5 Emissions in Baltimore City, MD by type")
dev.off()