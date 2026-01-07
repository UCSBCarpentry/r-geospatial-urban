# episode 13: raster calculations
# let's make a canopy height model
# (jon)

library(terra)
library(ggplot2)
library(dplyr)

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

summary(CHM_TUD_df)
# Min and max in here.

# the 'distribution' is the histogram (this feels like a red herring question
# to me.)


#  3. Plot the CHM_TUD raster using breaks that make sense
#       for the data.
#  Maybe we need to pause and talk about what 'makes sense'

# # lesson solution offers 'those < 0' which makes sense

custom_bins <- c(-5, 0, 10, 20, 30, 100)
CHM_TUD_df <- CHM_TUD_df |>
  mutate(canopy_discrete = cut(`tud-dsm-5m`, breaks = custom_bins))

ggplot() +
  geom_raster(data = CHM_TUD_df, aes(
    x = x,
    y = y,
    fill = canopy_discrete
  )) +
  scale_fill_manual(values = terrain.colors(5)) +
  coord_quickmap()


# exporting geotiffs
# very similar to shapefile
# but filetype instead of driver
# note for the authors: I think this shouldn't be fig/

writeRaster(CHM_TUD, "scripts/data_output/CHM_TUD.tiff",
            filetype = "GTiff",
            overwrite = TRUE)

# bonus challenge if there's time:
# adjust the color pallet so that < - 0 is watery blue.

