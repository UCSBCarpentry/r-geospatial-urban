# episode 4?

# dataframes

library(tidyverse)
getwd()
gapminder <- read.csv("scripts/data/gapminder-data.csv")

str(gapminder)
head(gapminder)

summary(gapminder)
nrow(gapminder)

country_vec <- gapminder$country
country_vec
head(unique(country_vec))

# Data manipulate it

# subset columns
year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

# 2 flavors of pipes
# ctrl_shift_M
year_country_gdp <- gapminder |>
  select(year, country, gdpPercap)

# filter
# not Europe, after 1999
year_country_gdp_euro <- gapminder |>
  filter(continent != "Europe" & year >= 2000) |>
  select(year, country, gdpPercap)

head(year_country_gdp_euro)


# Challenge



# start of episode 4
# visualization

# ggplot2

ggplot(data = gapminder,
       aes(x = lifeExp)) +
  geom_histogram()

gapminder |>
  filter(year==2007 & continent == "Americas") |>
  ggplot(aes(x=country, y=gdpPercap)) +
  geom_col()

# but that's hard to read
gapminder |>
  filter(year==2007 & continent == "Americas") |>
  ggplot(aes(x=country, y=gdpPercap)) +
    geom_col() + coord_flip()

####### We stopped here.



# #############################
# review for Tuesday

# Let's look at our neighbors in the Americas
unique(gapminder$continent)

americas <- gapminder |>
  filter(continent == "Americas" & year == 2007) |>
  select(year, country, gdpPercap, lifeExp)

americas_income <- americas |>
  select(country, gdpPercap)
americas_income

americas_income_sorted <- americas_income[order(americas_income$gdpPercap),]
americas_income_sorted

str(americas_income_sorted)

# why is neither sorted?
americas_income_sorted |>
  ggplot(aes(x=country, y=gdpPercap)) +
  geom_col() + coord_flip()

americas_income_sorted |>
  ggplot(aes(y=country, x=gdpPercap)) +
  geom_col() + coord_flip()


americas_income_sorted |>
  ggplot(aes(x=gdpPercap, y=country)) +
  geom_col()


# this is more from the solution set:
gapminder <- gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap))
# Ari's solution doesn't save the mutate!!!

# there's a big difference between these!
gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap))

