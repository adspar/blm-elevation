source("BLM-elevation_data-prep.R")
write_csv( pilot$df, "BLM-elevation_pilot_processed-data.csv"   )
write_csv( study1$df, "BLM-elevation_study1_processed-data.csv"   )
write_csv( study2$df, "BLM-elevation_study2_processed-data.csv"   )
