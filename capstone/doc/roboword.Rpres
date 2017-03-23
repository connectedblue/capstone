roboword
========================================================
author: Chris Shaw
date: 23 March 2017
autosize: true



Word prediction
========================================================

We are pleased to announce RoboWord, an application designed to predict the most likely next word to occur in a phrase.  
 - availble from <https://connectedblue.shinyapps.io/shinyapp/>.
 - Fast and responsive: predict as you type
 - Small footprint:  prediction model stored in around 10Mb
 - reasonable accuracy for a range of phrases
 - easy to use:  just start typing in the box and watch as RoboWord predicts what will come next
 

How it works - Data preparation
========================================================

Machine learning techniques have been used to build an optimised model.  There are a number of steps in the process:
 - A large corpus from twitter, news sites and blogs was analysised using N-grams (occurences of 2, 3 and 4 sequences of words). 
 - Due to the nature of the raw data, a lot of words are captured that are not useful for the model (e.g. aaaargh).  
 - In fact, around 90% of the individual words account for less than 10% of the total.  These were removed to leave a dictionary of around 17,000 words.

How it works - Model construction
========================================================

 - The N-gram models are further compacted by substituting each word for an index number from the dictionary.  This reduces the amount of space to around 1/3 of the original. 
 - Probablities are calculated for each 2-, 3- and 4-gram based on the number of occurences of the nth word divided by the number of occurences of the previous (n-1) words together.
 - A backoff approach is deployed which first checks the most likely word to follow the last three words of a phrase, or if not known, check the last two, then one.
 
 
Future Phases
========================================================

 - RoboWord will be upgraded to guess words in different languages.  There is nothing language specific about the model, so new sets of training data will enable multi lingual capability.
 - Greater accuracy will be gained by training with more raw data.  There is a trade off between memory storage and application performance, so this needs to be applied carefully.
 - Full source code available from <https://github.com/connectedblue/capstone/tree/master/capstone>
