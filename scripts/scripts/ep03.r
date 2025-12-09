library(here)



gapminder <- read.csv(here("scripts/data", "gapminder-data.csv"))

str(gapminder)

# Show first 6 rows of the data set
head(gapminder)

# Show first 6 rows of the data set
head(gapminder, 10)

# Basic statistical information about each column
# Information format differs by data type.
summary(gapminder)

# Return number of rows in a dataset
nrow(gapminder)


# Return number of columns in a dataset
ncol(gapminder)

# access the values in a column
country_vec <- gapminder$country

head(country_vec)

# first 10 countries
head(unique(country_vec), 10)

# jumping ahead, the above is hard to read, so let's
# use pipes:
library(dplyr)

unique(gapminder$country)  %>% head(10)
# ie: take the results of unique() and send them to head.


# select out a 3 columns:
year_country_gdp <- select(gapminder, year, country, gdpPercap)

head(year_country_gdp)
