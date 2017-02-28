# First the corpus is cleaned

cache("cleancorpus",  depends="corpus", CODE={
        #start with raw corpus
        docs <- corpus
        
        # Strip out troublesome non ASCII characters
        docs<-tm_map(docs, content_transformer(function(x) iconv(enc2utf8(x), "UTF-8", "ascii", sub = ""))) 
        
        # perform some standard cleanup operations
        docs <- tm_map(docs, removePunctuation)  
        docs <- tm_map(docs, removeNumbers) 
        docs <- tm_map(docs, content_transformer(tolower)) 
        #docs <- tm_map(docs, removeWords, stopwords(config$language))

        
        # remove profanity from the corpus
        docs <- tm_map(docs, removeWords, profanity)
        
        docs <- tm_map(docs, stripWhitespace) 
        docs <- tm_map(docs, PlainTextDocument) 
        docs
})


# Compute uni-grams from the  clean corpus


cache("unigram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus)   
}) 

# unigram word frequencies

uni_freq <- colSums(as.matrix(unigram_dtm))
uni_ord <- order(uni_freq)


# Compute bi-grams from the clean corpus

BigramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

cache("bigram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus, control = list(tokenize = BigramTokenizer))   
}) 

# bigram word frequencies

bi_freq <- colSums(as.matrix(bigram_dtm))
bi_ord <- order(bi_freq)


# Compute tri-grams from the corpus

TrigramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 3), paste, collapse = " "), use.names = FALSE)


cache("trigram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus, control = list(tokenize = TrigramTokenizer))   
}) 

# Trigram word frequencies

tri_freq <- colSums(as.matrix(trigram_dtm))
tri_ord <- order(tri_freq)


# Compute four-grams from the corpus

FourgramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 4), paste, collapse = " "), use.names = FALSE)


cache("fourgram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus, control = list(tokenize = FourgramTokenizer))   
}) 

# Figure out which words to keep in the tree
most_freq<-quantile(uni_freq, probs = seq(0, 1, by= 0.1))[config$remove_word_freq]
words_to_keep <- names(uni_freq[uni_freq>=most_freq])


# Fourgram word frequencies

four_freq <- colSums(as.matrix(fourgram_dtm))
four_ord <- order(four_freq)


# Create a fourgram tree

cache("fourgram_tree", depends="four_freq", CODE={
        NgramTree(four_freq, words_to_keep)
        
})

# Trigram word frequencies

tri_freq <- colSums(as.matrix(trigram_dtm))
tri_ord <- order(tri_freq)




# Create a trigram tree

cache("trigram_tree", depends="tri_freq", CODE={
        NgramTree(tri_freq, words_to_keep)
        
})


# Create a bigram tree

cache("bigram_tree", depends="bi_freq", CODE={
        NgramTree(bi_freq, words_to_keep)
        
})

# Create a unigram tree

cache("unigram_tree", depends="uni_freq", CODE={
        NgramTree(uni_freq, words_to_keep)
})


# Remove some un-needed data sets 
rm(profanity)
