# Custom functions for defining our scales

find_in_variable_name <- function(x, data = df){
  data %>%
    select(starts_with(x)) %>% 
    names() 
} # returns list of our variable names starting with character string x

find_x_and_y <- function(x,y, data = df){
  data %>% 
    select(starts_with(x)) %>%
    select(contains(y)) %>%
    names() 
} # returns list of our variable names starting with character string x and
# also containing y


# Note scale items requiring reverse-coding ----

# They're tagged with either "_R" or "_r_" in raw file,
# which is converted to snakecase upstream from here.

# In our workflow, we want to make a key, which is a list of lists,
# contain items names with a "-" sign in front of those needing reversal.

# These functions can alter the text accordingly-- automatically detect
# the reversal tags in the raw data, and convert them to what we need 
# in the key.

tag_Rr <- function(x){
  x[str_detect(x, "_r_" )] <- paste0("-", x[str_detect(x, "_r_" )]) # replace elements of x containing "_r_"
  # with the same text, preceded by a negative sign
  
  x[str_detect(x, "_r$" )] <- paste0("-", x[str_detect(x, "_r$" )])
  
  x
} 

