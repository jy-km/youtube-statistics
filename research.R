library(tidyverse)
library(data.table)

# Set working directory - Use double backslashes or forward slashes
setwd("C:/Users/jaeyo/Downloads")

# Read all CSV files in the directory into one data frame
sports06222025 <- list.files(pattern = "\\.csv$") %>% 
  map_df(~fread(.))

# Add a new column with the extract date
sports06222025[, extractdate := "06222025"]