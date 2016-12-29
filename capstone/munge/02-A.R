# Optimise the data sets

# create a digest look up table of nth words

words <- unique(fourgram_tree$nth)
digest <- sapply(as.vector(words), FUN=digest, raw=FALSE, algo="md5")

nth_words <- data.table(word=words, digest=digest,  key=c("word"))


#digest <- sapply(fourgram_tree$n_1, FUN=digest, raw=FALSE, algo="md5")

#new_fourgram <- data.table(digest=digest, nth=fourgram_tree$nth,
#                           freq=fourgram_tree$freq,count_n_1=fourgram_tree$count_n_1, 
#                           key=c("digest"))


