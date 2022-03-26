library("psych")

# 6 make scores & and add to df ----

# need to define max and min values for reversed variables...
# i can't figure out how to do scales with different ranges
# all in one scoring, so we do 5 scorings, one for each unique range

get_scale_range <- function(x){
  df %>%
    select(all_of(x)) %>%
    range()
}

# use this to enter/check ranges for items
(useful_range_reference_object <- map_df(scale_keys, get_scale_range) )

# attitude items, 1 to 7
scores1 <- scoreItems(
  keys= scale_keys_with_reversals[1:4], 
  items = df,
  impute= "none", 
  min = 1,
  max = 7,
  digits=2)

# emotion items, 0 to 3
scores3 <- scoreItems(
  keys= scale_keys_with_reversals[5:9], 
  items = df,
  impute= "none", 
  min = 0,
  max = 3,
  digits=2)

#protest approval items, 1 to 6
scores4 <- scoreItems(
  keys= scale_keys_with_reversals[10], 
  items = df,
  impute= "none", 
  min = 1,
  max = 5,
  digits=2)

# ii_ items, -1 to 1
scores5 <- scoreItems(
  keys= scale_keys_with_reversals[11:14], 
  items = df,
  impute= "none", 
  min = -1,
  max = 1,
  digits=2)

# support items, 1 to 5
scores6 <- scoreItems(
  keys= scale_keys_with_reversals[15], 
  items = df,
  impute= "none", 
  min = 1,
  max = 5,
  digits=2)


# pin the scores onto our dataframe
df <- df %>%
  bind_cols( scores1$scores %>% as_tibble,
             
             scores3$scores %>% as_tibble,
             scores4$scores %>% as_tibble,
             scores5$scores %>% as_tibble,
             scores6$scores %>% as_tibble)

# the scores items have other useful info, e.g. alphas
# condense those objects into a list

scale_scores_details <- list(
  
  idealisms = scores1,
  emotion = scores3,
  protest_tactics = scores4,
  conservatism = scores5,
  support_composite = scores6
  
)

# delete the objects that were just stored in a list
rm(scores1, scores3, scores4, scores5, scores6)
