library(tidyverse)
library(snakecase)

data_file <- "BLM-protest_study2_raw-data-deidentified.csv"

raw_df <- read_csv( data_file ) 

df <- raw_df %>% 

  # Quality control filters
    
  filter( vid_time > 90 ) %>% # 
  filter( catch_sky_color == 3) %>%  # Attention checks
  filter( catch_distractions == 3) %>%  # Attention checks
  filter( catch_video_stream == 1) %>%  # Attention checks
  filter( catch_honesty == 1)   # Attention checks

  



## Can look at these to see how many each filter eliminates from the raw ----
# 
# raw_df$catch_sky_color[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# raw_df$catch_honesty[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# raw_df$catch_distractions[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# raw_df$catch_video_stream[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# 
