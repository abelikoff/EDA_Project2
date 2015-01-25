#!/usr/bin/env Rscript

## PM2.5 emissions caused by motor vehicles in Baltimore City, MD


rm(list = ls())
library(reshape2)
source("utils.R")

data <- prepareAndLoadData()


## pick coal combustion related emissions and summarize by year

scc.vehicles = data$SCC$SCC[grep("vehicle", data$SCC$EI.Sector, ignore.case=TRUE)]
data.veh <- subset(data$NEI, fips == "24510" & SCC %in% scc.vehicles,
                   select = c(Emissions, year))
tbl <- dcast(data.veh, year ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "Emissions")


## plot data

png(filename = "plot5.png", width = 480, height = 480)
barplot(tbl$Emissions, names.arg=tbl$Year, border="red", density=50,
        xlab="Year", ylab="Emissions (tons)",
        main="PM2.5 emissions caused by motor vehicles in Baltimore City, MD")
grid()
