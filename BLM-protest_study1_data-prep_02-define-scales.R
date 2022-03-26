# some useful custom functions for this script
source("BLM-protest_studyn_data-prep_helper-functions.R", local = T)


# Create a key for indexing scale items ----
scale_keys <- list(
  
  #  - Scales are named based on the meaning of higher values.
  #  - e.g. the political orientation variable is called
  #         conservativism; lower scores are more liberal
  #  - (Some scale items require reverse-scoring; we do that below) 
  
  # Badness of Policies
  bad_policy_iraq =     find_in_variable_name("iraq_") , # all variables in this scale contain "iraq_"
  bad_policy_bailouts = find_in_variable_name("bailouts_") , # etc
  bad_policy_offshore = find_in_variable_name("offshore_") ,
  bad_policy_covid19_relief =  find_in_variable_name("covid_19_relief_") ,
  bad_policy_corps =    find_in_variable_name("large_corps_") ,
  bad_policy_charity =  find_in_variable_name("charity_") ,
  bad_policy_gov =      find_in_variable_name("gov_response_overall_") ,
  bad_policy_community= find_in_variable_name("community_response_") ,
  
  # Idealisms
  idealism_community = find_in_variable_name("idealism_community_") , # all variables include 'community' but not 'response'
  idealism_elites =    find_in_variable_name("idealism_elites_") ,
  idealism_police =    find_in_variable_name("idealism_police_") ,
  idealism_all    =    find_in_variable_name("idealism_") ,
  
  # BLM protest related support, Time 1 & 2 (before & after vid)
  blm_support_t1 = find_in_variable_name("pre_video_") ,
  blm_support_t2 = find_in_variable_name("post_video_") ,
  
  #General Positive Affect
  positive_affect = find_in_variable_name("positive_affect_") ,
  
  # Elevation -- overall, and 3 subscales
  elevation = find_in_variable_name("elevation_"),
  somatic = c("elevation_warmth", "elevation_lump", 
              "elevation_tears", "elevation_goosebumps" ),
  prosocial_motives = c("elevation_want_to_help", "elevation_feel_close",
                        "elevation_better_person","elevation_find_ways_to_help"),
  folk_affect = c("elevation_uplifted", "elevation_moved",
                  "elevation_touched","elevation_inspired",
                  "elevation_compassion", "elevation_admiration",
                  "elevation_heartwarming"),
  
  # Approval of protest tactics
  tactics = find_in_variable_name("tactic_"),
  
  # Issues Index -- Conservativisms
  conservativism_social = find_x_and_y("ii_", "_s_") , # all items in this scale contain "ii_" and "_s_"
  conservativism_military = find_x_and_y("ii_", "_m_") ,
  conservativism_economic = find_x_and_y("ii_", "_e_") ,
  conservativism_overall = find_in_variable_name("ii_") 
)





scale_keys_with_reversals <- map(scale_keys, tag_Rr)

