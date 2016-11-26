# First the corpus is cleaned

cache("cleancorpus",  depends="corpus", CODE={
        #start with raw corpus
        docs <- corpus
        
        # Strip out troublesome non UTF-8 characters
        docs<-tm_map(docs, content_transformer(function(x) iconv(enc2utf8(x), sub = "byte"))) 
        
        # perform some standard cleanup operations
        docs <- tm_map(docs, removePunctuation)  
        docs <- tm_map(docs, removeNumbers) 
        docs <- tm_map(docs, content_transformer(tolower)) 
        docs <- tm_map(docs, removeWords, stopwords(config$language))

        
        # remove profanity from the corpus
        docs <- tm_map(docs, removeWords, profanity)
        
        docs <- tm_map(docs, stripWhitespace) 
        docs <- tm_map(docs, PlainTextDocument) 
        docs
})

if(exists("docs")) rm(docs)

# Create a document term matrix for the clean corpus
cache("dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus)
})

# single word frequencies

w_freq <- colSums(as.matrix(dtm))
w_ord <- order(w_freq)

BigramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 2), paste, collapse = " "), use.names = FALSE)

# Compute bi-grams from the clean corpus

cache("bigram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus, control = list(tokenize = BigramTokenizer))   
}) 

# bigram word frequencies

bi_freq <- colSums(as.matrix(bigram_dtm))
bi_ord <- order(bi_freq)

TrigramTokenizer <-
        function(x)
                unlist(lapply(ngrams(words(x), 3), paste, collapse = " "), use.names = FALSE)

# Compute tri-grams from the clean corpus

cache("trigram_dtm", depends="cleancorpus", CODE={
        DocumentTermMatrix(cleancorpus, control = list(tokenize = TrigramTokenizer))   
}) 

# Trigram word frequencies

tri_freq <- colSums(as.matrix(trigram_dtm))
tri_ord <- order(tri_freq)
