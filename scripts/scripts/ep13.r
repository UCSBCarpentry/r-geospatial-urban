# episode 13: raster calculations
# let's make a canopy height model

library(terra)
library(ggplot2)
describe("scripts/data/tud-dtm-5m.tif")
describe("scripts/data/tud-dsm-5m.tif")

DTM_TUD <- rast("scripts/data/tud-dtm-5m.tif")
DSM_TUD <- rast("scripts/data/tud-dsm-5m.tif")

crs(DTM_TUD) == crs(DSM_TUD)
# they match

