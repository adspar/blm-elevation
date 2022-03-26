# Recode some weird reporting values

recode_qualtrics_weirds <- function(x) {
  # For emotion items, our Qualtrics was set to report an entered value of 1 as "-1", etc,
  # presumably as an artefact of copying the format from the political scale
  # So this is the recoding scheme for those items
  recode(x, `-1`=1, `0`=2, `1`=0, `2`=3, .default = NaN)
}

# and these are the affected items
qualtrics_weird_variables <- c(find_in_variable_name("elevation"),
                               find_in_variable_name("positive_affect"),
                               "afraid_of_protestors",
                               "afraid_of_police",
                               "angry_at_protestors",
                               "angry_at_police")

# change the data accordingly
df <- df %>%
  mutate( across( all_of( qualtrics_weird_variables ) , 
                  ~ recode_qualtrics_weirds( .x ) )) 

# There's a second batch where the scale just skipped 5 for some reason.
####   needs confirmation from qualtrics file  ########

recode_qualtrics_weirds2 <- function(x) {
  recode(x, `6` = 5)
}

df <- df %>% 
  mutate( across( all_of( starts_with("tactic")),
                  ~ recode_qualtrics_weirds2( .x)
  ))
