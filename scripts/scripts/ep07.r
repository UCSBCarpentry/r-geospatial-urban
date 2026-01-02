# Explore and plot by vector layer attributes

# these are the 3 objects from the last episode

lines_Delft <- st_read("scripts/data/delft-streets.shp")
points_Delft <- st_read("scripts/data/delft-leisure.shp")

# will we need to re-re-project this?
boundary_Delft <- st_read("scripts/data/delft-boundary.shp", quiet = TRUE)

ncol(lines_Delft)
names(lines_Delft)
head(lines_Delft)

str(lines_Delft)

head(lines_Delft$highway, 10)
unique(lines_Delft$highway)

# let's turn highways into a factor
# so we don't accidentally introduce a new road type
# this will also arrange things well for later
factor(lines_Delft$highway) |> levels()

# but that's not sticky
str(lines_Delft)
lines_Delft$highway <-factor(lines_Delft$highway)

str(lines_Delft)

# challenge: look at points attributes:
# 1 How many fields does it have?
# 2 What types of leisure points do the points represent? Give three examples.
# 3 Which of the following is NOT a field of the point_Delft object?
#     A) location B) leisure C) osm_id

ncol(points_Delft)
# 3

names(points_Delft)
unique(points_Delft$leisure)
# firepit, marina, escape_game!!

# subsetting features

# just the cycleways
cycleway_Delft <- lines_Delft |>
  filter(highway == "cycleway")

# compare the counts
nrow(lines_Delft)
nrow(cycleway_Delft)

# what's the total length of bikeways in Delft?
cycleway_Delft <- cycleway_Delft |>
  mutate(length = st_length(geometry))

cycleway_Delft |>
  summarise(total_length = sum(length))

# 115 km
# that seems reasonable for a little Dutch city
ggplot(data = cycleway_Delft) +
  geom_sf() +
  labs(
    title = "Slow mobility network in Delft",
    subtitle = "Cycleways"
  ) +
  coord_sf(datum = st_crs(28992))

# Challenge: now do roads
# Create a new object that only contains the motorways in Delft.
# 1   How many features does the new object have?
# 2   What is the total length of motorways?
# 3   Plot the motorways

# just the roads
unique(lines_Delft$highway)

motorway_Delft <- lines_Delft |>
  filter(highway == "motorway")

# compare the counts
nrow(lines_Delft)
nrow(motorway_Delft)

# what's the total length of motorways in Delft?
motorway_Delft <- motorway_Delft |>
  mutate(length = st_length(geometry))

motorway_Delft |>
  summarise(total_length = sum(length))

# 14 km
# the Dutch like their bikes!

# but not that much
ggplot(data = motorway_Delft) +
  geom_sf() +
  labs(
    title = "Fast mobility network in Delft",
    subtitle = "Motorways"
  ) +
  coord_sf(datum = st_crs(28992))

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
  ) +
  coord_sf(datum = st_crs(28992))


# challenge: adjust line width
#
# Follow the same steps to add custom line widths
# for every road type.
# (ie: our subset of 4)

# Assign the custom values 1, 0.75, 0.5, 0.25 in this order
# to an object called line_widths.
# These values will represent line thicknesses that are
# consistent with the hierarchy of the selected road types.

# In this case the linewidth argument, like the color argument
# above, should be within the aes() mapping function and
# should take the values of the custom line widths.

# Plot the result, making sure that linewidth is named the same way
# as color in the legend.

line_widths <- c(1, 0.75, 0.5, 0.25)

str(lines_Delft_selection)
levels(lines_Delft_selection$highway)
# remember when we made it a factor?
# the arrangement works well for us.
# thick to thin.

ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway, linewidth = highway)) +
  scale_color_manual(values = road_colors) +
  scale_linewidth_manual(values = line_widths) +
  labs(
    color = "Road Type",
    linewidth = "Road Type",
    title = "Mobility Network of Delft",
    subtitle = "Main Roads & Cycleways"
  ) +
  coord_sf(datum = st_crs(28992))

# challenge: let's stress bikes
# oops--I did this with the subset
# the lesson wants all the highways

levels(lines_Delft_selection$highway)
bike_lines <- c(.25, 0.75, 0.5, 1)
bike_colors <- c("black", "black", "black", "purple")


ggplot(data = lines_Delft_selection) +
  geom_sf(aes(color = highway, linewidth = highway)) +
  scale_color_manual(values = bike_colors) +
  scale_linewidth_manual(values = bike_lines) +
  labs(
    color = "Road Type",
    linewidth = "Road Type",
    title = "Bike Mobility Network of Delft",
    subtitle = "Cycleways and other roads"
  ) +
  coord_sf(datum = st_crs(28992))
