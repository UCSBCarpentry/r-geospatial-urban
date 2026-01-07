# episode 6
# plot shapefiles

library(sf)
library(ggplot2)
library(tidyverse)

boundary_Delft <- st_read("scripts/data/delft-boundary.shp")
str(boundary_Delft)

st_geometry(boundary_Delft)
st_crs(boundary_Delft)
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$EPSG
st_bbox(boundary_Delft)

ggplot(data=boundary_Delft) +
  geom_sf(size=3, color = "black", fill = "cyan1") +
  labs(title="Delft Boundary") +
  coord_sf(datum = st_crs(28992))
