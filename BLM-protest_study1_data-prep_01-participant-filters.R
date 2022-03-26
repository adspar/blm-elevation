library(tidyverse)


raw_df <- read_csv( "BLM-protest_study1_raw-data-deidentified.csv" ) 

df <- raw_df %>% 

  # Participant attention filters ----
## NOTE THAT SOME OF THESE ARE SOMEWHAT ARBITRARY.

  filter( vid_time > 90 ) %>%           # Vid is 104s
  filter( catch_sky_color == 3) %>%        # Attention check
  filter( catch_honesty == 1) %>%       # arguably should include 2s too
  filter( catch_distractions == 3) %>%  # maybe could include others?
  filter( catch_video_stream == 1)          # this allows people who said minor buffering issues



## Can look at these to see how many each filter eliminates from the raw ----
# 
# raw_df$catch_sky_color[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# raw_df$catch_honesty[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
raw_df$catch_distractions[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
raw_df$catch_video_stream[raw_df$q_104_page_submit > 100] %>% as.factor %>% summary()
# 


