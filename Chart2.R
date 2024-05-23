# Load necessary libraries
library(ggplot2)

# Function to remove outliers using IQR method
remove_outliers <- function(df, var) {
  q1 <- quantile(df[[var]], 0.25, na.rm = TRUE)
  q3 <- quantile(df[[var]], 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  lower_bound <- q1 - 1.5 * iqr
  upper_bound <- q3 + 1.5 * iqr
  df <- subset(df, df[[var]] >= lower_bound & df[[var]] <= upper_bound)
  return(df)
}

# Subset the data for Texas (TX) and Washington (WA)
tx_data <- subset(prison_jail_rate_since_1990, state == "TX")
wa_data <- subset(prison_jail_rate_since_1990, state == "WA")

# Remove outliers for Texas (TX) and Washington (WA) data
tx_data_no_outliers <- remove_outliers(tx_data, "total_jail_pop_rate")
wa_data_no_outliers <- remove_outliers(wa_data, "total_jail_pop_rate")

# Plotting with trendlines
ggplot() +
  geom_point(data = tx_data_no_outliers, aes(x = total_jail_pop_rate, y = total_prison_pop_rate, color = "TX"), size = 3) +
  geom_point(data = wa_data_no_outliers, aes(x = total_jail_pop_rate, y = total_prison_pop_rate, color = "WA"), size = 3) +
  geom_smooth(data = tx_data_no_outliers, aes(x = total_jail_pop_rate, y = total_prison_pop_rate), method = "lm", se = FALSE, color = "lightblue") +
  geom_smooth(data = wa_data_no_outliers, aes(x = total_jail_pop_rate, y = total_prison_pop_rate), method = "lm", se = FALSE, color = "lightcoral") +
  labs(title = "Relationship Between Jail Population Rate and Prison Population Rate",
       x = "Total Jail Population Rate",
       y = "Total Prison Population Rate",
       color = "State") +
  scale_color_manual(values = c("TX" = "blue", "WA" = "red"),
                     name = "State") +
  theme_minimal()
