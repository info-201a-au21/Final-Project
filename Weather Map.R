library(tidyverse)
library("dplyr")
library("ggplot2")
library(lubridate)
weather <- read.csv("~/Desktop/severe_weather.csv", stringsAsFactors = FALSE)

# Filter the "severe" level weather events
weather_data <- weather %>%
  group_by(State) %>%
  summarise(num = length(Severity))
  
state_shape <- map_data("state") %>%
  mutate(State = toupper(str_sub(region, 1, 2))) %>%
  left_join(weather_data, "State")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

ggplot(state_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = num),
    color = "white",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "#98D6EA", high = "#F3D1F4") +
  labs(title = "Number of Severe Weather Per State in U.S. (2016-2020)",
       fill = "Number of Severe Weather") +
  blank_theme
