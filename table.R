## package
library(dplyr)
library(ggplot2)
library(patchwork)
library(rmarkdown)
library(tidyverse)
library(stringr)

## read data
pacific <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/pacific.csv?token=AV3GE57P4SGI6ZRI24VRBRLBUVEWA")
atlantic <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/atlantic.csv?token=AV3GE53CAQACJQKXE73BBFLBUVE2Q")
earthquake <- read.csv("https://raw.githubusercontent.com/info-201a-au21/Final-Project/main/dataset/database.csv?token=AV3GE57BLZ2SUTXE6NEQULLBUVFBE")

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
