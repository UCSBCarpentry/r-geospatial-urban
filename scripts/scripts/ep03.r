library(here)


gapminder <- read.csv(here("scripts/data", "gapminder_data.csv")) # dash or underscore?

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

# base R now does pipes:

unique(gapminder$country)  |> head(10)

# jumping ahead, the above is hard to read, so let's
# use pipes:
library(dplyr)

unique(gapminder$country)  %>% head(10)
# ie: take the results of unique() and send them to head.


# Select
# select out 3 of the 15 columns:
year_country_gdp <- select(gapminder, year, country, gdpPercap)

head(year_country_gdp)

# Filter
# get only rows that match criteria
year_country_gdp_euro <- gapminder |>
  filter(continent != "Europe" & year >= 2000) |>
  select(year, country, gdpPercap)

# '&' operator (AND) - both conditions must be met

head(year_country_gdp_euro)
(year_country_gdp_euro)

# similar filter
# (remember, our already filtered dataset includes everyone
# BUT Europe)
year_gdp_namerica <- year_country_gdp_euro |>
  filter(country == "Canada" |  country == "Mexico" | country == "United States")

# '|' operator (OR) - at least one of the conditions must be met

head(year_gdp_namerica)

# challenge
# Write a single command
# (which can span multiple lines and includes pipes)
# that will produce a dataframe that has the values
# for life expectancy, country and year, only for EurAsia.

str(gapminder)
unique(gapminder$continent)

challenge_EurAsia <- gapminder |>
    filter(continent=="Asia" | continent == "Europe") |>
    select(lifeExp, country, year)
nrow(challenge_EurAsia)

# here in the lesson, the solution has gdp, but the challenge
# question asks for life expectancy.
# also: write a second command to tell you how many rows.

# Group and Summarize
gapminder |> # select the dataset
  group_by(continent) |> # group by continent
  summarize(avg_gdpPercap = mean(gdpPercap)) # create basic stats

# challenge
# Calculate the average life expextancy per country. Which country has the
# longest average life expectancy and which has the shortest?
# hint: use max() and min() functions.

gapminder |>
  group_by(country) |>
  summarize(avg_lifeExp = mean(lifeExp)) |>
  filter(avg_lifeExp == min(avg_lifeExp) |
           avg_lifeExp == max(avg_lifeExp))

# multiple groups and summary variables
gapminder |>
  group_by(continent, year) |>
  summarize(avg_gdpPercap = mean(gdpPercap))

gdp_pop_bycontinents_byyear <- gapminder |>
  group_by(continent, year) |>
  summarize(
    avg_gdpPercap = mean(gdpPercap),
    sd_gdpPercap = sd(gdpPercap),
    avg_pop = mean(pop),
    sd_pop = sd(pop),
    n_obs = n()
  )

head(gdp_pop_bycontinents_byyear)

# Frequencies
gapminder |>
  count(continent)

# Mutate
gapminder_gdp <- gapminder |>
  mutate(gdpBillion = gdpPercap * pop / 10^9)

head(gapminder_gdp)
