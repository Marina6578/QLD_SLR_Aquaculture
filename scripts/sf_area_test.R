library(tidyverse)
library(here)
library(tmap)
library(sf)
library(ggplot2)
library(dplyr)

#load the data of my dataset shapefile 
qld_leases_erosion_data <- st_read(here("output_data/qld_leases_erosion.shp"))

#create a new column without data (all 0)

qld_leases_erosion_data <- qld_leases_erosion_data %>%
  mutate(Affected_Area = 0)

#selecting the column that would be used for calculating the affected area #Af
AfArea<-qld_leases_erosion_data$Affected_Area
polygonsAfArea<-qld_leases_erosion_data$geometry

#If I wanted to check the area of only one polygon i could use this but in this case I need a loop for all the values:
#AfArea[2]<-st_area(polygonsAfArea[2])

#creating a loop to calculate all the AfArea from the polygons (polygonsAfArea)
i=1
for (num in polygonsAfArea) {
  AfArea[i]<-st_area(num)
  i<-i+1
}
#introduce AfArea to the dataset we were using before (qld_leases_erosion_data)
qld_leases_erosion_data$Affected_Area <-AfArea


#save shapefile with area calculations (affectedArea) of the intersected bits
st_write(qld_leases_erosion_data, here("output_data/qld_leases_erosion_data.shp"), delete_layer = TRUE)

#load the data of both my datasets in shapefile 
qld_leases_erosion_data <- st_read(here("output_data/qld_leases_erosion.shp"))
qld_leases<-st_read(here("raw_data/QLD_aqua_ground_truth/QLD_terr_aquaculture_ground_truth.shp"))

#reproject data of the queensland leases (erosion data was done after reprojecting beforehand)

qld_leases_reproj<-st_transform(qld_leases, 3577)

#create new dataset for qld_leases_data to manipulate
qld_leases_data <-qld_leases_reproj

#create a new column without data (all 0)

qld_leases_data <- qld_leases_data %>%
  mutate(Area = 0)

#selecting the column that would be used for calculating the affected area #Af
OriginalArea<-qld_leases_data$Area
Originalpolygons<-qld_leases_data$geometry


#If I wanted to check the area of only one polygon i could use this but in this case I need a loop for all the values:
#AfArea[2]<-st_area(polygonsAfArea[2])

#creating a loop to calculate all the OriginalArea from the polygons (Originalpolygons)
i=1
for (num in Originalpolygons) {
  OriginalArea[i]<-st_area(num)
  i<-i+1
}
#introduce OriginalArea to the dataset we were using before (qld_leases_data)
qld_leases_data$Area <-OriginalArea

#save shapefile with area calculations (affectedArea) of the intersected bits
st_write(qld_leases_data, here("output_data/qld_leases_data.shp"), delete_layer = TRUE)

#set IDs for each lease to be the common thing between both datasets fro compariosn

IDs<-qld_leases_erosion_data$qldglb_
OriginalIDs<-qld_leases_data$qldglb_

#add another column to be the comparison of Areas as a percentage
qld_leases_data <- qld_leases_data %>%
  mutate(Percentage_Area = 0)

#loop for the comparison of Areas in original Lease and affected 
j=1
for (x in IDs) {
  index <- which(OriginalIDs == x)
  cat("Target value found at index", index, "\n")
  
  }





