# This file contains an efficient Ngram Tree

# Only words that are being kept will be stored in the tree and will be
# referenced by an index number stored in a seperate data frame.
# Two objects exist:
#        word_index:  data frame of index value assigned to each word
#        tree:        data frame storing frequencies for each ngram
#                     columns as follows
#                          n_3   n-3th word  (could be zero)
#                          n_2   n-2nd word  (could be zero)
#                          n_1   n-1th word  (could be zero)
#                          nth   nth word  (always present)
#                          type  ngram type (up to 4)
#                          freq  frequency of nth word following n-1 phrase
#                          count_n_1 number of n-1 phrases

# Create an index of all the words to keep from a character vector of words
# to keep

create_word_index <- function(keepwords) {
        idx <- data.table(
                           num = 1:length(keepwords),
                           word = keepwords,
                           key = c("word")
        )
        return(idx)
}

# turn a phrase list into index numbers from word_index
# phrase can be arbitary length - only up to last n valid words
# will be returned 
# valid word is one which has an index numb

phrase_to_index <- function(phrase, word_index) {
        phrase <- strsplit(phrase, " ")
        # apply indices
        idx<-lapply(phrase, function(x) word_index$num[match(x, word_index$word)])
        
        # remove NAs
        idx <- lapply
        
        return(idx)
}

# Turn a phrase into exactly 4 index values 
# if the phrase is less than 4 words, the leading values are zero.  If greater
# than four it is truncated to exactly 4

four_phrase_index <- function(phrase, word_index) {
        idx <- phrase_to_index(phrase, word_index, 4)
        n<-length(idx)
        if (n<4) idx <- c(rep(0, 4-n), idx)
        return(idx)
        
}


# create an efficient n-gram tree
# input is a tree calculated by NgrameTree and a word_index
# output is a the tree data.table object:
#        tree:        data frame storing frequencies for each ngram
#                     columns as follows
#                          n_3   n-3th word  (could be zero)
#                          n_2   n-2nd word  (could be zero)
#                          n_1   n-1th word  (could be zero)
#                          nth   nth word  (always present)
#                          type  ngram type (up to 4)
#                          freq  frequency of nth word following n-1 phrase
#                          count_n_1 number of n-1 phrases

eNgramTree <- function (ngram_tree, word_index) {
        
        n<-nrow(ngram_tree)
        # create a skeleton tree 
        tree <- data.frame(n_3=rep(0,n),
                           n_2=rep(0,n),
                           n_1=rep(0,n),
                           nth=rep(0,n),
                           type=rep(0,n),
                           freq=ngram_tree$freq,
                           count_n_1=ngram_tree$count_n_1

                                           )
        # fill in each row
        phrase <- paste0(ngram_tree$n_1, " ", ngram_tree$nth)
        idx <- four_phrase_index(phrase, word_index)
        tree$n_3<-idx[1]
        tree$n_2<-idx[2]
        tree$n_1<-idx[3]
        tree$nth<-idx[4]

        
        tree
}







