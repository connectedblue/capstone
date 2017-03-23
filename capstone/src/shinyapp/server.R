library(shiny)
library(dplyr)
library(data.table)

load("./tree1.RData")
load("./word_list.RData")


#server part 


shinyServer(
        function(input, output, session) {
                
                # set output$predicted_word based on input$phrase
                
                observeEvent(input$phrase, {
                        next_word <- predict_next_word(input$phrase)[1]
                        if (is.na(next_word)) next_word <-""
                        output$predicted_word <- renderUI(HTML(paste0(input$phrase, 
                                                                   " .... ",
                                                                   next_word
                                                                   )))
                })
                
                 
        }
)


# Turn a single input phrase into at most three words which are in the word_list
# Index numbers are returned - words at the end of the phrase are the ones that count
# This can then be used to predict the next word

three_word_phrase <- function (phrase, word_list) {
        phrase <- strsplit(phrase, " ")[[1]]
        
        # remove any words not in  the word_list
        phrase <- phrase[phrase %in% word_list$word]
        
        # Convert to numbers
        phrase <- word_list[phrase]$num 
        
        n<-length(phrase)
        
        if (n>3) phrase <- phrase[(n-2):n]
        if (n<3) phrase <- c(rep(0, 3-n), phrase)
        
        phrase
}

# Function to find all matches in the tree of a phrase
# tree is an eNgramTree

tree_match <- function (phrase, tree) {
        return (tree[n_3==phrase[1] & n_2==phrase[2] & n_1==phrase[3]])
}


# Function to take an arbitary phrase and find all occurences in a tree
# of 4-,3- and 2-grams

phrase_tree <- function (phrase, tree, word_list) {
        phrase <- three_word_phrase(phrase, word_list)
        
        # start with first tree
        result <- tree_match(phrase, tree)
        
        if ((phrase[1]==0 & phrase[2]==0)|nrow(result)==1) return(result)
        
        if (phrase[1]==0) {
                phrase[2] <- 0
                result <- rbind(result, tree_match(phrase, tree))
                return(result)
        }
        else {
                phrase[1] <- 0
                result <- rbind(result, tree_match(phrase, tree))
                if (nrow(result)==1) return(result)
                phrase[2] <- 0
                result <- rbind(result, tree_match(phrase, tree))
                return(result)
        }
}

predict_next_word <- function(phrase) {
        # get table of next words
        words <- phrase_tree(phrase, tree1, word_list)
        words$cols <- ifelse(words$n_3>0, 3, ifelse(words$n_2>0,2,1))
        
        # re-arrange in decreasing order of likelihood
        words <- words %>% arrange(desc(cols))
        return(word_list[words$nth]$word)
}



