# Structured Pyramid Analysis Plans
 The rationale for using a structured plan is to avoid the very inefficient process of exploring a data set aimlessly, without hypotheses. This is especially true for analytics teams, that would have a difficult time collaborating without some kind of roadmap to use for direction.
 An SPAP is outlined in the following image. The terms are defined beneath it.
 
 
 ![sasp_ideal](https://user-images.githubusercontent.com/60514533/74491635-35a29900-4e9a-11ea-9df6-32c54d0a7e5a.PNG)

#### SPAP for our model is as follows:

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

# Key Performance Indicator


|Sr No. |Variable Name            |Description                                                                                  |
|-------|-------------------------|---------------------------------------------------------------------------------------------|
|1.	    |Life expectancy          |Life Expectancy in age                                                                       |
|2.	    |Status                   |Developed or not Developed Country                                                           |
|3.	    |Adult Mortality          |Mortality Rates of both sexes                                                                |
|4.	    |Infant deaths            |Number of Infant Deaths per 1000 population                                                  |
|5.	    |Alcohol                  |Alcohol, recorded per capita (15+) consumption                                               |
|6.	    |Percentage expenditure   |Expenditure on health as a percentage of Gross Domestic Product per capita(%)                |
|7.     |BMI                      |Body Mass Index of entire population                                                         |
|8.     |Under-five deaths        |Number of under-five deaths per 1000 population                                              |
|9.     |Total expenditure        |General government expenditure on health as a percentage of total government expenditure (%) |
|10.    |HIV/AIDS                 |Deaths per 1 000 live births HIV/AIDS (0-4 years)                                            |
|11.    |GDP                      |Domestic Product per capita (in USD)                                                         |
|12.    |Population               |Population of the country                                                                    |
|13.    |Income composition of resources      |Income composition of resourcesHuman Development Index                                       |
|14.    |Schooling                |Number of years of Schooling(years)                                                          |
 
## Summary Analysis
This provides the summary distribution of dataset of how widely the data has been spread.

![summary](https://user-images.githubusercontent.com/60514533/74390812-5999a800-4dd0-11ea-8bac-2545ac6d2dca.PNG)

## Regression Analysis

We know that lower the p-value (<0.05) , more is the significance. From the below analysis we can observe the p values which may more significant role than the others.

![WhatsApp Image 2020-02-13 at 2 17 20 PM](https://user-images.githubusercontent.com/60514533/74492121-c29a2200-4e9b-11ea-8037-8cde16504fa7.jpeg)


# Correlation Scatter Plot matrix
This plot shows the correlation of target variable vs all dependent variables.Correlation ranges from -1 to 1.Value towards -1 are negatively correlated and values towards 1 are positively correlated and if the correlation is 0 then there is no relationship between the variables.

We can observe that Adult mortality ,HIV aids,Income composition,Schooling Alcohol,Percentage expenditure,GDP are positivly correlated while population,Infant deaths and Under five deaths are negativly correlated.

![WhatsApp Image 2020-02-13 at 7 53 32 PM](https://user-images.githubusercontent.com/60514533/74492594-6932f280-4e9d-11ea-9b34-6aeb79a275d2.jpeg)


#### Code:                                                                                            

![WhatsApp Image 2020-02-12 at 7 32 40 PM](https://user-images.githubusercontent.com/60514533/74390220-982e6300-4dce-11ea-95b2-21970f0119e1.jpeg)
