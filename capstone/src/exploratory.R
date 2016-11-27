# Build basic ngram models for exploratory analysis
load.project()

# Too slow
#cache("first_word_tree", CODE={
#        
#        tree <- list()
#        
#        for (word in words_to_keep) {
#                next_words <- bi_freq[grep(paste0("^", word, "\\b"), bi_freq)]
#                tree[[word]] <- next_words
#                
#        }
#        
#        
#})

# Get a list of all bigrams begining with happy

bigram_happy <- bi_freq[grep("^happy\\b", bifreq)]

tree <- list()

for (b in bigram_happy) {
        trigram_happy <- tri_freq[grep(paste0("^(", b, ")\\b")), tri_freq)]
        tree[[b]]<-prob_nextword(tri_freq, )        
}
