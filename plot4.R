##download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("pm25data.zip")){download.file(url,destfile = "pm25data.zip")}

unzip("./pm25data.zip")

## read unzipped  data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##filter and aggregate data
combustion <- grepl(pattern = "combust",x = SCC$SCC.Level.One,ignore.case = TRUE)
coal <- grepl(pattern = "coal",x = SCC$SCC.Level.Four,ignore.case = TRUE)
coalCombustion <- (combustion & coal)
filteredSCC<- SCC[coalCombustion,]$SCC
filteredNEI<- NEI[NEI$SCC %in% filteredSCC,]

filteredYearly<-aggregate(Emissions~year,data=filteredNEI,sum)
##plotting
png("plot4.png")
with(filteredYearly,plot(year,Emissions,ylab="Total PM2.5 Emissions(tons)",
                     xlab="Year",main="Total Coal Combustion Related pm2.5 Emissions in US",
                     type="b",pch=19, lwd=2))
dev.off()


