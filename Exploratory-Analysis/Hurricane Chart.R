pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GEWQGJFYAKOJIMOEZJW3BXE3M4")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GEWQVZCQY34C4HAMCMW3BXE3OI")
library("ggplot2")
library("dplyr")
library(stringr)
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
