# penultimate episode
# getting OSM data

library(tidyverse)
library(sf)
library(osmdata)

# magic line
assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

# let's get a bounding
bb <- osmdata::getbb("Isla Vista, California")
bb

bb_wh <- osmdata::getbb("Wuhan")
bb_wh

# get data inside our bounding box
# opq
x <- opq(bbox = bb) |>
  add_osm_feature(key ="building") |>
  osmdata_sf()

str(x)
str(x$osm_polygons)

buildings <- x$osm_polygons

start_date <- as.numeric(buildings$start_date)
start_date
summary(start_date)
length(start_date)


# highlight anything older than 1900.
buildings$build_date <- if_else(start_date < 1900, 1900, start_date)

ggplot(data=buildings) +
  geom_sf()

ggplot(data=buildings) +
  geom_sf(aes(fill = build_date, colour = build_date)) +
  scale_fill_viridis_c(option = "viridis") +
  scale_color_viridis_c(option = "viridis")

