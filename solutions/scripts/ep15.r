# episode 15
# importing OSM data
# we were literally doing this in the office before the holidays
#    via a web page

library(tidyverse)
library(sf)

# this helps the osm package's internet connection
# (curl) stay alive
assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))

library(osmdata)

# you need to trust the authors of the lesson
# and OSM that this is a reasonable bounding box
bb <- osmdata::getbb("Brielle")
bb

# let's do it with someplace with know:
bb_Wuhan <- osmdata::getbb("Wuhan")
bb_Wuhan

bb_SB <- osmdata::getbb("Santa Barbara, California")
bb_SB


# extract data from our Brielle extent
# opq comes from the osmdata library
# it's a query.
x <- opq(bbox = bb) |>
  add_osm_feature(key = "building") |>
  osmdata_sf()
# last line converts it to sf features

# let's peak at it
str(x)
str(x$osm_polygons)

# first we get it out of decimal degrees and into a native CRS:
# we can skip this for non-euro cities, but we will need
# meters for ep 16.
buildings <- x$osm_polygons |>
  st_transform(crs = 28992)

str(buildings)

# what would happen without 'as.numeric'?
start_date <- as.numeric(buildings$start_date)

# this makes everything before 1900 the same shade with the
# continuous scale
buildings$build_date <- if_else(start_date < 1900, 1900, start_date)

ggplot(data = buildings) +
  geom_sf(aes(fill = build_date, colour = build_date)) +
  # this is making the fill and the outline colored the same:
   scale_fill_viridis_c(option = "viridis") +
   scale_colour_viridis_c(option = "viridis") +
  coord_sf(datum = st_crs(28992))


# convert this to a function so that we can pass a city name
# and get out the same hued building layer
# we haven't covered functions a lot, but
# here's why they are useful.

extract_buildings <- function(cityname, year = 1800) {
  bb <- getbb(cityname)

  x <- opq(bbox = bb) |>
    add_osm_feature(key = "building") |>
    osmdata_sf()

  buildings <- x$osm_polygons |>
    st_transform(crs = 28992)

  start_date <- as.numeric(buildings$start_date)

  buildings$build_date <- if_else(start_date < year, year, start_date)


  ggplot(data = buildings) +
    geom_sf(aes(fill = build_date, colour = build_date)) +
    scale_fill_viridis_c(option = "viridis") +
    scale_colour_viridis_c(option = "viridis") +
    ggtitle(paste0("Old buildings in ", cityname)) +
    coord_sf(datum = st_crs(28992))
}

# test on Brielle
extract_buildings("Brielle, NL")

# test on .....
# crazy CRS
extract_buildings("Goleta, California")


# test on .....
extract_buildings("Krakow, Poland")

# Is this one faster?
# let's do it with a different date, and unprojected.
extract_buildings_2 <- function(cityname, year = 1800) {
  bb <- getbb(cityname)

  x <- opq(bbox = bb) |>
    add_osm_feature(key = "building") |>
    osmdata_sf()

  buildings <- x$osm_polygons

  start_date <- as.numeric(buildings$start_date)

  buildings$build_date <- if_else(start_date < year, year, start_date)
  ggplot(data = buildings) +
    geom_sf(aes(fill = build_date, colour = build_date)) +
    scale_fill_viridis_c(option = "viridis") +
    scale_colour_viridis_c(option = "viridis") +
    ggtitle(paste0("Old buildings in ", cityname))
}

# test on Brielle
extract_buildings_2("Brielle, NL")

# test on .....
# crazy CRS
extract_buildings_2("Goleta, California")

# too many NAs
extract_buildings_2("Vatican City")

# test on .....
extract_buildings_2("Krakow, Poland")

extract_buildings_2("Gent")

# 20 minute OSM challenge: would take a lot of reading.
# or ad hoc: edit the function to take city AND year.






# ##### Lesson solution:
# install.packages("leaflet")
library(leaflet)


buildings2 <- buildings |>
  st_transform(crs = 4326)

# leaflet(buildings2) |>
#  addTiles() |>
#   addPolygons(fillColor = ~colorQuantile("YlGnBu", -build_date)(-build_date))

# For a better visual rendering, try:

leaflet(buildings2) |>
  addProviderTiles(providers$CartoDB.Positron) |>
  addPolygons(
    color = "#444444",
    weight = 0.1,
    smoothFactor = 0.5,
    opacity = 0.2, fillOpacity = 0.8,
    fillColor = ~ colorQuantile("YlGnBu", -build_date)(-build_date),
    highlightOptions = highlightOptions(
      color = "white", weight = 2,
      bringToFront = TRUE
    )
  )

