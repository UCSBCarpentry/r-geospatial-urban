library(tidyverse)
library(here)

gapminder <- read.csv(here("solutions/data", "gapminder-data.csv"))

ggplot(
  data = gapminder, # data
  aes(x = lifeExp) # aesthetics layer
) +
  geom_histogram() # geometry layer

gapminder |> # we select a subset
  filter(year == 2007 & continent == "Americas") |> # filter year and continent
  ggplot(aes(x = country, y = gdpPercap)) + # the x and y axes represent columns
  geom_col() # we use a column graph as a geometry

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  ggplot(aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip() # flip axes

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap)) |> # reorder factor levels
# re-ordering something that wasn't already a factor automagically
  # converts text to factors
    ggplot(aes(x = country, y = gdpPercap)) +
  geom_col() +
  coord_flip()

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap)) |>
  ggplot(aes(
    x = country,
    y = gdpPercap,
    fill = lifeExp # use 'fill' for surfaces; 'colour' for points and lines
  )) +
  geom_col() +
  coord_flip()

gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(country = fct_reorder(country, gdpPercap)) |>
  ggplot(aes(
    x = country,
    y = gdpPercap,
    fill = lifeExp
  )) +
  geom_col() +
  coord_flip() +
  scale_fill_viridis_c() # _c stands for continuous scale

p <- # this time let's save the plot in an object
  gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(
    country = fct_reorder(country, gdpPercap),
    lifeExpCat = if_else(
      lifeExp >= mean(lifeExp),
      "high",
      "low"
    )
  ) |>
  ggplot(aes(x = country, y = gdpPercap, fill = lifeExpCat)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(
    values = c(
      "light blue",
      "orange"
    ) # customize the colors
  )

p

p_labs <- p +
  labs(
    title = "GDP per capita in Americas",
    subtitle = "Year 2007",
    x = "Country",
    y = "GDP per capita",
    fill = "Life Expectancy categories"
  )

# show plot
p_labs

ggsave(
  plot = p,
  filename = here("fig_output", "plot_americas_2007.pdf")
)
# By default, ggsave() saves the last displayed plot, but
# you can also explicitly name the plot you want to save

?ggsave

gapminder_amr_2007 <- gapminder |>
  filter(year == 2007 & continent == "Americas") |>
  mutate(
    country_reordered = fct_reorder(country, gdpPercap),
    lifeExpCat = if_else(lifeExp >= mean(lifeExp), "high", "low")
  )

write.csv(gapminder_amr_2007,
          here("solutions/data_output", "gapminder_americas_2007.csv"),
          row.names = FALSE
)
