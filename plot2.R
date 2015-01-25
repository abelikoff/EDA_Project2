#!/usr/bin/env Rscript

## Yearly PM2.5 emissions for Baltimore City, MD


rm(list = ls())
library(reshape2)
source("utils.R")

data <- prepareAndLoadData()


## summarize emissions by year

data$NEI <- subset(data$NEI, fips == "24510", select = c(Emissions, year))
tbl <- dcast(data$NEI, year ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "Emissions")


## plot data

png(filename = "plot2.png", width = 480, height = 480)
barplot(tbl$Emissions / 1e3, names.arg=tbl$Year, border="red", density=50,
        xlab="Year", ylab="Emissions (kilotons)",
        main="Yearly PM2.5 emissions for Baltimore City, MD")
grid()
