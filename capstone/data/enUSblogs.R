# Load the dataset
dataset <- "enUSblogs"
location <- "data/final/en_US/en_US.blogs.txt"

assign(dataset, readLines(location), envir = .TargetEnv)
rm("dataset", "location", envir = .TargetEnv)