# the last day!

# ep 13

# Canopy Height Models
# DTM = Terrain = Bare Earth
# DSM = Surface = COVERED Earth = First return = tree/building tops

# CHM = DSM - DTM

library(terra)
library(ggplot2)
library(dplyr)

describe("scripts/data/tud-dtm-5m.tif")
describe("scripts/data/tud-dsm-5m.tif")

DTM_TUD <- rast("scripts/data/tud-dtm-5m.tif")
DSM_TUD <- rast("scripts/data/tud-dsm-5m.tif")

# test the projections
crs(DTM_TUD) == crs(DSM_TUD)

# convert to data frame
DTM_TUD_df <- as.data.frame(DTM_TUD, xy=TRUE)
DSM_TUD_df <- as.data.frame(DSM_TUD, xy=TRUE)

# plot them out
ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(x=x, y=y, fill=`tud-dtm-5m`)) +
  scale_fill_gradientn(colors = terrain.colors(10)) +
  coord_equal()

ggplot() +
  geom_raster(
    data = DSM_TUD_df,
    aes(x=x, y=y, fill=`tud-dsm-5m`)) +
  scale_fill_gradientn(name="DSM: treepops", colors = terrain.colors(10)) +
  coord_equal()

summary(DTM_TUD_df$`tud-dtm-5m`)
unique(DTM_TUD_df$`tud-dtm-5m`)


# the math
CHM_TUD <- DSM_TUD - DTM_TUD
CHM_TUD_df <- as.data.frame(CHM_TUD, xy=TRUE)


CHM_TUD_df <- DSM_TUD_df - DTM_TUD_df
str(CHM_TUD_df)

# rename(A = a, B = b)
#CHM_TUD_df <- CHM_TUD_df  %>%
#  rename(`tud-chm` = `tud-dsm-5m` )


ggplot() +
  geom_raster(
    data = CHM_TUD_df,
    aes(x = x, y = y, fill = `tud-dsm-5m`)) +
  scale_fill_gradientn(name = "Canopy/Building Height", colors = terrain.colors(10)) +
  # attaching a name to the fill puts that name in the legend.
  coord_equal()

summary(CHM_TUD_df)

ggplot() +
  geom_raster(
    data = CHM_TUD_df,
    aes(x=x, y=y, fill=`tud-chm`)) +
  scale_fill_gradientn(name="CHM: ", colors = terrain.colors(10)) +
  coord_equal()

# saving geotiffs

writeRaster(CHM_TUD, "scripts/data_output/CHM_TUD.tiff",
            filetype = "GTiff",
            overwrite = TRUE)


