# Add any project specific configuration here.

# define new config for each language and comment out unused ones

# configuration for the english corpus
add.config(
        language="english",
        # if testing is TRUE then load.project will load a sample corpus from
        # the testing_dir
        testing=TRUE,          
        training_dir="data/final/en_US",
        testing_dir="data/testing/en_US",
        testing_pcent=0.1,
        profanity_file="data/profanity/engprofanity.csv"
        
)




if(!dir.exists(config$testing_dir)) dir.create(config$testing_dir, recursive = TRUE)