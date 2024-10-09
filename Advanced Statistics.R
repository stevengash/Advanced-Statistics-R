# Load required libraries
library(readxl)
library(ggplot2)
library(moments)
library(car)
library(MASS)
library(qcc)

# Read the data
data <- read_excel("Stat_data.xlsx")

colnames(data)

# 1. Identify the type of each parameter (Qualitative & Quantitative).
qualitative_vars <- c("Job Level", "Sector", "Education", "Discipline")
quantitative_vars <- c("Age", "Salary", "Customer Satisfaction")
# 2. Create summary table for Job Level.
summary_job_level <- table(data$`Job Level`)
print(summary_job_level)


# 3. Draw bar graph for Education.
ggplot(data, aes(x = Education)) +
  geom_bar(fill = "steelblue") +
  labs(title = "Education Distribution",
       x = "Education",
       y = "Frequency")

# 4. Draw pie chart for Sector.
ggplot(data, aes(x = "", fill = Sector)) +
  geom_bar(width = 1) +
  coord_polar("y", start=0) +
  labs(title = "Sector Distribution")

# 5. Draw a histogram for salary.
ggplot(data, aes(x = Salary)) +
  geom_histogram(binwidth = 2000, fill = "skyblue", color = "black") +
  labs(title = "Salary Distribution",
       x = "Salary",
       y = "Frequency")
# Load the psych package
library(psych)

# 6. Calculate descriptive statistics of Salary
salary_stats <- describe(data$Salary)
print(salary_stats)

shapiro.test(data$Salary)

