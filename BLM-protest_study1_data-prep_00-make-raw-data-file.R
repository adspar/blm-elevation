# Script goal:
# Edit a raw data file to remove identifiers and pilot/testing data.
# Output is a raw data file that can be shared openly, and that
# we use with our downstream wrangling and reporting scripts.


make_raw_data_file <- function() { 
  
  library(tidyverse)
  library(snakecase)
  
  raw_data_file_name <-
    "BLM-protest_study1_raw-data-with-identifiers-DO-NOT-SHARE.csv"
  
  variables_file_name <- "BLM-protest_study1_variables.csv"
  
  edited_data_file_name <-
    "BLM-protest_study1_raw-data-deidentified.csv"
  
  # variable renaming tool
   variables <- read_csv(variables_file_name)
  
  # read in the raw and write out the edited data
   
  read_csv(raw_data_file_name,
           skip = 3,
           # these 3 skipped rows of headers are now in the 'variables' object
           col_names = variables$new_name) %>%
    
    select(-starts_with("delete")) %>% # identifier removal
    
    # reformat variable names
    rename_with( to_snake_case)    %>%
    
    filter(start_date > "2020-06-24") %>% # eliminate pilot/testing data
    
    mutate( 
      vid_time = q_104_page_submit ) %>%
    
    write_csv( edited_data_file_name )
 
}

make_raw_data_file()
