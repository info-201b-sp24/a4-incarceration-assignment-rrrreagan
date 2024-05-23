
library(ggplot2)

# Sample data to simulate the dataset (replace this with your actual data)
data <- na.omit(prison_pop_gender_rates)

# Create the bar plot
ggplot(data, aes(x = factor(year))) +
  geom_bar(aes(y = male_incarceration_rate, fill = "Male Incarceration Rate"), stat = "identity", position = "dodge", width = 0.4) +
  geom_bar(aes(y = female_incarceration_rate, fill = "Female Incarceration Rate"), stat = "identity", position = "dodge", width = 0.4) +
  scale_fill_manual(values = c("Male Incarceration Rate" = "cornflowerblue", "Female Incarceration Rate" = "darkred")) +
  labs(x = "Year", y = "Incarceration Rate per 100,000 Population", 
       title = "Male vs Female Incarceration Rates Over Time", 
       fill = "Incarceration Rate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 85, hjust = 1, size = 7))
