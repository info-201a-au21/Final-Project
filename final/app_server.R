library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(stringr)
library(tidyverse)
library(lubridate)
library(shinyWidgets)
library(shinydashboard)
library(formattable)
library(rsconnect)
library(maps)
library(usdata)
library("ggthemes")
library("scales")
library("mapproj")

## read data
# weather map
weather <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/severe_weather.csv?token=AV53J63L5MHHVPE5APSNEIDBY2HSG", stringsAsFactors = FALSE)
weather_data2 <- weather %>%
  mutate(year_time = (gsub("[^()]*\\/", "", StartTime.UTC.))) %>%
  mutate(year_two = str_sub(year_time, 1, 2)) %>%
  mutate(year = paste0("20", year_two))

# hurricane
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GE53O3FO7MYMTT4GREI3BX3V5E")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GE57MO4EGZBYP3E4WAK3BX3V7U")
pacific <- pacific %>%
  select(ID, Name, Date, Latitude, Longitude, Maximum.Wind)
atlantic <- atlantic %>%
  select(ID, Name, Date, Latitude, Longitude, Maximum.Wind)
pacific_time <- pacific %>%
  group_by(ID) %>%
  summarise(time_span = max(Date) - min(Date))
pacific_max <- pacific %>%
  group_by(ID) %>%
  summarise(Max_wind = mean(Maximum.Wind))
pacific_date <- pacific %>%
  group_by(ID) %>%
  summarise(Date = mean(Date))
pacific_date$Date <- pacific_date$Date / 10000
pacific_date$Date <- formattable(pacific_date$Date, digits = 4, format = "f")
pacific_date$Date <- round(pacific_date$Date, 0)
pacific_table <- pacific_time %>%
  left_join(pacific_max, by = "ID") %>%
  left_join(pacific_date, by = "ID")
atlantic_time <- atlantic %>%
  group_by(ID) %>%
  summarise(time_span = max(Date) - min(Date))
atlantic_max <- atlantic %>%
  group_by(ID) %>%
  summarise(Max_wind = mean(Maximum.Wind))
atlantic_date <- atlantic %>%
  group_by(ID) %>%
  summarise(Date = mean(Date))
atlantic_date$Date <- atlantic_date$Date / 10000
atlantic_date$Date <- formattable(atlantic_date$Date, digits = 4, format = "f")
atlantic_date$Date <- round(atlantic_date$Date, 0)
atlantic_table <- atlantic_time %>%
  left_join(atlantic_max, by = "ID") %>%
  left_join(atlantic_date, by = "ID") %>%
  filter(time_span <= "1000") %>%
  filter(Max_wind >= "0")
whole_table <- pacific_table %>%
  left_join(atlantic_table, by = "Date") %>%
  select(time_span.x, Max_wind.x, Date, time_span.y, Max_wind.y)
colnames(whole_table) <- c(
  "pacific_Time_Span", "pacific_Max_Wind", "date",
  "atlantic_Time_Span", "atlantic_Max_Wind"
)

# severe weather page
weather_data <- weather %>%
  select(Type, StartTime.UTC., EndTime.UTC.)
endT <- strptime(weather_data$EndTime.UTC., ("%m/%d/%Y %H:%M"))
startT <- strptime(weather_data$StartTime.UTC., ("%m/%d/%Y %H:%M"))
weather_time_span_data <- weather_data %>%
  mutate(time_span = as.numeric(difftime(endT, startT, tz = "UTC",
                                         units = "mins"))) %>%
  filter(time_span != "NA")
weather_time_span <- weather_data %>%
  mutate(time_span = difftime(endT, startT, tz = "UTC", units = "mins")) %>%
  filter(time_span != "NA") %>%
  group_by(Type) %>%
  summarise(mean_time_span = as.numeric(mean(time_span)))

# Table
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/database.csv?token=AV53J63IDEJYGMAFDVIAGZTBY2HUW")
# extract num
earthquake_num <- earthquake %>%
  mutate(year = as.numeric(gsub("[^()]*\\/", "", Date))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(earthquake_num = n())

atlantic_num <- atlantic %>%
  mutate(year = as.numeric(str_sub(Date, 1, 4))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(atlantic_num = n())

pacific_num <- pacific %>%
  mutate(year = as.numeric(str_sub(Date, 1, 4))) %>%
  group_by(year) %>%
  filter(!is.na(year)) %>%
  summarise(pacific_num = n())

## final graph
merge_disaster <- atlantic_num %>%
  inner_join(pacific_num) %>%
  inner_join(earthquake_num) %>%
  mutate(year = round(year, 0))
colnames(merge_disaster) <- c(
  "Year",
  "Number of Atlantic",
  "Number of Pacific",
  "Number of Earthquake"
)
merge_disaster <- merge_disaster[36:51, ]


## sever
server <- function(input, output) {
  output$severe_weather_state_map <- renderPlotly({
    # weather plot
    weather_data_year <- weather_data2 %>%
      filter(year >= input$year_range[1], year <= input$year_range[2]) %>%
      group_by(State) %>%
      summarise(num = length(Severity))

    state_shape <- map_data("state") %>%
      mutate(State = toupper(str_sub(region, 1, 2))) %>%
      left_join(weather_data_year, "State")

    blank_theme <- theme_bw() +
      theme(
        axis.line = element_blank(), # remove axis lines
        axis.text = element_blank(), # remove axis labels
        axis.ticks = element_blank(), # remove axis ticks
        axis.title = element_blank(), # remove axis titles
        plot.background = element_blank(), # remove gray background
        panel.grid.major = element_blank(), # remove major grid lines
        panel.grid.minor = element_blank(), # remove minor grid lines
        panel.border = element_blank() # remove border around plot
      )

    my_plot <- ggplot(state_shape) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = num),
        color = "white",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(low = "#98D6EA", high = "#F3D1F4") +
      labs(
        title = "Number of Severe Weather Per State in U.S.",
        fill = "Number of Severe Weather"
      ) +
      blank_theme

    my_plotly_plot <- ggplotly(my_plot)

    return(my_plotly_plot)
  })

  # hurricane
  output$hurricane <- renderPlot({
    if (input$y_axis_input == "Atlantic") {
      ggplot(data = whole_table) +
        geom_point(mapping = aes(
          x = date, y = atlantic_Time_Span,
          color = atlantic_Max_Wind
        )) +
        labs(
          title = "Time Span of Hurricane from 1949 to 2015", x = "Year",
          y = "Atlantic Time Span", color = "Atlantic Max Wind"
        )
    } else {
      ggplot(data = whole_table) +
        geom_point(mapping = aes(
          x = date, y = pacific_Time_Span,
          color = pacific_Max_Wind
        )) +
        labs(
          title = "Time Span of Hurricane from 1949 to 2015", x = "Year",
          y = "Pacific Time Span", color = "Pacific Max Wind"
        )
    }
  })

  # severe weather
  output$plot <- renderPlot({
    p <- ggplot(
      data = weather_time_span,
      mapping = aes(x = Type, y = mean_time_span)
    ) +
      geom_col() +
      labs(
        title = "Severe Weather Mean Time Span in U.S. (2016-2020)",
        x = "Severe Weather Type",
        y = "Mean Time Span (mins)"
      )
    if (input$smooth) {
      p <- p + geom_boxplot(
        data = weather_time_span_data,
        mapping = aes(x = Type, y = time_span)
      )
    }
    p
  })

  # table
  output$table <- renderTable(merge_disaster)
}
