Here you'll store your raw data files. If they are encoded in a supported file format, they'll automatically be loaded when you call `load.project()`.

Raw coursera data is Coursera-SwiftKey.zip, downloaded from project site.

A subset of each datafile is loaded seperately into a variable defined into an R file of the same name.  These are cached after loading before passing to munge.

A file of english language profanity is loaded.  The source of the file is:

http://www.freewebheaders.com/full-list-of-bad-words-banned-by-google/

It's the full list
