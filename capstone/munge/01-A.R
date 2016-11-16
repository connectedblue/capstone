# First the corpus is cleaned

cleancorpus <- function(docs, language, profanity) {
        
        # Strip out troublesome non UTF-8 characters
        docs<-tm_map(docs, content_transformer(function(x) iconv(enc2utf8(x), sub = "byte"))) 
        
        # perform some standard cleanup operations
        docs <- tm_map(docs, removePunctuation)  
        docs <- tm_map(docs, removeNumbers) 
        docs <- tm_map(docs, tolower) 
        docs <- tm_map(docs, removeWords, stopwords(language))

        
        # remove profanity from the corpus
        docs <- tm_map(docs, removeWords, profanity)
        
        #docs <- tm_map(docs, stripWhitespace) 
        #docs <- tm_map(docs, PlainTextDocument) 
        
}

#endocs <- cleancorpus(endocs, "english")

#dtm <- DocumentTermMatrix(engdocs)