# ep 6

library(tidyverse) # wrangle, reshape and visualize data
library(sf) # work with spatial vector data

# this is the data on the setup page
# https://data.4tu.nl/file/fb0b4e31-f7e4-43e6-9e30-a2a08b184d09/9489ddc3-eab7-4114-a4ff-414db7da0605

# comment for the lesson: this doesn't use here()
boundary_Delft <- st_read("scripts/data/delft-boundary.shp", quiet = TRUE)

st_read("scripts/data/delft-boundary.shp")

# the base R is not very useful
str(boundary_Delft)

# so let's interrogate:
st_geometry_type(boundary_Delft)
st_crs(boundary_Delft)
st_crs(boundary_Delft)$Name
st_crs(boundary_Delft)$epsg
# these are lat-long
st_bbox(boundary_Delft)

# st_transform to get a more conformal
# shape for the Dutch
# note: we are recycling the object.
boundary_Delft <- st_transform(boundary_Delft, crs = 28992)
st_crs(boundary_Delft)$Name

st_crs(boundary_Delft)$epsg

# the units of the bounding box get changed along the way:
st_bbox(boundary_Delft)

st_crs(boundary_Delft)$units_gdal
boundary_Delft

# now let's plot!!!
ggplot(data = boundary_Delft) +
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  labs(title = "Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992)) # displays the axes in meters

lines_Delft <- st_read("scripts/data/delft-streets.shp")
points_Delft <- st_read("scripts/data/delft-leisure.shp")

# ggtitle() should work too
ggplot(data = boundary_Delft) +
  geom_sf(size = 3, color = "black", fill = "cyan1") +
  ggtitle("Delft Administrative Boundary") +
  coord_sf(datum = st_crs(28992)) # displays the axes in meters


# final commands review metadata.