# 7. Draw box blot for Age and determine the existence of outliers.
ggplot(data, aes(y = Age)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Boxplot of Age")

# 8. Draw a Pareto chart for total salary of each Discipline & present your conclusion about the vital few.
#pareto_chart <- qcc(data$Salary, type = "pareto.chart")
# Calculate total salary for each discipline
total_salary_discipline <- aggregate(Salary ~ Discipline, data = data, FUN = sum)
total_salary_discipline <- total_salary_discipline[order(total_salary_discipline$Salary, decreasing = TRUE), ]

# Calculate cumulative percentage
total_salary_discipline$cumulative_percentage <- cumsum(total_salary_discipline$Salary) / sum(total_salary_discipline$Salary) * 100

# Plot Pareto chart
barplot(total_salary_discipline$Salary, names.arg = total_salary_discipline$Discipline, 
        col = "skyblue", main = "Pareto Chart of Total Salary by Discipline",
        ylab = "Total Salary", xlab = "Discipline", las = 2)
par(new = TRUE)
plot(total_salary_discipline$cumulative_percentage, type = "o", col = "red", axes = FALSE, xlab = "", ylab = "", ylim = c(0, 100), lwd = 2)
axis(side = 4)
mtext("Cumulative Percentage", side = 4, line = 3)
legend("topright", legend = c("Total Salary", "Cumulative Percentage"), col = c("skyblue", "red"), lty = c(1, 1), lwd = c(2, 2))


# Question 2
# A. TV Set Factory
mu_tv <- 3500
sigma_tv <- 200

# 1.
pnorm(3350, mean = mu_tv, sd = sigma_tv)

# 2.
1 - pnorm(3750, mean = mu_tv, sd = sigma_tv)

# 3.
pnorm(3750, mean = mu_tv, sd = sigma_tv) - pnorm(3350, mean = mu_tv, sd = sigma_tv)

# 4.
qnorm(0.95, mean = mu_tv, sd = sigma_tv)

# B. Bank
mu_bank <- 4.78
sigma_bank <- 1.32

# 1.
pnorm(10, mean = mu_bank, sd = sigma_bank)

# 2.
1 - pnorm(15, mean = mu_bank, sd = sigma_bank)

# 3.
pnorm(15, mean = mu_bank, sd = sigma_bank) - pnorm(10, mean = mu_bank, sd = sigma_bank)

# 4.
qnorm(0.95, mean = mu_bank, sd = sigma_bank)

# C. Supplier
mu_supplier <- 22.5
sigma_supplier <- 3.2

# 1.
pnorm(20, mean = mu_supplier, sd = sigma_supplier)

# 2.
qnorm(0.95, mean = mu_supplier, sd = sigma_supplier)

# Question 3
# A. Calculate capability indices
# Create a vector with the delivery time data
delivery_time_data <- c(
  29.73, 29.34, 34.07, 27.62, 28.78, 30.84, 32.96, 30.01, 29.03, 27.34,
  26.27, 30.08, 30.09, 35.88, 33.24, 34.04, 32.11, 35.74, 28.52, 25.63,
  36.87, 29.32, 27.71, 27.79, 32.46, 31.60, 28.72, 23.38, 30.23, 28.15,
  30.53, 36.42, 40.31, 27.16, 29.51, 28.66, 36.25, 32.18, 31.43, 33.19,
  31.67, 34.30, 33.59, 28.56, 25.83, 29.98, 35.38, 30.33, 28.17, 26.82,
  28.23, 33.34, 33.32, 34.48, 27.93, 29.26, 28.76, 31.34, 27.61, 33.66,
  26.04, 30.52, 34.20, 31.73
)

# Calculate capability indices
capability_indices <- function(data, lower_spec, upper_spec) {
  cpk <- min((mean(data) - lower_spec) / (3 * sd(data)), (upper_spec - mean(data)) / (3 * sd(data)))
  cpl <- (mean(data) - lower_spec) / (3 * sd(data))
  cpu <- (upper_spec - mean(data)) / (3 * sd(data))
  
  indices <- list(Cpk = cpk, Cpl = cpl, Cpu = cpu)
  return(indices)
}

# Assuming the specification limits for delivery time are 25 and 35 days
lower_spec <- 25
upper_spec <- 35

# Calculate capability indices for Delivery_Time
indices <- capability_indices(delivery_time_data, lower_spec, upper_spec)
print(indices)

# B. Recommendations to improve supplier performance

# Question 4
# Load necessary library for transformations
library(car)

# Define the Cycle Time data
cycle_time_data <- c(
  10.05, 11.16, 7.04, 25.09, 12.56, 17.36, 7.33, 11.35, 9.31, 26.56,
  9.45, 16.31, 19.85, 14.68, 18.47, 22.55, 12.15, 18.42, 16.96, 22.36,
  9.26, 13.94, 8.23, 12.04, 11.26, 10.45, 29.34, 16.06, 25.47, 23.26,
  10.64, 9.90, 14.17, 16.45, 9.74, 32.99, 10.57
)

# A. Transform Cycle Time data using Box-Cox transformation
# Find the lambda parameter for Box-Cox transformation
result <- boxcox(cycle_time_data ~ 1)  # Using ~ 1 to specify no predictor variables
lambda <- result$x[which.max(result$y)]
print(lambda)

# Apply Box-Cox transformation
transformed_boxcox <- result$y
print(transformed_boxcox)


# Question 5

# Load necessary library for reading excel files
library(readxl)

# Read the data from the "Sales Data" sheet
car_factory_data <- read_excel("Stat_data.xlsx", sheet = "Car Factory", skip = 1)

# Extract relevant columns
daily_production <- car_factory_data$`Number of  cars produced`
defective_cars <- car_factory_data$`Number of fixed cars`
car_defects <- car_factory_data$`Number of fixed parts`

# A. Provide comments on the stability of daily production
# Calculate mean and standard deviation of daily production
mean_daily_production <- mean(daily_production)
sd_daily_production <- sd(daily_production)

# Check if daily production is stable based on variability
if (sd_daily_production / mean_daily_production <= 0.1) {
  print("Daily production is stable.")
} else {
  print("Daily production is not stable.")
}

# B. Provide comments on the stability of defective cars
# Calculate mean and standard deviation of defective cars
mean_defective_cars <- mean(defective_cars)
sd_defective_cars <- sd(defective_cars)

# Check if defective cars are stable based on variability
if (sd_defective_cars / mean_defective_cars <= 0.1) {
  print("Defective cars are stable.")
} else {
  print("Defective cars are not stable.")
}

# C. Provide comments on the stability of car defects
# Calculate mean and standard deviation of car defects
mean_car_defects <- mean(car_defects)
sd_car_defects <- sd(car_defects)

# Check if car defects are stable based on variability
if (sd_car_defects / mean_car_defects <= 0.1) {
  print("Car defects are stable.")
} else {
  print("Car defects are not stable.")
}


# Question 6
# Define the sales data
sales_data <- data.frame(
  Quarter = 1:18,
  Sales = c(45000, 40000, 55000, 85000, 80000, 110000, 125000, 115000, 155000, 160000,
            185000, 175000, 210000, 230000, 255000, 245000, 265000, 275000)
)

# A. Provide comments on the sales trend
# Plot the sales data
plot(sales_data$Quarter, sales_data$Sales, type = "l", xlab = "Quarter", ylab = "Sales", main = "Sales Trend")

# Fit a linear regression model to assess the trend
sales_lm <- lm(Sales ~ Quarter, data = sales_data)
summary(sales_lm)

# B. Provide comments on the sales seasonality
# Plot seasonal components using decomposition
sales_decomp <- decompose(ts(sales_data$Sales, frequency = 4))
plot(sales_decomp)

# C. Provide comments on the obtained accuracy model
# Calculate residuals
residuals <- residuals(sales_lm)

# Plot residuals
plot(residuals, type = "l", xlab = "Quarter", ylab = "Residuals", main = "Residuals Plot")

# D. Predict the upcoming 3 quarter sales
# Create a data frame for the upcoming quarters
future_quarters <- data.frame(Quarter = 19:21)

# Predict sales for the upcoming quarters using the linear regression model
predicted_sales <- predict(sales_lm, newdata = future_quarters)
print(predicted_sales)

