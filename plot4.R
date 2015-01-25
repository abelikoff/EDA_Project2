#!/usr/bin/env Rscript

## PM2.5 emissions caused by coal combustion


rm(list = ls())
library(reshape2)
source("utils.R")

data <- prepareAndLoadData()


## pick coal combustion related emissions and summarize by year

scc.coalcomb = data$SCC$SCC[grep("comb.*coal", data$SCC$EI.Sector,
    ignore.case=TRUE)]
data.coal <- subset(data$NEI, SCC %in% scc.coalcomb , select = c(Emissions, year))
tbl <- dcast(data.coal, year ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "Emissions")


## plot data

png(filename = "plot4.png", width = 480, height = 480)
barplot(tbl$Emissions / 1e3, names.arg=tbl$Year, border="red", density=50,
        xlab="Year", ylab="Emissions (kilotons)",
        main="PM2.5 emissions caused by coal combustion")
grid()
