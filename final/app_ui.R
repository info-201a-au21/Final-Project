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
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Final Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction Page", tabName = "introduction_tab",
               icon = icon("dashboard")),
      menuItem("Weather map Page", tabName = "map_tab", icon = icon("th")),
      menuItem("Hurricane Page", tabName = "hurricane_tab", icon = icon("th")),
      menuItem("Severe Weather Page", tabName = "chart_panel",
               icon = icon("th")),
      menuItem("Table", tabName = "summary", icon = icon("th")),
      menuItem("Summary", tabName = "text", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # introduction
      tabItem(
        tabName = "introduction_tab",
        fluidPage(
          includeCSS("final.css"),
          # intro page
          titlePanel("Introduction"),
          h2("Topic"),
          p("In 2021, individuals pay most of their attention to the
                  COVID-19, a global natural biological disaster,  but ignore
                  the importance of natural disasters that happen all the time.
                  We want to know the connection of disasters, the impact of
                  these disasters(measured by casualties and property losses),
                  and the region these events often happen. Also, we want to
                  find the impact of the information gap in natural
                  disasters."),
          h2("Database"),
          p("To better understand natural disasters, we choose three
                  typical disasters: hurricane, earthquake, and severe weather.
                  These disasters happen constantly and impact people’s lives
                  tremendously. Hence, to explore these destructive events
                  comprehensively, we choose databases from
                  NOAA(official-hurricane), US geology
                  survey(official-earthquake), and
                  Sobhan Moosavi(individual-severe weather) to establish
                  our research."),
          tags$img(
            src = "https://static.scientificamerican.com/sciam/cache/file/C3FEE308-0F12-4B50-B80346DFDD5247FA_source.jpg?w=590&h=800&8148E9E5-5BEA-461E-A7665E298C0CAEDF"
          ),
        )
      ),

      # weather map
      tabItem(
        tabName = "map_tab",
        h1("Severe Weather State Map (2016-2020)"),
        sidebarPanel(
          sliderInput(
            inputId = "year_range",
            label = "Year Range",
            min = 2016,
            max = 2020,
            value = c(2016, 2020)
          )
        ),
        mainPanel(
          plotlyOutput(outputId = "severe_weather_state_map")
        ),
        fluidPage(
          includeCSS("final.css"),
          p("The chart visualizes the total number of severe weathers in
                the U.S. on each continent between ", strong("2016-2020"), " in
                the form of a map, where the shades of color represent the size
                of the total."),
          h3("Purpose"),
          p("We would like to visualize the distribution of severe weather
                  severity for each continent in the United States. And, whether
                  severe natural weather is related to geographic location. We
                  would assume that coastal areas are more susceptible to severe
                  days of natural weather."),
          h3("Insight"),
          p(
            "The number of severe natural hazards is generally ",
            strong("higher"),
            " across continents in the coastal regions of the United
                  States."
          ),
          p("Texas is the continent with the ", strong("highest"), " total
                number of severe weather")
        )
      ),

      # Hurricane page
      tabItem(
        tabName = "hurricane_tab",
        sidebarPanel(
          selectInput(
            inputId = "y_axis_input",
            label = "Y axis",
            choices = c("Pacific", "Atlantic"),
            selected = "Pacific"
          )
        ),
        mainPanel(
          plotOutput("hurricane")
        ),
        fluidPage(
          includeCSS("final.css"),
          h3("Insight"),
          p("From two charts, we can find out that the ",
          strong("Pacific hurricane have more occurrences and longer
                 time span."))
        )
      ),

      # Severe weather page
      tabItem(
        tabName = "chart_panel",
        sidebarPanel(
          checkboxInput("smooth", label = strong("Show Boxplot"), value = TRUE)
        ),
        mainPanel(plotOutput("plot")),
        fluidPage(
          includeCSS("final.css"),
          p("This chart shows the average time span (in minutes) of severe
          weather in the United States over the period ", strong("2016-2020"),
          ". It shows 3 severe weather types."),
          h3("Purpose"),
          p("Considering the different types of weather in the United States,
          this chart enables us to compare the average duration of various
          severe weather types so that we can understand which type lasts the
          longest. Likewise, this chart allows us to better prevent and predict
          natural weather disasters in the future by showing the duration of the
          three severe weather types."),
          h3("Insight"),
          p("The Cold Type had an average time span of nearly ", strong("425
          minutes(7 hours)"), "significantly higher than the other two weather
            types."),
          p("This may indicate that heavy snow is the longest lasting severe
          natural disaster. Prolonged periods of heavy snowfall can cause
          hazards to the United States such as transportation disruptions or
          untimely food supplies."),
          p(
            "The average time span for both Fog Type and Storm Type is close to
          ", strong("100 minutes."),
            p("This may indicate that Fog and Storm, although short in duration,
          are serious hazards. They are more in need of accurate prediction and
          preparedness to facilitate the reduction of large-scale natural
          disasters.")
          )
        )
      ),

      # Summary
      tabItem(
        tabName = "summary",
        mainPanel(tableOutput("table")),
        fluidPage(
          includeCSS("final.css"),
          p("This table shows the num of three disaster in a overlapping
                years."),
          h2("Purpose"),
          p("We want to find, on a same year. How many disaster
                has happened for Atlantic hurricane, pacific hurricane and
                earthquake. And we want find if there are any relationship
                between these three type of disaster."),
          h2("Insight"),
          p("From the table we find the highest number of Atlantic
                hurricane occurred in 2005, while highest number of pacific
                hurricane occurred in 1992. Also, highest number of earthquake
                is occurred in 2011. So there are no big relationship between
                these three type of disaster.")
        )
      ),
      tabItem(
        tabName = "text",
        fluidPage(
          includeCSS("final.css"),
          h1("Summary"),
          h2("Information Gap"),
          p("In our research, we find that the data in the database is
              different from our perspective (ideal data) and we need to use
              plenty of time to understand and clean them. When we want to put
              all three databases on the same map, we recognized that database
              creators use various ways to present geological locations that are
              extremely different. We need to set them in the same format so
              that R could deal with them successfully. At the same time, the
              information gap also hides people from the information they need
              to build overall comprehension; it allows individuals to have
              misunderstandings toward natural disasters. If information
              deliverers spread information differently, information receivers
              may have totally different comprehension of the same thing"),
          h2("Best Living Place in the US"),
          p("According to our project's conclusion, we find that the East
              part of America has fewer hurricanes, earthquakes, and severe
              weather, which is suitable for living. However, based on our
              research in Google, Americans consider many Southern states as
              suitable states to live in, which contain subjective perspectives.
              We summarize that sometimes people's recognition based on
              experience is not true and we need to check them through
              scientific research. "),
          h2("Missing Data"),
          p("In the research, even if two of the databases are collected by
                the official, it still misses a bunch of data. Missing data
                might aid us to have inaccurate conclusions toward our project.
                For instance, when Julie is dealing with severe weather in the
                US, her map cannot show the number of severe weathers per state
                in the US in many central states, which hinders us from precise
                understanding. Missing data is prevalent in data processing,
                and we should pay attention to it.")
        )
      )
    )
  )
)
