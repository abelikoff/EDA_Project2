#!/usr/bin/env Rscript

## Total PM2.5 emissions by year


rm(list = ls())
library(reshape2)
source("utils.R")

data <- prepareAndLoadData()


## summarize emissions by year

tbl <- dcast(data$NEI, year ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "Emissions")


## plot data

png(filename = "plot1.png", width = 480, height = 480)
barplot(tbl$Emissions / 1e6, names.arg=tbl$Year, border="red", density=50,
        xlab="Year", ylab="Emissions (megatons)",
        main="Total PM2.5 emissions by year")
grid()
