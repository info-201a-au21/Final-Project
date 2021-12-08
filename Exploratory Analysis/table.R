## package
library(dplyr)
library(ggplot2)
library(patchwork)
library(rmarkdown)
library(tidyverse)
library(stringr)

## read data
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GEWQGJFYAKOJIMOEZJW3BXE3M4")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GEWQVZCQY34C4HAMCMW3BXE3OI")
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/database.csv?token=AV3GEWQBS2333ULY5UKMMITBXE3P6")

## extract num
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
  inner_join(earthquake_num)
colnames(merge_disaster) <- c("Year",
                              "Number of Atlantic",
                              "Number of Pacific", 
                              "Number of Earthquake")
merge_disaster <-  merge_disaster[36:51,]
