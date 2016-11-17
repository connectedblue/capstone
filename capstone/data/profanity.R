# load up a dictionary of profane words into a vector

profanity <- as.vector(read.csv(config$profanity_file, header=FALSE, stringsAsFactors = FALSE)$V1)

# replace question marks with periods to allow regular expression filter to work correctly

profanity <- gsub("\\?", ".", profanity)