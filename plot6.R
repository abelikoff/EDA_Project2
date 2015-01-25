#!/usr/bin/env Rscript

## Yearly PM2.5 emissions for Baltimore City, MD broken by type


rm(list = ls())
library(reshape2)
library(ggplot2)
source("utils.R")

data <- prepareAndLoadData()


## summarize emissions by year and type

scc.vehicles = data$SCC$SCC[grep("vehicle", data$SCC$EI.Sector, ignore.case=TRUE)]
data.veh <- subset(data$NEI,
                   fips %in% c("24510", "06037") & SCC %in% scc.vehicles,
                   select = c(Emissions, year, fips))

tbl <- dcast(data.veh, year + fips ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "fips", "Emissions")
tbl$City <- NA
tbl$City[tbl$fips == "24510"] <- "Baltimore City, MD"
tbl$City[tbl$fips == "06037"] <- "Los Angeles, CA"
tbl$fips <- NULL


## plot data

png(filename = "plot6.png", width = 480, height = 480)
ggplot(tbl, aes(x=factor(Year), y=Emissions, fill=City)) +
    geom_bar(stat="identity", position="dodge") +
        labs(title="PM2.5 motor vehicle emissions for two cities",
             x="Year", y="Emissions (tons)")
