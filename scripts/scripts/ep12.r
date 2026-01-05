# Episode 2: Reproject Rasters
# and layer them

library(tera)

DTM_TUD <- rast("scripts/data/tud-dtm-5m.tif")
DTM_hill_TUD <- rast("scripts/data/tud-dtm-5m-hill-WGS84.tif")

DTM_TUD_df <- as.data.frame(DTM_TUD, xy = TRUE)
DTM_hill_TUD_df <- as.data.frame(DTM_hill_TUD, xy = TRUE)

ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(
      x = x,
      y = y,
      fill = `tud-dtm-5m`
    )
  ) +
  geom_raster(
    data = DTM_hill_TUD_df,
    aes(
      x = x,
      y = y,
      alpha = `tud-dtm-5m-hill`
    )
  ) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_equal()

# do both on their own

ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(
      x = x,
      y = y,
      fill = `tud-dtm-5m`
    )
  ) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_equal()

ggplot() +
  geom_raster(
    data = DTM_hill_TUD_df,
    aes(
      x = x,
      y = y,
      alpha = `tud-dtm-5m-hill`
    )
  ) +
  coord_equal()

# you can see they are distinctly different shapes.


# Challenge:
# compare CRSs

crs(DTM_TUD, parse = TRUE)
crs(DTM_hill_TUD, parse = TRUE)


# this is very much like a copy-paste
DTM_hill_EPSG28992_TUD <- project(
  DTM_hill_TUD,
  crs(DTM_TUD)
)

# original vs new:
crs(DTM_hill_EPSG28992_TUD, parse = TRUE)
crs(DTM_hill_TUD, parse = TRUE)

# I like to do this:
crs(DTM_hill_EPSG28992_TUD, parse = TRUE) == crs(DTM_TUD, parse = TRUE)
# but I don't know why the repeats.

# I suspect these still won't plot because the resolutions are different.
# but the lesson doesn't prove it.

# It just makes us change the res:
DTM_hill_EPSG28992_TUD <- project(DTM_hill_TUD,
                                  crs(DTM_TUD),
                                  res = res(DTM_TUD)
)


res(DTM_hill_EPSG28992_TUD)
res(DTM_TUD)

DTM_hill_TUD_2_df <- as.data.frame(DTM_hill_EPSG28992_TUD, xy = TRUE)

ggplot() +
  geom_raster(
    data = DTM_TUD_df,
    aes(
      x = x,
      y = y,
      fill = `tud-dtm-5m`
    )
  ) +
  geom_raster(
    data = DTM_hill_TUD_2_df,
    aes(
      x = x,
      y = y,
      alpha = `tud-dtm-5m-hill`
    )
  ) +
  scale_fill_gradientn(name = "Elevation", colors = terrain.colors(10)) +
  coord_equal()
