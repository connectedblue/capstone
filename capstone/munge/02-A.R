# Create optimised versions of the Trees

# First, create the wordlist that we are going to use.

word_list <- create_word_index(words_to_keep)

# create a combined optimised tree for each of the Ngrams >1

cache("tree",  depends=c("fourgram_tree", 
                         "trigram_tree",
                         "bigram_tree",
                         "unigram_tree",
                         "word_list"), CODE={
        
        tree <- rbind(eNgramTree(fourgram_tree, word_list),
                      eNgramTree(trigram_tree, word_list),
                      eNgramTree(bigram_tree, word_list))
        
        # The unigram tree needs the 3rd column setting to zero before binding
        e_unigram_tree <- eNgramTree(unigram_tree, word_list)
        e_unigram_tree$n_1 <- as.integer(rep(0, nrow(e_unigram_tree)))
        
        # Add unigram to the tree and turn into a datatable
        
        tree <- rbind(tree, e_unigram_tree)
        setDT(tree, key=c("n_3", "n_2", "n_1", "nth"))
        tree
})
