# episode 10
# moving on to Rasters

library(tidyverse)
library(terra)

getwd()

describe("scripts/data/tud-dsm-5m.tif")


DSM_TUD <- rast("scripts/data/tud-dsm-5m.tif")
DSM_TUD

summary(DSM_TUD)

summary(values(DSM_TUD))

DSM_TUD_df <- as.data.frame(DSM_TUD, xy = TRUE)

str(DSM_TUD_df)
ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y, fill = `tud-dsm-5m`)) +
  scale_fill_viridis_c(option = "turbo") +
  coord_equal()

crs(DSM_TUD, proj = TRUE)

# I get a different error than in the lesson
minmax(DSM_TUD)

DSM_TUD <- setMinMax(DSM_TUD)

minmax(DSM_TUD)

nlyr(DSM_TUD)

#take a look at a different file
describe("scripts/data/tud-dsm-5m-hill.tif")

DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation = cut(`tud-dsm-5m`, breaks = 3))

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation))

levels(DSM_TUD_df$fct_elevation)

# this matches what we see in the graph.
DSM_TUD_df |>
  count(fct_elevation)


