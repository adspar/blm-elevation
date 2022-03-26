# Script goal:
# Edit a raw data file to remove identifiers and pilot/testing data.
# Output is a raw data file that can be shared openly, and that
# we use with our downstream wrangling and reporting scripts.


make_raw_data_file_study2 <- function() { 
  library(tidyverse)
  
  raw_data_file_name <-
    "BLM-protest_study2_raw-data-with-identifiers-DO-NOT-SHARE.csv"
  
  variables_file_name <- "BLM-protest_study2_variables.csv"
  
  edited_data_file_name <-
    "BLM-protest_study2_raw-data-deidentified.csv"
  
  # variable renaming tool
   variables <- read_csv(variables_file_name)
  
  # read in the raw and write out the edited data ----
  read_csv(raw_data_file_name,
           skip = 3,
           # these 3 skipped rows of headers are now in the 'variables' object
           col_names = variables$new_name) %>%
    
    select(-starts_with("delete")) %>% # identifier removal
  
    # reformat variable names
    rename_with( to_snake_case)  %>%
    
    # conditions
    mutate( 
      # There is no explicit variable in the raw data for condition
      # But we have two variables for the time they spent on video page,
      # and each participant has a value only in one column,
      # corresponding to their video condition   
      condition = as.factor(if_else( is.na( q_104_page_submit), 
                                     "control", "BLM"  ))) %>% # validated against the inverse logic on 502.
    
     
     mutate( 
       # condense those two time variables into one
       vid_time = 
         pmax( q_104_page_submit, 
               q_502_page_submit, 
               na.rm = T ) ) %>%
    
     write_csv( edited_data_file_name )
 
}

make_raw_data_file_study2()
