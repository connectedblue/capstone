# First the corpus is cleaned

cleancorpus <- function(docs, language) {
        
        docs <- tm_map(docs, removePunctuation)  
        docs <- tm_map(docs, removeNumbers) 
        #docs <- tm_map(docs, tolower) 
        #docs <- tm_map(docs, removeWords, stopwords(language))
        #docs <- tm_map(docs, stemDocument) 
        #docs <- tm_map(docs, stripWhitespace) 
        #docs <- tm_map(docs, PlainTextDocument) 
        
}

#engdocs <- cleancorpus(engdocs, "english")

#dtm <- DocumentTermMatrix(engdocs)