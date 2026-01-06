# episode 3 and 4

# dataframes are tables

library(tidyverse)
library(here)

gapminder <- read.csv(here("data", "gapminder-data.csv"))

str(gapminder)
head(gapminder)

summary(gapminder)
nrow(gapminder)

country_vec <- gapminder$country
country_vec

# nesting functions
# later we will show pipes
head(unique(country_vec))

# Data: manipulate it
# tidy verbs: select, filter, mutate,

# select = subset columns
year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

# 2 flavors of pipes
# ctrl + shift + m
# the |> is the new 'base R' pipe
# %>%    is the dplyr pipe (dplyr comes with tidyverse)

year_country_gdp <- gapminder |>
  select(year, country, gdpPercap)

# filter
# not Europe, after 1999
year_country_gdp_euro <- gapminder |>
  filter(continent != "Europe" & year >= 2000) |>
  select(year, country, gdpPercap)

head(year_country_gdp_euro)

# Challenge
# outside of Europe in 21st century
year_country_gdp_eurasia <- gapminder |>
  filter(continent == "Europe" | continent == "Asia") |>
  select(year, country, lifeExp)
head(year_country_gdp_eurasia)
str(year_country_gdp_eurasia)

gapminder |>
  group_by(continent, year) |>
  summarize(avg_lifeExp = mean(lifeExp))

gapminder |>
  count(continent)

# Mutate
gapminder_gdp <- gapminder |>
  mutate(gdpBillion = gdpPercap * pop / 10^9)

head(gapminder_gdp)

# Data visualization
# start episode 4
# ggplot2: comes with tidyverse
# three components to every plot:
#.        data,
#.        aesthetics,
#.        geometries

ggplot(data = gapminder,
       aes(x = lifeExp)) +
       geom_histogram()

# a very common and complicated
# social science plot
ggplot(data = gapminder,
       aes(x = lifeExp, y = gdpPercap)) +
  geom_point()
ggplot(data = gapminder,
       aes(x = lifeExp, y = gdpPercap)) +
  geom_point() +
  coord_flip()


gapminder |>
  filter(year==2007 & continent == "Americas") |>
  ggplot(aes(x=country, y=gdpPercap)) +
  geom_col()

# but that's hard to read
# so flip it
gapminder |>
  filter(year==2007 & continent == "Americas") |>
  ggplot(aes(x=country, y=gdpPercap)) +
    geom_col() + coord_flip()

# yes, that's the same as changing x and y:
gapminder |>
  filter(year==2007 & continent == "Americas") |>
  ggplot(aes(y=country, x=gdpPercap)) +
  geom_col()



####### We stopped here.

# jose <= today & today <= arie

# #############################
# review for Tuesday

# three components to every plot:
#.        data,
#.        aesthetics,
#.        geometries

# a very common and complicated
# social science plot
# on an unmanipulated gapminder

library(tidyverse)
# when we load here() it tells us where we are
library(here)

gapminder <- read.csv(here("data", "gapminder-data.csv"))

# remind ourselves what they look like with:
# structure: ...
# first few lines: ...

# GDP vs Life Expectancy
ggplot(data = gapminder,
       aes(x = lifeExp, y = gdpPercap)) +
  geom_point()

ggplot(data = gapminder,
       aes(x = lifeExp, y = gdpPercap)) +
  geom_point() +
# easier than editing x and y?
    coord_flip()


# Let's look at our neighbors in the Americas
# to review tidy verbs
unique(gapminder$continent)

americas <- gapminder |>
  filter(continent == "Americas" & year == 2007) |>
  select(year, country, gdpPercap, lifeExp)

americas_income <- americas |>
  select(country, gdpPercap)
americas_income


# this is more from the solution set:
gapminder <- gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap))

# Ari's solution doesn't save the mutate!!!
# there's a big difference between these!

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap))

# pick up at ep04.r line 20.
