

library(tidyverse)
library(here)

subset_australia_DEM<-st_read(here(Practice_aquaculture/raw_data?)
df %>%
  filter(latitude > -50 & latitude < -6 & longitude > 110 & longitude < 155)