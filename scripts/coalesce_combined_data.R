#load packages I will need


library(tidyverse)
library(here)
library(tmap)
library(sf)
library(ggplot2)
library(dplyr)


qld_all_leases_no_duplicates<- qld_all_leases%>% 
  group_by(qldglb_)%>%
  summarise(geometry= st_union(geometry))%>%
  mutate(area_m2 = st_area(.))

View(qld_all_leases_no_duplicates)

st_write(qld_all_leases_no_duplicates, here("Practice_aquaculture/output_data/qld_all_leases_no_duplicates.shp"), delete_layer = TRUE)