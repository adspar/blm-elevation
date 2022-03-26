# Script goal:
# Edit a raw data file to remove identifiers and pilot/testing data,
# and add variables with experiment information.
# Output is a raw data file that can be shared openly, and that
# we use with our downstream wrangling and reporting scripts.

make_raw_data_file_study3 <- function() { 
  library(tidyverse)
  library(snakecase)
  
  raw_data_file_name <-
    "BLM-protest_study3_raw-data-with-identifiers-DO-NOT-SHARE.csv"
  
  variables_file_name <- "BLM-protest_study3_variables.csv"
  
  edited_data_file_name <-
    "BLM-protest_study3_raw-data-deidentified.csv"
  
  # variable renaming tool
   variables <- read_csv(variables_file_name)
  
  # read in the raw and write out the edited data ----
  read_csv(raw_data_file_name,
           skip = 3,
           # these 3 skipped rows of headers are now in the 'variables' object
           col_names = variables$new_name) %>%
    
    select(-starts_with("delete")) %>% # identifier removal
    
    rename_with( to_snake_case) %>%
    
    ## create useful variables ----
    
   ### video condition -----
    mutate( 
      # There is no explicit variable in the raw data for condition
      # But we have 3 variables for the time they spent on video page,
      # and each participant has a value only in one column,
      # corresponding to their video condition   
      condition = as.factor(
        if_else( !is.na(`q_104_page_submit`),  "BLM",
                 if_else(!is.na(`q_508_page_submit`),  "BtB",  
                         if_else(!is.na(`q_502_page_submit`),  "control", "ERROR"))))) %>% 
    mutate( condition = relevel(condition, ref = 3)) %>%
    
    #### time spent on video page ----
    mutate( 
      # condense those two time variables into one
      vid_time = 
        pmax( `q_104_page_submit`, 
              `q_502_page_submit`, 
              `q_508_page_submit`, 
              na.rm = T ) ) %>%
    
    write_csv( edited_data_file_name )
 
}

make_raw_data_file_study3()
