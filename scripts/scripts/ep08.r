# episode 8 of Dutch urbanism carpentry
# Plot Multiple Shapefiles

# same 3 objects
lines_Delft <- st_read("scripts/data/delft-streets.shp")
points_Delft <- st_read("scripts/data/delft-leisure.shp")
boundary_Delft <- st_read("scripts/data/delft-boundary.shp")

# these 3 come from ep. 7
road_types <- c("motorway", "primary", "secondary", "cycleway")
road_colors <- c("blue", "green", "navy", "purple")


lines_Delft_selection <- lines_Delft |>
  filter(highway %in% road_types) |>
  mutate(highway = factor(highway, levels = road_types))









ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(data = points_Delft) +
  labs(title = "Mobility network of Delft")
###### there's a typo in the legend here. it's points_Delft




points_Delft$leisure <- factor(points_Delft$leisure)
# typo again
levels(points_Delft$leisure) |> length()
leisure_colors <- rainbow(15)

ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(
    data = points_Delft,
    aes(fill = leisure), # add the aes.
    shape = 21
  ) +
  scale_color_manual(
    values = road_colors,
    name = "Road Type"
  ) +
  scale_fill_manual(
    values = leisure_colors,
    name = "Leisure Location"
    ### typo here -- Lesiure
  ) +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))



# challenge: make those points squares
ggplot() +
  geom_sf(
    data = boundary_Delft,
    fill = "lightgrey",
    color = "lightgrey"
  ) +
  geom_sf(
    data = lines_Delft_selection,
    aes(color = highway),
    size = 1
  ) +
  geom_sf(
### have we settled on points yet?
        data = points_Delft,
    aes(fill = leisure),
    shape = 18
  ) +
  scale_color_manual(
    values = road_colors,
    name = "Line Type"
  ) +
  scale_fill_manual(
    values = leisure_colors,
    name = "Leisure Location"
  ) +
  labs(title = "Mobility network and leisure in Delft") +
  coord_sf(datum = st_crs(28992))


# Challenge
# filter to places to stop your bike ride to play and eat

#leisure_locations_selection <- st_read("data/delft-leisure.shp") |>
#  filter(leisure %in% c("playground", "picnic_table"))

leisure_locations_selection <- points_Delft |>
  filter(leisure %in% c("playground", "picnic_table"))


factor(leisure_locations_selection$leisure) |> levels()
blue_orange <- c("cornflowerblue", "darkorange")
ggplot() +
  geom_sf(data = lines_Delft_selection,
    aes(color = highway)) +
  geom_sf(data = leisure_locations_selection,
    aes(fill = leisure, shape = leisure)) +
  scale_shape_manual(name = "Leisure Type",
    values = c(21, 22)) +
  scale_color_manual(name = "Line Type",
    values = road_colors) +
  scale_fill_manual(name = "Leisure Type",
    values = blue_orange) +
  labs(title = "Road network and leisure") +
  coord_sf(datum = st_crs(28992))

# I know nothing of Delft. I bet there's a canal.

# Arie saves shapefile of tables and playgrounds.
st_write(leisure_locations_selection,
         "scripts/data_output/leisure_location_selection.shp",
         driver="ESRI Shapefile")
