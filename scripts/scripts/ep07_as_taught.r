# episode 7 as taught

lines_Delft <- st_read("scripts/data/delft-streets.shp")
points_Delft <- st_read("scripts/data/delft-leisure.shp")
boundary_Delft <- st_read("scripts/data/delft-boundary.shp")

nrow(points_Delft)

st_crs(lines_Delft) == st_crs(points_Delft)
st_crs(lines_Delft) == st_crs(boundary_Delft)

head(points_Delft)
unique(points_Delft$leisure)

factor(lines_Delft$highway) |> levels()
str(lines_Delft$highway)

lines_Delft_fct <- lines_Delft |>
  mutate(highway_fct = factor(highway))
str(lines_Delft_fct)

cycleways_Delft <- lines_Delft |>
  filter(highway == "cycleway")
nrow(cycleways_Delft)
nrow(lines_Delft)

str(cycleways_Delft)
cycleways_length <- cycleways_Delft |>
  mutate(length = st_length(geometry))
(cycleways_length)

cycleways_length |> summarise(total_length = sum(length))


# there's other kinds of streets
# let's choose 3, plus our bikepaths
road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft |>
  filter(highway %in% road_types) |>
  mutate(highway = factor(highway, levels = road_types))

road_colors <- c("blue", "green", "navy", "purple")

# I need an explainer for labs(color = )
ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway)) +
  scale_color_manual(values = road_colors) +
  labs(
    color = "Road Type",
    title = "Mobility Network of Delft",
    subtitle = "Main Roads & Cycleways"
  )
