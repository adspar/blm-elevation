# This is for some side analyses of what the previous script accomplished.



# Notes regarding filters ----

## Time spent on video page eliminates a LOT of participants ----
summary(study1$raw_df$`Q104_Page Submit` > 100)
# this could be because the first several seconds of the video
# appear frozen.

### Here's an alternate df of these eliminated cases ----
df_novid <- study1$raw_df %>%
  filter( `Q104_Page Submit` < 100 )

### Vast majority were under 50, most under 10!
sort(df_novid$`Q104_Page Submit`)

### Of those who didn't drop out, most passed the attention check
df_novid$sky_color %>% as.factor %>% summary
df_novid$technical_problems %>% as.factor %>% summary
df_novid$did_video_work %>% as.factor %>% summary
df_novid$honesty_check %>% as.factor %>% summary


## Probably don't need to eliminate cases with NAs among key variables ----

test<- study1$raw_df %>%
  filter( `Q104_Page Submit` > 100 ) %>% 
  filter( sky_color == 3) %>%
  select( iraq_fair_R:`covid-19_lockdown_happy`)

rowSums(is.na(test)) %>% sort # just 2 cases, each with only 1 NA

