library(dplyr)
library(tidyr)

prison_pop <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-pop.csv?raw=true")
jail_pop <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-jail-pop.csv?raw=true")
prison_jail_rate <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates.csv?raw=true")
prison_jail_rate_since_1990 <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/blob/main/us-prison-jail-rates-1990.csv?raw=true")
prison_jail_rate_since_1990_WA <- read.csv("https://github.com/melaniewalsh/Neat-Datasets/raw/main/us-prison-jail-rates-1990-WA.csv")

# Five Focus Summary Stats

# 1: What is the average value of those jailed across all the counties per year?

average_jail_pop_per_year <- jail_pop %>%
  group_by(year) %>%
  summarize(average_jail_pop = mean(total_pop, na.rm = TRUE))

average_jail_pop_per_year

# 2: What is year has the highest incarceration rate? (prison)

prison_pop <- prison_pop %>%
  group_by(year) %>%
  summarize(total_prison_pop = sum(total_prison_pop, na.rm = TRUE),
            total_pop = sum(total_pop, na.rm = TRUE)) %>%
  mutate(incarceration_rate = total_prison_pop / total_pop)

year_highest_incarceration_rate <- prison_pop %>%
  filter(incarceration_rate == max(incarceration_rate)) %>%
  select(year, incarceration_rate)

year_highest_incarceration_rate

# 3: What is the rate of male v. female incarceration? (prison)

prison_pop_gender_rates <- prison_jail_rate %>%
  select(year, male_prison_pop_rate, female_prison_pop_rate) %>%
  group_by(year) %>%
  summarize(male_incarceration_rate = mean(male_prison_pop_rate, na.rm = TRUE),
            female_incarceration_rate = mean(female_prison_pop_rate, na.rm = TRUE))

prison_pop_gender_rates

# 4: What is the which state has the highest rate of incarceration?
prison_jail_rate_clean <- na.omit(prison_jail_rate_since_1990)

state_rates <- prison_jail_rate_clean %>%
  group_by(state) %>%
  summarise(
    total_incarceration_rate = sum(total_prison_pop_rate, total_jail_pop_rate)
  )

highest_incarceration_state <- state_rates %>%
  slice(which.max(total_incarceration_rate)) %>%
  pull(state)

highest_incarceration_state

# 5: What race has the highest incarceration rate?

prison_jail_rate_clean <- na.omit(prison_jail_rate_since_1990)

race_rates <- prison_jail_rate_clean %>%
  summarise(
    total_aapi_incarceration_rate = sum(aapi_prison_pop_rate, aapi_jail_pop_rate, na.rm = TRUE),
    total_black_incarceration_rate = sum(black_prison_pop_rate, black_jail_pop_rate, na.rm = TRUE),
    total_latinx_incarceration_rate = sum(latinx_prison_pop_rate, latinx_jail_pop_rate, na.rm = TRUE),
    total_native_incarceration_rate = sum(native_prison_pop_rate, native_jail_pop_rate, na.rm = TRUE),
    total_white_incarceration_rate = sum(white_prison_pop_rate, white_jail_pop_rate, na.rm = TRUE)
  )

highest_incarceration_race <- names(race_rates)[-1][which.max(unlist(race_rates[-1]))]

highest_incarceration_race

print("Average jail population per year: ")
print(average_jail_pop_per_year)
cat("\n\n")

print("Year with the highest incarceration rate: ")
print(year_highest_incarceration_rate)
cat("\n\n")

print("Prison Population by Gender Rates: ")
print(prison_pop_gender_rates)
cat("\n\n")

print("The state with the highest incarceration: ")
print(highest_incarceration_state)
cat("\n\n")

print("The race with the highest incarceration: ")
print(highest_incarceration_race)


prison_jail_rate_since_1990