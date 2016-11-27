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

