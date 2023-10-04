#Preparation of the shapefiles of all QLD terrestrial Aquaculture

install.packages("sf")

library(tidyverse)
library(here)
library(tmap)
library(sf)
library(ggplot2)
library(dplyr)


#uploading the data needed
qld_leases<-st_read(here("raw_data/QLD_aqua_ground_truth/QLD_terr_aquaculture_ground_truth.shp"))
qld_leases_DAF_add<-st_read(here("raw_data/QLD_leases_DAF/DAF_LEASES_TO_ADD/daf_leases_to_add.shp"))
qld_aqua_out_of_lease<-st_read(here("raw_data/terrestrial_aquaculture_qld_out_of_lease/terrestrial_aquaculture_qld_out_of_lease.shp"))
qld_out_of_DAF_add<-st_read(here("raw_data/terrestrial_aquaculture_qld_out_of_lease/OUT_of_DAF_add/out_of_DAF_add.shp"))

#reprojecting all the data to the same coordinate reference system (CRS) (Australian Albers= EPSG 3577)

qld_leases_reproj<-st_transform(qld_leases, 3577)
qld_leases_DAF_add_reproj<-st_transform(qld_leases_DAF_add, 3577)
qld_leases_reproj_out<-st_transform(qld_aqua_out_of_lease, 3577)
qld_out_of_DAF_add_reproj<-st_transform(qld_out_of_DAF_add, 3577)


#Preparing all shapefiles/ dataframes to be able to stick them together

qld_leases_reproj<-qld_leases_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_leases_DAF_add_reproj<-qld_leases_DAF_add_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_leases_reproj_out<-qld_leases_reproj_out %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

qld_out_of_DAF_add_reproj<-qld_out_of_DAF_add_reproj %>%
  dplyr::select(qldglobe_p, Area, Perimeter, geometry) %>%
  rename(qldglb_ = qldglobe_p,
         Perimtr = Perimeter)

#stick bot shp of DAF leases together
DAF_qldGlobe <-bind_rows(qld_leases_DAF_add_reproj, qld_leases_reproj)
DAF_qldGlobe<-DAF_qldGlobe%>%
  group_by(qldglb_)

#stick both shp of other areas the GT spotted together
nonDAF_qldGlobe<-bind_rows(qld_leases_reproj_out, qld_out_of_DAF_add_reproj)
nonDAF_qldGlobe<-nonDAF_qldGlobe %>%
  group_by(qldglb_)

#creating "origin" column 

DAF_qldGlobe <-DAF_qldGlobe %>%
  mutate(origin = "DAF")

nonDAF_qldGlobe<-nonDAF_qldGlobe %>%
  mutate(origin = "GT")

#add both shapefiles for all aquaculture sites in QLD 

QLD_Aquaculture<- bind_rows(DAF_qldGlobe, nonDAF_qldGlobe)

#getting rid of duplicates (but lost added columns and I dont like this -so I am trying new things)
QLD_Aquaculture_farm<-QLD_Aquaculture%>%
  group_by(qldglb_)%>%
  subset(QLD_Aquaculture, subset, 
         select(., Aqcltr_n, Aqcltr_d,Ls_vrlp,State, Type, Notes, Yr_frst, Yer_lst,N_pnds_,Lts_ddd, geometry, origin))


  #trying to keep this columns but couldnt 
  dplyr:::select(Aqcltr_n, Aqcltr_d,Ls_vrlp,State, Type, Notes, Yr_frst, Yer_lst,N_pnds_,Lts_ddd, geometry, origin)%>%
   #or 
   #QLD_Aquaculture_no_duplicates<-QLD_Aquaculture%>%
   # group_by(qldglb_)%>%
    #summarise()

#calculate lease area with the geometry for each shp before we start the intersection part
QLD_Aquaculture_no_duplicates<-QLD_Aquaculture_no_duplicates%>%
  mutate(lease_area_m2 = st_area(.))

