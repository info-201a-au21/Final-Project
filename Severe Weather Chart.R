<<<<<<< HEAD
library(tidyverse)
library("dplyr")
library("ggplot2")
library(lubridate)
weather <- read.csv("~/Desktop/WeatherEvents_Jan2016-Dec2020.csv", stringsAsFactors = FALSE)

# Filter the "severe" level weather events
weather_data <- weather %>%
  filter(Severity == "Severe") %>%
  select(Type, StartTime.UTC., EndTime.UTC.)

# Change the time to the POSIXlt type
endT = strptime(weather_data$EndTime.UTC., ("%Y-%m-%d %H:%M:%S"))
startT = strptime(weather_data$StartTime.UTC., ("%Y-%m-%d %H:%M:%S"))

# Summarise the mean time span for each severe weather type
weather_time_span <- weather_data %>%
  mutate(time_span = difftime(endT, startT, units = "mins")) %>%
  filter(time_span != "NA") %>%
  group_by(Type) %>%
  summarise(mean_time_span = mean(time_span))

# Severe Weather Type vs. Mean Time Span Chart
severe_weather_chart <- ggplot(data = weather_time_span) + 
  geom_col(mapping = aes(x = Type, y = mean_time_span)) + 
  labs(
    title = "Severe Weather Mean Time Span in U.S. (2016-2020)",
    x = "Severe Weather Type",
    y = "Mean Time Span (mins)"
  )
=======

>>>>>>> 8ff96cb5f98b9a6e4a314fd1f946fe244a5f4f6b
