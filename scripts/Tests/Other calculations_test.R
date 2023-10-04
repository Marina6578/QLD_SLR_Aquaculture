

#otherTHINGS THAT NEED TO BE DONE 
#in my dataset (qld_leases_reproj) There are Leases that are in Hectares and others in square meters, so i need to inform that in R and then later put them in the same type 

#Calculate the total area of each lease that was affeted by the intersection using st_area function and adding a column with this information using mutate)
```{r}

```

# divide the intersection area by the lease area to get the proportion of the lease that may be impacted
```{r}
convert_m2_to_hectares<-function(square_meters)
  hectares<- square_meters / 10000
return(hectares)
```

#in my dataset (qld_leases-reproj) make all the areas be in hectares
```{r}
qld_leases_erosion_calc <- qld_leases_erosion %>%
  mutate(affectedArea = 
           
           convert_m2_to_hectares(metres sqr))
```
```{r}
qld_leases-reproj<-qld_leases_reproj %>%
  mutate(area_in_hectares = convert_m2_to_hectares(metres sqr))#didn't work check how its written
```

#Calculate the total area of each lease  (try looking into the st_area function and adding a column with this information using mutate)

```{r}

```


