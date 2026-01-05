library(here)

gapminder <- read.csv(here("data", "gapminder-data.csv"))
str(gapminder)
head(gapminder)
head(gapminder, 10)

summary(gapminder)
nrow(gapminder)
ncol(gapminder)

country_vec <- gapminder$country
head(country_vec)
head(unique(country_vec))

# Data manipulation
library(tidyverse)

year_country_gdp <- select(gapminder, year, country, gdpPercap)
head(year_country_gdp)

# Pipes
# ctrl + shift + m

year_country_gdp <- gapminder |>
  select(year, country, gdpPercap)

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
# ggplot2
# three components: data, aesthetics, geometries

ggplot(data = gapminder,
       aes(x = lifeExp))+
  geom_histogram()

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  ggplot(aes(x = country, y = gdpPercap))+
  geom_col()+
  coord_flip()
