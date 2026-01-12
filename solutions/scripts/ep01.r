install.packages("here")
install.packages("tidyverse")


# Load packages
library(tidyverse)
library(here)


# Download the data
# JJ hates here
download.file(
  "https://bit.ly/geospatial_data",
  here("scripts/data", "gapminder-data.csv")
)


