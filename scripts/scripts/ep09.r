# episode 9 0f R for Urbanism

library(tidyverse)
library(sf)

municipal_boundary_NL <- st_read("scripts/data/nl-gemeenten.shp")


ggplot() +
  geom_sf(data = municipal_boundary_NL) +
  labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))

# add country boundary, lighten city boundaries
# there's little piece of narrative missing here
# the lesson doesn't mention the gray.
country_boundary_NL <- st_read("scripts/data/nl-boundary.shp")

ggplot() +
  geom_sf(data = municipal_boundary_NL, color="gray") +
  geom_sf(data = country_boundary_NL, fill = NA, color = "black", size = 2) +
    labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))

st_crs(municipal_boundary_NL)$epsg
st_crs(country_boundary_NL)$epsg
# both are 28992

# get the Delft file again
boundary_Delft <- st_read("scripts/data/delft-boundary.shp")
# you'll see when it reads in that it's wgs84
# that's got a different number:
st_crs(boundary_Delft)$epsg

# they plot together just fine.
ggplot() +
  geom_sf(
    data = country_boundary_NL,
    linewidth = 2,
    color = "gray18"
  ) +
  geom_sf(
    data = municipal_boundary_NL,
    color = "gray40"
  ) +
  geom_sf(
    data = boundary_Delft,
    color = "purple",
    fill = "purple"
  ) +
  labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))


# transforming it doesn't really speed up the plot.
# it's an old dog on my mac
boundary_Delft <- st_transform(boundary_Delft, 28992)

ggplot() +
  geom_sf(
    data = country_boundary_NL,
    linewidth = 2,
    color = "gray18"
  ) +
  geom_sf(
    data = municipal_boundary_NL,
    color = "gray40"
  ) +
  geom_sf(
    data = boundary_Delft,
    color = "purple",
    fill = "purple"
  ) +
  labs(title = "Map of Contiguous NL Municipal Boundaries") +
  coord_sf(datum = st_crs(28992))

# Challenge
# Challenge: Plot multiple layers of spatial data
# Create a map of South Holland as follows:

#  Import nl-gemeenten.shp and filter only the municipalities in South Holland.
# Plot it and adjust line width as necessary.
# Layer the boundary of Delft onto the plot.
# Add a title.


# Add a legend that shows both the municipal boundaries (as a line) and the boundary of Delft (as a filled polygon).

boundary_ZH <- municipal_boundary_NL
str(boundary_ZH)
# this will crap out if you don't have
boundary_ZH <-  filter(boundary_ZH, ligtInPr_1 == "Zuid-Holland")

ggplot() +
  geom_sf(
    data = boundary_ZH,
    aes(color = "color"),
    show.legend = "line"
  ) +
  scale_color_manual(
    name = "",
    labels = "Municipal Boundaries in South Holland",
    values = c("color" = "gray18")
  ) +
  geom_sf(
    data = boundary_Delft,
    aes(shape = "shape"),
    color = "purple",
    fill = "purple"
  ) +
  scale_shape_manual(
    name = "",
    labels = "Municipality of Delft",
    values = c("shape" = 19)
  ) +
  labs(title = "Delft location") +
  theme(legend.background = element_rect(color = NA)) +
  coord_sf(datum = st_crs(28992))


# last thing in the episode is saving a shapefile
# make sure to look at it in the OS to see the pieces.
# does this match the project organization from setup or ep 1?

st_write(leisure_locations_selection,
         "data/leisure_locations_selection.shp",
         driver = "ESRI Shapefile"
)

