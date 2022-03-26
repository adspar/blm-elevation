library("psych")

# 6 make scores & and add to df ----

# need to define max and min values for reversed variables...
# i can't figure out how to do scales with different ranges
# all in one scoring, so we do 5 scorings, one for each unique range

get_scale_range <- function(x){
  df %>%
    select(all_of(x)) %>%
    range(na.rm = T)
}

# use this to enter/check ranges for items
(useful_range_reference_object <- map_df(scale_keys, get_scale_range) )

# attitude items, 1 to 7
scores1 <- scoreItems(
  keys= scale_keys_with_reversals[1:12], 
  items = df,
  impute= "none", 
  min = 1,
  max = 7,
  digits=2)

# protest support, 1 to 5
scores2 <- scoreItems(
  keys= scale_keys_with_reversals[13:14], 
  items = df,
  impute= "none", 
  min = 1,
  max = 5,
  digits=2)

# emotion items, 0 to 3
scores3 <- scoreItems(
  keys= scale_keys_with_reversals[15:19], 
  items = df,
  impute= "none", 
  min = 0,
  max = 3,
  digits=2)

#protest tactic approval items, 1 to 5
scores4 <- scoreItems(
  keys= scale_keys_with_reversals[20], 
  items = df,
  impute= "none", 
  min = 1,
  max = 5, 
  digits=2)

# ii_ items, -1 to 1
scores5 <- scoreItems(
  keys= scale_keys_with_reversals[21:24], 
  items = df,
  impute= "none", 
  min = -1,
  max = 1,
  digits=2)


# pin the scores onto our dataframe
df <- df %>%
  bind_cols( scores1$scores %>% as_tibble,
             scores2$scores %>% as_tibble,
             scores3$scores %>% as_tibble,
             scores4$scores %>% as_tibble,
             scores5$scores %>% as_tibble)

# the scores items have other useful info, e.g. alphas
# condense those objects into a list

scale_scores_details <- list(
  
  idealism_and_policy = scores1,
  blm_support = scores2,
  emotion = scores3,
  protest_tactics = scores4,
  conservatism = scores5
  
)

# we just saved these items into the list above, so delete them from the environment
rm(scores1, scores2, scores3, scores4, scores5)
