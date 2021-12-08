severe_weather <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/severe_weather.csv?token=AV3GEWRB72N6DAGW2FWA6VLBXE55O")
weather <- read.csv("~/Desktop/WeatherEvents_Jan2016-Dec2020.csv", stringsAsFactors = FALSE)
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GEWQGJFYAKOJIMOEZJW3BXE3M4")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GEWQVZCQY34C4HAMCMW3BXE3OI")
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/database.csv?token=AV3GEWQBS2333ULY5UKMMITBXE3P6")
#Variable


# Variable1: 
#Filter the "severe" level weather events
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

# Variable2: cold_varibale
cold_varibale <- weather_time_span %>% 
  filter( mean_time_span == max(mean_time_span)) %>% 
  pull(mean_time_span)
cold_varibale




#Variable3: state sum

weather_data <- weather %>%
  filter(Severity == "Severe") %>%
  group_by(State) %>%
  summarise(num = length(Severity))

max_state_name <- weather_data %>% 
  filter(num == max(num)) %>% 
  pull(State)

max_state_num <- weather_data %>% 
  filter(num == max(num)) %>% 
  pull(num)



#Variable 4: high_year_disaster_hurricane_earthquake
high_year_disaster_hurricane_earthquake <- merge_disaster %>%
  group_by(year) %>%
  summarise(total_disater = earthquake_num + atlantic_num + pacific_num) %>%
  summarise(total_disater = max(total_disater))

#Variable 5: high_year_change
year_change <- merge_disaster %>%
  summarise(earthquake_change = earthquake_num - lag(earthquake_num, default = T), 
            atlantic_change = atlantic_num - lag(atlantic_num, default = T), 
            pacific_change = pacific_num - lag(pacific_num, default = T))

year_change_earthquake <- year_change %>%
  filter(earthquake_change > 0) %>%
  summarise(type = "earthquake", num = n()) 
year_change_atlantic <- year_change %>%
  filter(atlantic_change > 0) %>%
  summarise(type = "atlantic", num = n()) 
year_change_pacific <- year_change %>%
  filter(pacific_change > 0) %>%
  summarise(type = "pacific", num = n())

compare <- year_change_earthquake %>%
  full_join(year_change_atlantic) %>%
  full_join(year_change_pacific)

high_year_change <- compare %>%
  filter(num == max(num)) %>%
  pull(type)

#Variable 6: mean_atlantic_time 
pacific_time <- pacific %>%
  group_by(ID) %>%
  summarise(time_span = max(Date)- min(Date)) 
mean_pacific_time <- pacific_table %>%
  summarise(mean = mean(time_span))
mean_pacific_time <- select(mean_pacific_time, mean)
mean_pacific_time <- pull(mean_pacific_time)
atlantic_time <- atlantic %>%
  group_by(ID) %>%
  summarise(time_span = max(Date)- min(Date)) 
mean_atlantic_time <- atlantic_table %>%
  summarise(mean = mean(time_span))
mean_atlantic_time <- select(mean_atlantic_time, mean)
mean_atlantic_time <- pull(mean_atlantic_time)










  
  
