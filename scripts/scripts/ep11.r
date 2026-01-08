# ep 11
# visualizing classified rasters

library(tidyverse)
library(terra)

# remake the object:

DSM_TUD_df <- rast("scripts/data/tud-dsm-5m.tif") |>
  as.data.frame(xy = TRUE)

# this is going to make a very different distribution
custom_bins <- c(-10, 0, 5, 100)

DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation_cb = cut(`tud-dsm-5m`, breaks = custom_bins))

levels(DSM_TUD_df$fct_elevation_cb)

ggplot() +
  geom_bar(data = DSM_TUD_df, aes(fct_elevation_cb))

# more similar to the actual distro:

custom_bins_2 <- c(-10, 0, 15, 100)

DSM_TUD_2_df <- DSM_TUD_df |>
  mutate(fct_elevation_cb = cut(`tud-dsm-5m`, breaks = custom_bins_2))

levels(DSM_TUD_df$fct_elevation_cb)

ggplot() +
  geom_bar(data = DSM_TUD_2_df, aes(fct_elevation_cb))

# plot it classed
ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y, fill = fct_elevation_cb)) +
  coord_equal()

ggplot() +
  geom_raster(data = DSM_TUD_2_df, aes(x = x, y = y, fill = fct_elevation_cb)) +
  coord_equal()

# wow-- simultaneous contrast make that impossible to read

terrain.colors(3)

ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y, fill = fct_elevation_cb)) +
  scale_fill_manual(values = terrain.colors(3)) +
  coord_equal()

ggplot() +
  geom_raster(data = DSM_TUD_2_df, aes(x = x, y = y, fill = fct_elevation_cb)) +
  scale_fill_manual(values = terrain.colors(3)) +
  coord_equal()



# Challenge
# 6 class version of this.

DSM_TUD_df <- DSM_TUD_df |>
  mutate(fct_elevation_6 = cut(`tud-dsm-5m`, breaks = 6))

levels(DSM_TUD_df$fct_elevation_6)
ggplot() +
  geom_raster(data = DSM_TUD_df, aes(x = x, y = y, fill = fct_elevation_6)) +
  scale_fill_manual(values = terrain.colors(6)) +
  coord_equal()
