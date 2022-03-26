# Prepare each study and rename for manuscript ----
source("BLM-protest_study1_prepare-data.R")
pilot <- study1; rm(study1,  prep_study1)

source("BLM-protest_study2_prepare-data.R")
study1 <- study2; rm(study2, prep_study2)

source("BLM-protest_study3_prepare-data.R")
study2 <- study3; rm(study3, prep_study3)


# Add video condition to Pilot----
pilot$df$condition <- "BLM"

# Recode political affiliation into two factors ----

## Pilot ----
pilot$df <- pilot$df %>%
  
  mutate(parties = factor(
    # 1 -- factor with all affiliation options
    ifelse(is.na(pol_parties), "NA", pol_parties),
    levels = c("1", "2", "3", "4", "0", "5"),
    labels = c(
      "Republican",
      "Democrat",
      "Green",
      "Libertarian",
      "Independent",
      "Other"
    )
  )) %>%
  mutate(
    major_parties = dplyr::recode_factor(
      # 2 -- factor with only major affiliations
      parties,
      "Republican" = "Republican",
      "Democrat" = "Democrat",
      "Green" = NULL,
      "Libertarian" = NULL,
      "Independent" = "Independent",
      "Other" = NULL,
      .missing = NULL
    )
  ) 

## Study 1 ----
study1$df <- study1$df %>%
  mutate(parties = factor(
    # 1 -- factor with all affiliation options
    ifelse(is.na(political_party), "NA", political_party),
    levels = c("1", "2", "3", "4", "0", "5"),
    labels = c(
      "Republican",
      "Democrat",
      "Green",
      "Libertarian",
      "Independent",
      "Other"
    )
  )) %>%
  mutate(
    major_parties = dplyr::recode_factor(
      # 2 -- factor with only major affiliations
      parties,
      "Republican" = "Republican",
      "Democrat" = "Democrat",
      "Green" = NULL,
      "Libertarian" = NULL,
      "Independent" = "Independent",
      "Other" = NULL,
      .missing = NULL
    )
  )

## Study 2 ----
study2$df <- study2$df %>%
## political party
## recode political affiliation into factors

  mutate(parties = factor(
    ifelse(is.na(political_party), "NA", political_party),
    levels = c("1", "2", "3", "4", "0", "5"),
    labels = c(
      "Republican",
      "Democrat",
      "Green",
      "Libertarian",
      "Independent",
      "Other"
    )
  )) %>%
  mutate(
    major_parties = dplyr::recode_factor(
      parties,
      "Republican" = "Republican",
      "Democrat" = "Democrat",
      "Green" = NULL,
      "Libertarian" = NULL,
      "Independent" = "Independent",
      "Other" = NULL,
      .missing = NULL
    )
  )



# Recode some other demographic factors ----

## Study 1 ----

study1$df <- study1$df %>%
  
  # ethnicity
  mutate(ethnicity_factor = factor(race)) %>% #recode ethnicity into factor
  mutate(
    # create binary ethnicity factor
    ethnicity_binary = dplyr::recode_factor(
      ethnicity_factor,
      "7" = "white",
      .default = "non-white",
      .missing = NULL
    )
  ) %>%
  
  # education
  mutate(education_factor = factor(education)) %>% # create factor
  mutate(
    # create binned factor
    education_bins = dplyr::recode_factor(
      education_factor,
      "1" = "hs_less",
      "2" = "hs_less",
      "3" = "some_college",
      "4" = "associates",
      "5" = "bachelors",
      "6" = "advanced",
      "7" = "advanced",
      "8" = "advanced",
      .missing = NULL
    )
  ) %>%
  
  # gender
  mutate(gender_factor = factor(
    # create gender factor
    gender,
    levels = c("1", "2", "3", "4", "0"),
    labels = c(
      "female",
      "male",
      "gender nonconforming",
      "other",
      "prefer not to say"
    )
  )) %>%
  mutate(
    # gender factor with two levels only
    gender_two_factor = dplyr::recode_factor(
      gender_factor,
      "female" = "female",
      "male" = "male",
      "other" = NULL,
      "gender nonconforming" = NULL,
      "prefer not to say" = NULL,
      .missing = NULL
    )
  )

## Study 2 ----
study2$df <- study2$df %>%
## ethnicity

mutate(ethnicity_factor = factor(race)) %>% #recode ethnicity into factor
  mutate(                                     # create binary ethnicity factor
    ethnicity_binary = dplyr::recode_factor(
      ethnicity_factor,
      "7" = "white",
      .default = "non-white",
      .missing = NULL
    )
  ) %>%
  
  ## education
  
  mutate(education_factor = factor(education)) %>% # create factor
  mutate(                                          # create binned factor
    education_bins = dplyr::recode_factor(
      education_factor,
      "1" = "hs_less",
      "2" = "hs_less",
      "3" = "some_college",
      "4" = "associates",
      "5" = "bachelors",
      "6" = "advanced",
      "7" = "advanced",
      "8" = "advanced",
      .missing = NULL
    )
  ) %>%
  
  ## gender
  
  mutate(gender_factor = factor(# create gender factor
    gender,
    levels = c("1", "2", "3", "4", "0"),
    labels = c(
      "female",
      "male",
      "gender nonconforming",
      "other",
      "prefer not to say"
    )
  )) %>% 
  mutate( # gender factor with two levels only
    gender_two_factor = dplyr::recode_factor(
      gender_factor,
      "female" = "female",
      "male" = "male",
      "other" = NULL,
      "gender nonconforming" = NULL,
      "prefer not to say" = NULL,
      .missing = NULL
    )
  )


