library(tidyverse)

raw_df <- read_csv( "BLM-protest_study1_raw-data-deidentified.csv" ) 

df <- raw_df %>% 
  # Participant attention filters ----
  filter( vid_time > 90 ) %>%          
  filter( catch_sky_color == 3) %>%      
  filter( catch_honesty == 1) %>%      
  filter( catch_distractions == 3) %>%  
  filter( catch_video_stream == 1)      