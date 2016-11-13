# Load the dataset
dataset <- "enUStwitter"
location <- "data/final/en_US/en_US.twitter.txt"

assign(dataset, readLines(location), envir = .TargetEnv)
rm("dataset", "location", envir = .TargetEnv)