# Load the dataset
dataset <- "enUSnews"
location <- "data/final/en_US/en_US.news.txt"

assign(dataset, readLines(location), envir = .TargetEnv)
rm("dataset", "location", envir = .TargetEnv)