library("psych")

# 6 make scores & and add to df ----

# we need to define max and min values for reversed variables, but
# i can't figure out how to do scales with different ranges
# all in one scoring. so we do 5 scorings, one for each unique range.

get_scale_range <- function(x){
  df %>%
    select(all_of(x)) %>%
    range(na.rm = T)
}

# use this to enter/check ranges for items
(useful_range_reference_object <- map_df(scale_keys, get_scale_range) )

# elevation_inspired            has 1 missing item
# ii_r_e_globalization          has 2 missing items
# sdo_against_group_equality    has 3 missing items
# sdo_r_for_group_equality      has 2 missing items

# attitude items, 1 to 7
scores1 <- scoreItems(
  keys= scale_keys_with_reversals[1:5], 
  items = df,
  impute= "none", 
  min = 1,
  max = 7,
  digits=2)

# emotion items, 0 to 3
scores2 <- scoreItems(
  keys= scale_keys_with_reversals[6:10], 
  items = df,
  impute= "none", 
  min = 0,
  max = 3,
  digits=2)

# ii_ items, -1 to 1
scores3 <- scoreItems(
  keys= scale_keys_with_reversals[11:14], 
  items = df,
  impute= "none", 
  min = -1,
  max = 1,
  digits=2)

# sdo, 1 to 10
scores4 <- scoreItems(
  keys= scale_keys_with_reversals[15], 
  items = df,
  impute= "none", 
  min = 1,
  max = 10,
  digits=2)



# pin the scores onto our dataframe
df <- df %>%
  bind_cols( scores1$scores %>% as_tibble,
             scores2$scores %>% as_tibble,
             scores3$scores %>% as_tibble,
             scores4$scores %>% as_tibble
  )

# the scores items have other useful info, e.g. alphas
# condense those objects into a list

scale_scores_details <- list(
  
  idealisms = scores1,
  emotion = scores2,
  conservatism = scores3,
  sdo = scores4
  
)

rm(scores1, scores2, scores3, scores4)
