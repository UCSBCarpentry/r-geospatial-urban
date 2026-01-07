# episode 13: raster calculations
# let's make a canopy height model
# (jon)

library(terra)
library(ggplot2)
describe("scripts/data/tud-dtm-5m.tif")
describe("scripts/data/tud-dsm-5m.tif")

DTM_TUD <- rast("scripts/data/tud-dtm-5m.tif")
DSM_TUD <- rast("scripts/data/tud-dsm-5m.tif")

crs(DTM_TUD) == crs(DSM_TUD)
# they match so we don't have to worry about CRSs

DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)

# doing these ggplots here is as little gratuitous,
# since we need the original objects to do the math
ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(x = x, y = y, fill = `tud-dtm-5m`)) +
  scale_fill_gradientn(name = "Elevation: (DTM: bare earth)",
                       colors = terrain.colors(10)) +
  coord_equal()

ggplot() +
  geom_raster(
    data = DSM_TUD_df,
    aes(x = x, y = y, fill = `tud-dsm-5m`)) +
  scale_fill_gradientn(name = "Elevation: (DSM: first return)",
                       colors = terrain.colors(10)) +
  coord_equal()

# note the scales are different.

# the math statement is short and sweet:
CHM_TUD <- DSM_TUD - DTM_TUD
CHM_TUD_df <- as.data.frame(CHM_TUD, xy = TRUE)

ggplot() +
  geom_raster(
    data = CHM_TUD_df,
    aes(x = x, y = y, fill = `tud-dsm-5m`)
  ) +
  scale_fill_gradientn(name = "Canopy/Building Height", colors = terrain.colors(10)) +
  coord_equal()

# Holland is flat. And small towns are not tall
ggplot(CHM_TUD_df) +
  geom_histogram(aes(`tud-dsm-5m`))

# Challenge: Explore CHM Raster Values

# It is often a good idea to explore the range of values
# in a raster dataset just like we might explore a dataset
# that we collected in the field.

#  What is the minimum and maximum value
#   for the Canopy Height Model CHM_TUD that we just created?

#  What is the distribution of all the pixel values in the CHM?

#  Plot the CHM_TUD raster using breaks that make sense
#   for the data.
