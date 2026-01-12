# ep 14
# multi-band rasters
# ie: Color!
# (jon)

library(raster)

# this lesson really buries the lead.
# when we use rast, by default we get all the bands:
RGB_stack_TUD <- rast("scripts/data/tudlib-rgb.tif")

# we can confirm it's RGB with it's metadata
RGB_stack_TUD

# and let's skip all the ggplot typing and go straight to the answer:
plotRGB(RGB_stack_TUD,  r = 1, g = 2, b = 3)


# we can always grab just one layer
RGB_band1_TUD <- rast("scripts/data/tudlib-rgb.tif", lyrs = 1)

# and convert that to a dataframe and ggplot it.
# but that is sooooooo much typing.
