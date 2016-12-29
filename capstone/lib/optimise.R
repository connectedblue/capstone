# Function to take an ngram tree and reduce the number of rows
# tree has format:
# $ n_1      : chr  
# $ nth      : chr  
# $ freq     : num  
# $ count_n_1: num  
# Only the top 5 (or less) items by freq for each n_1 are kept

reduce_rows <- function (tree) {
        
        # Get the unique n_1 terms
        n_1 <- unique(tree$n_1)
        
        new_tree <- data.frame()
        for (phrase in n_1) {
                rows <- fourgram_tree %>% 
                        filter(n_1==phrase) %>% 
                        arrange(desc(freq)) %>% 
                        filter(row_number()<6) %>%
                        select(n_1, nth)
                new_tree <- rbind(new_tree, rows)
        }
        
        data.table(new_tree, key="n_1")
        
}