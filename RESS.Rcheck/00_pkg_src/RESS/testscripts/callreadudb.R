file <- "querytimeapache.sh"
rscriptfile <- "timeapache.R"

library("RESS")

read.udb(file)

source(rscriptfile, echo=FALSE)
# Turn echo to TRUE to make the output less results-oriented and easier to debug.

remove(file, rscriptfile)
