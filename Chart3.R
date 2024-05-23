
library(tidyverse) # for ggplot
library(dplyr)
library(ggplot2)
library(sf)
library(gridExtra)
library(grid)

prison_jail_rate_since_1990 <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true")


jail_latinx <- prison_jail_rate_since_1990 %>%
  select(year, state, total_jail_pop_rate, latinx_jail_pop_rate)

us_sf <- read_sf("tl_2023_us_state.shp")