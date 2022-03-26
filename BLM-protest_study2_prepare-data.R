prep_study2 <- function() {

  # AUTHORS ONLY SECTION TO CREATE SHAREABLE RAW DATA ----
  # STEP 0 -- Remove identifiers
  # Import raw data with identifiers,
  # and create a new file with shareable raw data from the experiment

  #source("BLM-protest_study2_data-prep_00-make-raw-data-file.R")

  
  # ALL USERS SECTION STARTING FROM SHAREABLE RAW DATA ----
  
  # Step 1: Participant filters
  source("BLM-protest_study2_data-prep_01-participant-filters.R", local = T)
  
  # Step 2: Define our scales
  
  #### PREPARED UP THROUGH HERE SO FAR
  
  source("BLM-protest_study2_data-prep_02-define-scales.R", local = T)

  # Step 3: Reformat scale data
  source("BLM-protest_study2_data-prep_03-reformat-scale-data.R", local = T)

  # Step 4: Calculate scales
  source("BLM-protest_study2_data-prep_04-compute-scales.R", local = T)
  

  list(
    df = df,
    raw_df = raw_df,
    scale_keys = list(raw = scale_keys,
                      with_reversals = scale_keys_with_reversals),
    scores = scale_scores_details
  )

}


  
study2 <- prep_study2()




