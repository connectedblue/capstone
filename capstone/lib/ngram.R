# Calculate conditional probabilities

# corpus_n     this is the frequency of n word phrases
# word         this is the word we are guessing the probability for
# previous     this is the phrase of length n-1 that precedes word

# n=3 is the trigram dtm, n=2 is the bigram dtm

prob_nextword <- function (corpus_n, word, previous) {
        
        # filter out all occurrences of previous words in corpus_n
        previous_match <- corpus_n[grep(paste0("^", previous, "\\b"), names(corpus_n))]
        
        # filter out all occurrences of words in previous_match
        word_match <- previous_match[grep(paste0("\\b", word, "$"), names(previous_match))]
        
        list(word_match, previous_match, sum(word_match)/sum(previous_match))
}

partition_vector <- function (v) {
        list <- v[]
        
}

# create an n-gram tree
# input is a vector of ngrame frequencies
# output is a data.table object with the row names as the first (n-1) words and the columns as the n-th word
# Values are the frequencies of (n-1) followed by n

NgramTree <- function (freq) {
        # split the ngrams into a list 
        words<- strsplit(names(freq), " ")
        
        # make a data frame with each phrase in the rows and each column contains individual word
        words <- data.frame(matrix(unlist(words), nrow=length(words), byrow=TRUE),stringsAsFactors=FALSE)
        
        # determine what n is from the number of columns
        n <- ncol(words)
        
        # figure out the n-1 phrases and the n-th words
        n_1 <- apply(words[,-n], 1, paste,  collapse = " ")
        nth <- words[,n]
        
        # create the tree with keyed fields 
        tree <- data.table(n_1=n_1, nth=nth, freq=freq, key=c("n_1", "nth"))
        
        # add the count of each n_1 phrase
        tree <- tree[tree[,.(count_n_1=sum(freq)), by=n_1]]
        
        tree
}

# create an n-1 phrase list from an ngram frequency
# input is a vector of ngram frequencies
# output is a vector of frequencies of (n-1) phrases preceding

N_1phrases <- function (freq) {
        # split the ngrams into a list 
        words<- strsplit(names(freq), " ")
        
        # make a data frame with each phrase in the rows and each column contains individual word
        words <- data.frame(matrix(unlist(words), nrow=length(words), byrow=TRUE),stringsAsFactors=FALSE)
        
        # determine what n is from the number of columns
        n <- ncol(words)
        
        # figure out the unique n-1 phrases and the n-th words
        n_1 <- unique(paste(words$X1, words$X2))
        nth <- unique(words$X3)
        
        
        n_1
        
}
