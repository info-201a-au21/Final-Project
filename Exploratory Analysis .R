atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GEWVSSS2O3HFAS5IN7MLBUVEYW")
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/database.csv?token=AV3GEWWUKHAHG62JUEDG2MLBUVE2G")
severe_weather <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/severe_weather.csv?token=AV3GEWTQ7BYVKLUBOKUZDRLBUVE3K")
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GEWSHDW2UWVZXBI52QATBUVE4S")

#Variable





#Hurricane Chart
library("ggplot2")
library("dplyr")
library("stringr")
# devtools::install_github("renkun-ken/formattable")
library(formattable)

pacific <- pacific %>%
  select(ID, Name, Date, Latitude, Longitude, Maximum.Wind)
atlantic <- atlantic %>%
  select(ID, Name, Date, Latitude, Longitude, Maximum.Wind)


pacific_time <- pacific %>%
  group_by(ID) %>%
  summarise(time_span = max(Date)- min(Date)) 
pacific_max <- pacific %>%
  group_by(ID) %>%
  summarise(Max_wind = mean(Maximum.Wind))
pacific_date <- pacific %>%
  group_by(ID) %>%
  summarise(Date = mean(Date))
pacific_date$Date <- pacific_date$Date / 10000
pacific_date$Date <- formattable(pacific_date$Date, digits = 4, format = "f")

pacific_table <- pacific_time %>%
  left_join(pacific_max, by = "ID") %>%
  left_join(pacific_date, by = "ID")

(chart_pacific <- ggplot(data = pacific_table) +
    geom_point(mapping = aes(x = Date, y = time_span, color = Max_wind)) +
    labs(x = "Date", y = "Time Span (Days)", 
         title = "Time Span of Pacific Hurricane from 1949 to 2015"))

atlantic_time <- atlantic %>%
  group_by(ID) %>%
  summarise(time_span = max(Date)- min(Date)) 
atlantic_max <- atlantic %>%
  group_by(ID) %>%
  summarise(Max_wind = mean(Maximum.Wind))
atlantic_date <- atlantic %>%
  group_by(ID) %>%
  summarise(Date = mean(Date))
atlantic_date$Date <- atlantic_date$Date / 10000
atlantic_date$Date <- formattable(atlantic_date$Date, digits = 4, format = "f")

atlantic_table <- atlantic_time %>%
  left_join(atlantic_max, by = "ID") %>%
  left_join(atlantic_date, by = "ID") %>%
  filter(time_span <= "1000") %>%
  filter(Max_wind >= "0")

(chart_atlantic <- ggplot(data = atlantic_table) +
    geom_point(mapping = aes(x = Date, y = time_span, color = Max_wind)) +
    labs(x = "Date", y = "Time Span (Days)", 
         title = "Time Span of Atlantic Hurricane from 1851 to 2013"))

#Severe Weather Chart
library(tidyverse)
library("dplyr")
library("ggplot2")
library("lubridate")
install.packages("lubridate")
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

