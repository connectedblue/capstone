
# Function to sample a text file dataset and read in a subset of lines
# returns the subset
# slect_pcent is the percentage of the overall file size to sample (won't be exact - this is fed into
# the rbinom function to determine a coin flip distribution)

sample_file <- function(full_dataset, select_pcent) {
        
        file_lines <- countLines(full_dataset)
        
        lines_to_extract <- rbinom(n=file_lines, size=1, prob=select_pcent)
        extract_indexes <- which(lines_to_extract %in% 1)
        skip_gaps <- c(extract_indexes[1], diff(extract_indexes))
        
        
        output <- c()
        
        con <- file(full_dataset, "r")
        
        for(s in skip_gaps) {
                output <- c(output, scan(con, what=character(), 
                                         n=1, skip=s, sep = "\n", quiet = TRUE,
                                         encoding = "UTF-8")
                                         
                )
        }
        
        close(con)
        output
} 



