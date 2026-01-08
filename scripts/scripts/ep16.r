# episode 16: the final analysis
#
# Unions, joins, and intersections
# Creating buffers
# Finding the middle
# Computing areas


library(tidyverse)
  # for ggplot and dplyr etc etc

library(sf)
  # for spatial objects
  # older than, and lots of overlap with, terra

library(osmdata)
  # for downloading data from Open Street Map
  # via the Interwebs

# new
library(leaflet)
  # for base slippy maps

# new
library(lwgeom)

# new?
library(units)

assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))


# very similar to episode 15. Let's
# find old buildings in Brielle

bb <- osmdata::getbb("Brielle, NL")
# bb <- osmdata::getbb("Middelburg, NL")

x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()

buildings <- x$osm_polygons |>
  st_transform(crs = 28992)

# this needs to be a number
summary(buildings$start_date)

# lesson note: the narrative swaps these 2 lines. I like it better this way
buildings$start_date <- as.numeric(buildings$start_date)

# these results could have helped us with our ad-hoc challenge
summary(buildings$start_date)

# context
ggplot(data = buildings) +
  geom_sf() +
  coord_sf(datum = st_crs(28992))


old <- 1800 # year prior to which you consider a building old

old_buildings <- buildings |>
  filter(start_date <= old)

ggplot(data = old_buildings) +
  geom_sf(colour = "red") +
  coord_sf(datum = st_crs(28992))



# let's make a 100m BUFFER around our old buildings
distance <- 100 # in meters

# First, we check that the "old_buildings" layer projection is measured
# in meters:
st_crs(old_buildings)

# then we use `st_buffer()`
buffer_old_buildings <-
  st_buffer(x = old_buildings, dist = distance)

# so much info!!!
str(buffer_old_buildings)
length(buffer_old_buildings)

ggplot(data = buffer_old_buildings) +
  geom_sf() +
  coord_sf(datum = st_crs(28992))

# union
# let's make districts instead of having all
# 63 of these polygons
single_old_buffer <- st_union(buffer_old_buildings) |>
  st_cast(to = "POLYGON") |>
   # as a polygon doesn't do all the work, so you also need:
    st_as_sf()

single_old_buffer <- single_old_buffer |>
  mutate("ID" = as.factor(seq_len(nrow(single_old_buffer)))) |>
  st_transform(crs = 28992)


ggplot(data = single_old_buffer) +
  geom_sf() +
  coord_sf(datum = st_crs(28992))

# s2
#
# works with geographic projections onto a sphere,
# so to calculate centroids in a planar projection
# we need to disable it.
sf::sf_use_s2(FALSE)

centroids_old <- st_centroid(old_buildings) |>
  st_transform(crs = 28992)

nrow(single_old_buffer)
ggplot() +
  geom_sf(data = single_old_buffer, aes(fill = ID)) +
  geom_sf(data = centroids_old, size=.1) +
  coord_sf(datum = st_crs(28992))


# Intersect and Join

centroids_buffers <-
  st_intersection(centroids_old, single_old_buffer) |>
  mutate(n = 1)

centroid_by_buffer <- centroids_buffers |>
  group_by(ID) |>
  summarise(n_buildings = n())

single_buffer <- single_old_buffer |>
  st_join(centroid_by_buffer, left = TRUE)

# there is all sorts of ggplot kung fu
# we didn't cover here

ggplot() +
  geom_sf(data = single_buffer, aes(fill = n_buildings)) +
  scale_fill_viridis_c(
    alpha = 0.8,
    begin = 0.6,
    end = 1,
    direction = -1,
    option = "B"
  ) +
  coord_sf(datum = st_crs(28992))

# add the building footprints back in:
ggplot() +
  geom_sf(data = buildings) +
  geom_sf(data = single_buffer, aes(fill = n_buildings), colour = NA) +
  scale_fill_viridis_c(
    alpha = 0.6,
    begin = 0.6,
    end = 1,
    direction = -1,
    option = "B"
  )
