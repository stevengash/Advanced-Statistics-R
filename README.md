# Advanced-Statistics-R
# Statistical Analysis Project

This repository contains a comprehensive statistical analysis project using R. The analysis involves various statistical techniques and visualizations to explore and interpret data.

## R Version

- **R Version**: 4.3.1 (2023-06-16 ucrt) - "Beagle Scouts"
- **Platform**: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY. You are welcome to redistribute it under certain conditions. For more information, type `license()` or `licence()` in R.

## Libraries Used

The following libraries were used in the analysis:

- `readxl`: For reading Excel files
- `ggplot2`: For data visualization
- `moments`: For statistical moments calculations
- `car`: For various statistical functions
- `MASS`: For additional statistical functions
- `qcc`: For Quality Control Charts
- `psych`: For descriptive statistics

## Data

The primary dataset used in this analysis is stored in the file `Stat_data.xlsx`, which includes various statistical variables such as:

- Name
- Job Level
- Sector
- Education
- Discipline
- Age
- Salary
- Customer Satisfaction

### Analysis Overview

1. **Parameter Identification**: 
   - Differentiation between qualitative and quantitative variables.
   
2. **Summary Statistics**: 
   - Summary tables for job levels and descriptive statistics for salary.
   
3. **Visualizations**: 
   - Bar graphs for education distribution.
   - Pie charts for sector distribution.
   - Histograms for salary distribution.
   - Box plots for age to identify outliers.
   - Pareto charts for salary distribution by discipline.

4. **Statistical Testing**:
   - Shapiro-Wilk test for normality of salary data.

5. **Capability Indices**:
   - Calculated capability indices for delivery time data.

6. **Box-Cox Transformation**: 
   - Applied Box-Cox transformation on cycle time data to achieve normality.

7. **Sales Trend Analysis**:
   - Linear regression modeling for sales data across quarters.
   - Seasonal decomposition of sales data to identify trends and seasonality.

## Usage

To replicate this analysis, ensure that you have R and the required libraries installed. Clone this repository and set your working directory to the location of the dataset. Run the provided R scripts to perform the analysis.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributors

- [Your Name](https://github.com/your-github-username) - Project Author
