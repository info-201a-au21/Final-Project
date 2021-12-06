library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(stringr)
library(shinyWidgets)


#Introduction Page
if (interactive()) {
introduction_page <- tabPanel(
  "Introduction Page",
  titlePanel("Introduction"),
  h2("Topic"),
  p("In 2021, individuals pay most of their attention to the COVID-19, a global natural biological disaster,  but ignore the importance of natural disasters that happen all the time. We want to know the connection of disasters, the impact of these disasters(measured by casualties and property losses), and the region these events often happen. Also, we want to find the impact of the information gap in natural disasters."),
  h2("Database"),
  p("To better understand natural disasters, we choose three typical disasters: hurricane, earthquake, and severe weather. These disasters happen constantly and impact people’s lives tremendously. Hence, to explore these destructive events comprehensively, we choose databases from NOAA(official-hurricane), US geology survey(official-earthquake), and Sobhan Moosavi(individual-severe weather) to establish our research."),
  setBackgroundImage(
    src = "https://en.wikipedia.org/wiki/Tropical_cyclone#/media/File:Hurricane_Isabel_from_ISS.jpg")
)
}







#UI page
ui <- navbarPage(
  "Final Project: Natural Environmental Disasters Research",
  introduction_page,
  
)



