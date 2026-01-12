# load packages
library(tidyverse)
library(here)

here("data")

# I got an error, but I also had gapminder from
# the larger download.
download.file("https://bit.ly/geospatial_data", here("data", "gapminder-data.csv"))

x <- 1 / 40

# Jose points towards enironment
# panel rather than outputs
x

x <- 100

y <- x *5
