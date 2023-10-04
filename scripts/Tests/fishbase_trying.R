#trying fishbase

install.packages ("rfishbase")
library(rfishbase)
library(tidyverse)
istall.packages("tidyverse")

Sys.setenv(FISHBASE_VERSION="17.07")

library(here)

 #load the aquaculture species list I have done

aquaculture_organisms_list<-read_csv(here("raw_data/Aquaculture_organisms.csv"))
aquaculture_organisms_list<-st_read(here("raw_data/Aquaculture_organisms.csv"))           
