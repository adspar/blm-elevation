# some useful custom functions for this script
source("BLM-protest_studyn_data-prep_helper-functions.R", local = T)

# Create a key for indexing scale items ----
scale_keys <- list(
  #  - Scales are named based on the meaning of higher values.
  #  - e.g. the political orientation variable is called
  #         conservativism; lower scores are more liberal
  #  - (Some scale items require reverse-scoring; we do that below) 
  
  # Idealisms
  idealism_community = find_in_variable_name("idealism_community_") , 
  idealism_police =    find_in_variable_name("idealism_police_") ,
  idealism_blm =    find_in_variable_name("idealism_blm_") ,
  idealism_btb =    find_in_variable_name("idealism_btb_") ,
  idealism_all =    find_in_variable_name("idealism_") ,
  
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
  
  # Issues Index -- Conservativisms
  conservativism_social = find_x_and_y("ii_", "_s_") , # all items in this scale contain "ii_" and "_s_"
  conservativism_military = find_x_and_y("ii_", "_m_") ,
  conservativism_economic = find_x_and_y("ii_", "_e_") ,
  conservativism_overall = find_in_variable_name("ii_"), 
  
  ## SDO
  sdo_composite = find_in_variable_name("sdo_")
)

# make key to feed into psych::scoreItems
scale_keys_with_reversals <- map(scale_keys, tag_Rr) # this "tags" items needing reverse-scoring


