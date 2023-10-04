#combining both datasets DAF and non DAF lists 


install.packages("sf")

library(tidyverse)
library(here)
library(tmap)
library(sf)
library(ggplot2)
library(dplyr)

qld_leases_DAF<-st_read(here("raw_data/QLD_aqua/Current_land_based_marine_distances.shp"))
qld_aqua_out_of_lease<-st_read(here("raw_data/terrestrial_aquaculture_qld_out_of_lease/terrestrial_aquaculture_qld_out_of_lease.shp"))
qld_leases<-st_read(here("raw_data/QLD_aqua_ground_truth/QLD_terr_aquaculture_ground_truth.shp"))
qld_leases_DAF_add<-st_read(here("raw_data/QLD_leases_DAF/DAF_LEASES_TO_ADD/daf_leases_to_add.shp"))
qld_out_of_DAF_add<-st_read(here("raw_data/terrestrial_aquaculture_qld_out_of_lease/OUT_of_DAF_add/out_of_DAF_add.shp"))

qld_leases_reproj<-st_transform(qld_leases, 3577)
qld_leases_reproj <- qld_leases_reproj %>%
  mutate(lease_area_m2 = st_area(.))

qld_leases_reproj_out<-st_transform(qld_aqua_out_of_lease, 3577)
qld_leases_reproj_out <- qld_leases_reproj_out %>%
  mutate(lease_area_m2 = st_area(.))

qld_leases_DAF_reproj<-st_transform(qld_leases_DAF, 3577)
qld_leases_DAF_reproj <- qld_leases_DAF_reproj %>%
  mutate(lease_area_m2 = st_area(.))

qld_leases_DAF_add_reproj<-st_transform(qld_leases_DAF_add, 3577)
qld_leases_DAF_add_reproj <- qld_leases_DAF_add_reproj %>%
  mutate(lease_area_m2 = st_area(.))

qld_out_of_DAF_add_reproj<-st_transform(qld_out_of_DAF_add, 3577)
qld_out_of_DAF_add_reproj <- qld_out_of_DAF_add_reproj %>%
  mutate(lease_area_m2 = st_area(.))

qld_leases_DAF_add_reproj<-qld_leases_DAF_add_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_leases_DAF_reproj<-qld_leases_DAF_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_out_of_DAF_add_reproj<-qld_out_of_DAF_add_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_leases_reproj_out<-qld_leases_reproj_out %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

DAF_qldGlobe <-bind_rows(qld_leases_DAF_add_reproj, qld_leases_DAF_reproj)
DAF_qldGlobe<-DAF_qldGlobe%>%
  group_by(qldglb_)
  
nonDAF_qldGlobe<-bind_rows(qld_leases_reproj_out, qld_out_of_DAF_add_reproj)
nonDAF_qldGlobe<-nonDAF_qldGlobe %>%
  group_by(qldglb_)

DAF_qldGlobe <-DAF_qldGlobe %>%
  mutate(origin = "DAF")

nonDAF_qldGlobe<-nonDAF_qldGlobe %>%
  mutate(origin = "GT")

QLD_Aquaculture<- bind_rows(DAF_qldGlobe, nonDAF_qldGlobe)


QLD_Aquaculture_no_duplicates<-QLD_Aquaculture %>%
      group_by(qldglb_) %>%
      summarise()

  View(QLD_Aquaculture_no_duplicates)

  


#combined_shapefile <- rbind(shapefile1, shapefile2)

#this showed a problem because both data frames were different, to gather them i can do this, but anyways it didnt realize that many were the same.
#qld_all_leases<- bind_rows(qld_leases_reproj, qld_leases_reproj_out)

