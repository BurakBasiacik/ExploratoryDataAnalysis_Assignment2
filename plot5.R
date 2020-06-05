##download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("pm25data.zip")){download.file(url,destfile = "pm25data.zip")}

unzip("./pm25data.zip")

## read unzipped  data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##filter and subset data

vehicle <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
vehicleSCC <- SCC[vehicle,]$SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

vehicleBal <- (vehicleNEI[vehicleNEI$fips == "24510",])
vehBalYear <- aggregate(Emissions~year,data=vehicleBal,sum)

##plotting

png("plot5.png")
with(vehBalYear,plot(year,Emissions,ylab="Total PM2.5 Emissions(tons)",xlab="Year",
      main="Total Motor Vehicle pm2.5 Emissions in Baltimore City, MD",
                         type="b",pch=19, lwd=2))
dev.off()



