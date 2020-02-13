# Structured Pyramid Analysis Plans


![WhatsApp Image 2020-02-12 at 7 05 14 PM](https://user-images.githubusercontent.com/60514533/74389003-e6d9fe00-4dca-11ea-8b01-12a2c237abcb.jpeg)

#### SMART Goal:
Analyzing the different aspects such as growth of the country, population density, Economic condition, Mortality rates of the country and various other factors which can could lead to the increment or decrement of the life expectancy 
#### Dependent Variables:
Life Expectancy
#### Specific Questions to Investigate:
1.Impact of life expectancy on developing countries.                                                                                       
2.Impact of life expectancy on developed countries.
#### Independent Variables:
Status, Adult Mortality, infant deaths, percentage expenditure, under-five deaths, Alcohol, HIV/AIDS, BMI, Total expenditure, GDP, Population, Income composition of resources, Schooling.
 
# Correlation Scatter Plot matrix
This plot shows the correlation of target variable vs all dependent variables.


#### Code:
install.packages("dplyr")
library(dplyr)
dat
newdata <- na.omit(dat)
newdata2 <- select(newdata, -c(Hepatitis.B))
newdata3 <- select(newdata2, -c(1,2,3,9,10,12,14,18,19))
newdata3 
cor(newdata3[,1:11])
install.packages("GGally")
library(GGally)
ggpairs(as.data.frame(newdata3[,1:11]))
