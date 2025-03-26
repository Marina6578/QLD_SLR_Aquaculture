This repository is part of a publication named "Queensland’s coastal terrestrial aquaculture at risk from sea level rise by 2100" 

Authors: Christofidis, Marina;  Lyons, Mitchell B.;  Kuempel, Caitlin D.

We here post the codes used to assess the exposure of Queensland’s coastal terrestrial aquaculture industry to SLR.
We use existing datasets on coastal inundation and erosion from sea level rise combined with novel data on current and future aquaculture
location and production estimates to identify hot spots of risk and to estimate potential economic losses considering a Representative 
Concentration Pathway (RCP) 8.5 for year 2100.

Data on aquaculture locations was received from Fisheries Queensland, a service of the Department of Agriculture, Fisheries (DAF)
and cannot be provided to a third party unless approved by Fisheries Queensland. Therefore always in the code when it comes to datasets about leases or species
it can be substituted by other datasets in a new area of interest. Otherwise DAF can handle and chose to provide the same datasets. https://www.daf.qld.gov.au/

The steps will be descrobed here pointing towards the script /code used
CODES

Checking the exposure of the aquaculture leases of our final dataframe to SLR layer obtained from the Queensland Government- 
this considers the whole land leased for aquaculture purposes and figure 2 A, B and C are outputs of this code:
ImpactSLR_Erosion_over_aquaculture_allcomponents_RESULTSv3.1.Rmd

SLR Impact and Erosion over each Aquaculture development areas (ADAs) - ADA location can be ordered from DAF https://www.daf.qld.gov.au/
Figure 5 A and B are output of this code.
ADA_results_exposurev3.0.Rmd

Filtering species by lease - This only makes sense once you have an aquaculture dataset to subset from, but here is the model we used
Script_species_by_farm_authorithy_august.Rmd

HERE WE RAN THE GOOGLE EARTH ENGINE CODES TO FIND OPEN WATER SOURCES WITHIN LEASES WE KNEW ABOUT 
Google Earth Engine (GEE) code for water detection: https://code.earthengine.google.com/752cf7131156779d4a50624068816963
Google Earth engine (GEE) code to use thresholds and to export pond vectors: https://code.earthengine.google.com/2125793fa720d92d7b27ee0552d30826

In case you dont export the vector of GOOGLE EARTH ENGINE you will need to transform the rasters (tif) into polygons as in this code: 
Terra_raster_to_polygons_GEE_LOOP

When you have the NDWI 20th percentile, NDWI 80th percentile and also the NDWI sum you can stick all of them as seen here:
Code_Stick_files_GEE_Output.Rmd

Once you know where the ponds are, the fun begins! You can check the exposure of SLR over those ponds 
that are productive or had water in that timeframe you detected using GEE
Figure 3 A and B derive from this code
Ponds_in_leases_erosion_and_histograms_version_3.0.Rmd

This code was used to know where in prawn and barramundi productions were the areas that had 
high production and high risk. Figure 4 is an output
Bivariate_map_v3.0.Rmd





