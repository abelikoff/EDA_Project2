#!/usr/bin/env Rscript

## Yearly PM2.5 emissions for Baltimore City, MD broken by type


rm(list = ls())
library(reshape2)
library(ggplot2)
source("utils.R")

data <- prepareAndLoadData()


## summarize emissions by year and type

data$NEI <- subset(data$NEI, fips == "24510", select = c(Emissions, year, type))
tbl <- dcast(data$NEI, year + type ~ NULL, value.var="Emissions", fun.aggregate=sum)
colnames(tbl) <- c("Year", "Type", "Emissions")


## plot data

png(filename = "plot3.png", width = 480, height = 480)
ggplot(tbl, aes(x=factor(Year), y=Emissions, fill=Type)) +
    geom_bar(stat="identity", position="dodge") +
        labs(title="Yearly PM2.5 emissions for Baltimore City, MD",
             x="Year", y="Emissions (tons)")
