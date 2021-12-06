atlantic <- read.csv("~/Desktop/Group_analysis/atlantic.csv")
earthquake <- read.csv("~/Desktop/Group_analysis/database.csv")
weather <- read.csv("~/Desktop/Group_analysis/WeatherEvents.csv")
pacific <- read.csv("~/Desktop/Group_analysis/pacific.csv")
weather <- weather %>%
  filter(Severity == "Severe")
library(dplyr)
install.packages("rgdal")
library(rgdal)

library(spData)
library(rgdal)
install.packages("terra")
library(terra)
install.packages('spDataLarge', repos='https://nowosad.github.io/drat/', type='source')


earthquake <- earthquake %>%
  select(Latitude, Longitude)

pacific <- pacific %>%
  select(ID, Latitude, Longitude)

atlantic <- atlantic %>%
  select(ID, Name, Date, Latitude, Longitude, Maximum.Wind)

lonlat_to_state <- function(pointsDF,
                            states = spData::us_states,
                            name_col = "NAME") {
  ## Convert points data.frame to an sf POINTS object
  pts <- st_as_sf(pointsDF, coords = 1:2, crs = 4326)
  
  ## Transform spatial data to some planar coordinate system
  ## (e.g. Web Mercator) as required for geometric operations
  states <- st_transform(states, crs = 3857)
  pts <- st_transform(pts, crs = 3857)
  
  ## Find names of state (if any) intersected by each point
  state_names <- states[[name_col]]
  ii <- as.integer(st_intersects(pts, states))
  state_names[ii]
}
earthquake <- earthquake %>%
  select(Latitude, Longitude) 
colnames(earthquake) <- c("x", "y")
earthquake <- earthquake %>%
  round(Latitude, digits = 0)
pacific <- pacific %>%
  select(Latitude, Longitude) %>%
  filter(Latitude != "") %>% 
  filter(Longitude != " ")
lonlat_to_state(pacific)
testPoints <- data.frame(x = c(-110.4, -97.8, -98.9), y = c(10, 10, 10))
lonlat_to_state(earthquake)
testPoints <- data.frame(x = c(-90, -120, 0), y = c(44, 44, 44))
lonlat_to_state(testPoints)

weather_time <- weather %>%
  filter(Severity == "Severe") %>%
  group_by(State) %>%
  summarise(times = length(State))


#Map
library(maps)
library(usdata)

earthquake_map <- earthquake %>% 
  select(Magnitude, Longitude , Latitude)


state_shape <- map_data("state") %>%
  rename(state = region)

state_shape <- state_shape %>%
  mutate(state = state2abbr(state))

state_shape <- state_shape %>%
  left_join( earthquake_map, by = "state")



earthquake_map <- weather %>% 
  select(, LocationLat , LocationLng, State)


state_shape <- map_data("state") %>%
  rename(state = region)

state_shape <- state_shape %>%
  mutate(state = state2abbr(state))

state_shape <- state_shape %>%
  left_join( earthquake_map, by = "state")









