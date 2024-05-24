library(tidyverse)
library(usmap)

prison_jail_rate_since_1990 <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true")

prison_cleaned <- prison_jail_rate_since_1990 %>%
  filter(!is.na(black_prison_pop_rate)) %>%
  filter(year == 2016) %>%
  select(state, year, black_prison_pop_rate)

merged_data <- prison_cleaned %>%
  group_by(state) %>%
  summarize(avg_black_jail_pop = mean(black_prison_pop_rate, na.rm = TRUE)) %>%
  na.omit() 

usmap_data <- merged_data %>%
  mutate(state = tolower(state)) 

plot_usmap(data = usmap_data, values = "avg_black_jail_pop", color = "white") +
  scale_fill_continuous(name = "Average Black Jail Pop Rate", 
                        label = scales::comma, 
                        low = "lightsteelblue1", 
                        high = "dodgerblue3") +
  labs(title = "Average Black Jail Population Rate by State (2016)")
