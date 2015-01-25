## Utility functions for the project

## Load data files (download and prepare if needed)

prepareAndLoadData <- function() {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

    local.file <- "data.zip"
    data.file <- "data/summarySCC_PM25.rds"
    subset.file <- "subset.Rd"

    if (file.exists(subset.file)) {     # already prepared subset
        load(subset.file)
        return(tbl)
    }

    if (!file.exists(data.file)) {      # must download CSV
        message("Downloading data")
        download.file(url, local.file, method="curl")
        unzip(local.file, exdir="data")
    }

    message("Loading files")
    result <- list()
    result$NEI <- readRDS("data/summarySCC_PM25.rds")
    message("Loaded NEI")
    result$SCC <- readRDS("data/Source_Classification_Code.rds")
    message("Loaded SCC")
    return(result)
}
