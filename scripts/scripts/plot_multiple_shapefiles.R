# Episode 8: Plot multiple shapefiles

# Load the same three datasets from the previous episodes

# Outline of Delft (polygon)


# Motorways of Delft (lines)
lines_Delft <- st_read("scripts/data/delft-streets.shp")

# Locations of leisure activities (points)
road_types <- c("motorway", "primary", "secondary", "cycleway")

lines_Delft_selection <- lines_Delft |>
  filter(highway %in% road_types) |>
  mutate(highway = factor(highway, levels = road_types))
road_colors <- c("blue", "green", "navy", "purple")


# Let's plot all these layers together
ggplot()+
  geom_sf(data = boundary_Delft,
          fill = "lightgrey",
          color = "lightgrey")+
  geom_sf(data = lines_Delft_selection,
          aes(color = highway),
          size = 1)+
  geom_sf(data = points_Delft)


# Next, create custom legends for motorways and leisure activities
# fill versus color
# aes required to make a legend for that layer
head(points_Delft)
points_Delft$leisure <- factor(points_Delft$leisure)
str(points_Delft)

levels(points_Delft$leisure) |> length()

leisure_colors <- rainbow(15)

ggplot()+
  geom_sf(data = boundary_Delft,
          fill = "lightgrey",
          color = "lightgrey")+
  geom_sf(data = lines_Delft_selection,
          aes(color = highway),
          size = 1)+
  geom_sf(data = points_Delft,
          aes(fill = leisure),
          shape = 22)+
  scale_color_manual(values = road_colors, name = "Road Type")+
  scale_fill_manual(values = leisure_colors, name = "Leisure Location")


# Challenge: Customizing point shapes
# What value of shape will display the points as sqaures?
# Start to learn how to search the web for information OR using R help
# Modify your existing code above





# Take a look at this map. Focus on the playgrounds and picnic tables.
# What do you notice?



# Challenge: Visualizing filtered layers with a custom legend
# Create a map of leisure locations only including playground and picnic_table,
# with each point coloured by the leisure type.
# Overlay this layer on top of the lines_Delft layer (the streets).
# Tell R to plot playgrounds and picnic tables with different shape values.
# Make sure your plot has a custom legend.

# Tip: You can call scale_ functions multiple times for the same layer,
# for any of the aesthetics used in aes(). [colour, fill, shape]

# Copy paste your ggplot() code from above.

# Step 1: Filter leisure_locations_selection
leisure_location_selection <- points_Delft |>
  filter(leisure %in% c("playground", "picnic_table"))
unique(leisure_location_selection$leisure)

# Step 2: Create a new color vector with two elements
blue_orange <- c("cornflowerblue", "darkorange")

# Step 3: Update the ggplot code
ggplot()+
  geom_sf(data = boundary_Delft,
          fill = "lightgrey",
          color = "lightgrey")+
  geom_sf(data = lines_Delft_selection,
          aes(color = highway),
          size = 1)+
  geom_sf(data = leisure_location_selection,
          aes(fill = leisure, shape = leisure))+
  scale_color_manual(values = road_colors, name = "Road Type")+
  scale_fill_manual(values = blue_orange, name = "Leisure Location")+
  scale_shape_manual(values = c(21, 22), name = "Leisure Location")


# Export a shapefile
st_write(leisure_location_selection,
         "data_output/leisure_location_selection.shp",
         driver = "ESRI Shapefile")

# Episode 9: Handling spatial projections and CRS (coordinate reference system)
# Learn how to plot vector data with different CRS in the same plot

# Load the municipal boundaries from NL

# Plot this dataset


# Add an additional outline of the country that is darker and thicker for emphasis
# Load country outline and plot


# Extract metadata from the two shapefiles. Are they the same CRS?


# Let's go back to Delft. We might need to re-load it. What is the CRS?

# Let's see what happens if we try to plot Delft onto our existing map of NL.
# Do we think it will work? Green/Red sticky



# Now lets transform this data to match the CRS of the NL boundaries


# Challenge: Plot multiple layers of spatial data

# Create a map of South Holland as follows:
# Import nl-gemeenten.shp and filter only the municipalities in South Holland.
# Plot it and adjust line width as necessary.
# Layer the boundary of Delft onto the plot.
# Add a title.
# Add a legend that shows both the municipal boundaries (as a line)
# and the boundary of Delft (as a filled polygon).

# This challenge is a little tricky. Take a look at nl-gemeenten, we will see
# it is not in English.
# Hint: Start with head(municipal_boundary_NL)
# Hint 2: To have a legend item, you need an aes().
# Hint 3: Use the web for help. This is often the case when coding.


### Full solution

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

