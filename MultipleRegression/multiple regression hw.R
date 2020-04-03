##############reading the dataset################################
who <- read.csv("C:/Users/prera/Downloads/Life_Expectancy_Data.csv")
head(who)


install.packages("corrplot")
library(corrplot)
library(dplyr)
install.packages("FFally", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(FFally)
install.packages("GGally", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(GGally)



#############Dimesion of the dataset############################

dim(who)

##############     TOP 10 DEVELPED & DEVELOPING Countires      ######################

status.of.countries <- who[(who$Status %in% c("Developing") & who$Life.expectancy<55) | (who$Status %in% c("Developed") & who$Life.expectancy>80) ,]
dim(status.of.countries)
View(status.of.countries)

class(status.of.countries)
head(status.of.countries)
#View(status.of.countries)
WHONew<-status.of.countries
#resting the index values
row.names(WHONew) <- NULL
#View(WHONew)
dim(WHONew)

###################### CLEANING THE DATA ######################################
# For 347 rows running the for loop for chechking any NA values and replacing it with the mean of the 
# particular country.
for(i in 1:347)
{
  if(is.na(WHONew$Alcohol[i]))
  {
    WHONew$Alcohol[i] <- with(WHONew, mean(WHONew$Alcohol[Country == WHONew$Country[i]], na.rm = TRUE))
  }
}
for(i in 1:347)
{
  if(is.na(WHONew$Hepatitis.B[i]))
  {
    WHONew$Hepatitis.B[i] <- with(WHONew, mean(WHONew$Hepatitis.B[Country == WHONew$Country[i]], na.rm = TRUE))
  }
}
for(i in 1:347)
{
  if(is.na(WHONew$Total.expenditure[i]))
  {
    WHONew$Total.expenditure[i] <- with(WHONew, mean(WHONew$Total.expenditure[Country == WHONew$Country[i]], na.rm = TRUE))
  }
}
dim(WHONew)
#View(WHONew)

# Deleting the Empty rows where there is no data present.
new.life<- na.omit(WHONew)
dim(new.life)

View(new.life)

############ Finding the summary or the distribution of the Dataset ##################

g<-lm(Life.expectancy~Adult.Mortality + infant.deaths + Alcohol+percentage.expenditure+Hepatitis.B+
        Measles+BMI+under.five.deaths+Polio+Total.expenditure+Diphtheria+HIV.AIDS+GDP+Population+
        thinness..1.19.years+thinness.5.9.years+Income.composition.of.resources+Schooling, data=new.life) 
summary(g)

coefficients(g)


##################PLOTTING FOR CORREALTION######################################
ggpairs(data=new.life, title="Life Expectancy")
confint(g,level=0.95)
# Predicted Values
fitted(g)
residuals(g)
#Anova Table
anova(g) # sum of squares from diff variables
u=vcov(g)
head(u)
v=cov2cor(vcov(g))
head(v)
temp <- influence.measures(g) # the one with the stars 
temp
View(temp)
#diagnostic plots
plot(g)


# Assessing Outliers
install.packages("car")
library(car)
outlierTest(g)
qqPlot(g, main="QQ Plot")# it says that they have two sd diff and mmost of it should be between 
leveragePlots(g) # leverage plots
# Influential Observations
# added variable plots
avPlots(g) # shows for which quantity which are outliers
# Cook's D plot
# identify D values > 4/(n-k-1)
cutoff <- 4/((nrow(new.life)-length(g$coefficients)-2))
plot(g, which=4, cook.levels=cutoff)
# Influence Plot
influencePlot(g, id.method="identify", main="Influence Plot", sub="Circle size is proportial to Cook's Distance" )
# Normality of Residuals
# qq plot for studentized resid
qqPlot(g, main="QQ Plot")
# distribution of studentized residuals
install.packages("MASS")
library(MASS)
sresid <- studres(g)
hist(sresid, freq=FALSE,
     main="Distribution of Studentized Residuals")
xfit<-seq(min(sresid),max(sresid),length=40)
yfit<-dnorm(xfit)
lines(xfit, yfit)
#Non-constant Error Variance
# Evaluate homoscedasticity
# non-constant error variance test
ncvTest(g)
# plot studentized residuals vs. fitted values
spreadLevelPlot(g)
#Multi-collinearity
# Evaluate Collinearityssss
vif(g) # variance inflation factors
sqrt(vif(g)) > 2 # problem? # anytg more than 2 is a prob here disp and wt might be corelated so it might be a problem
#Nonlinearity
# component + residual plot
crPlots(g)
# Ceres plots
ceresPlots(g)
# compare models
f1<-g
# Removing population
g1<-lm(Life.expectancy~Adult.Mortality + infant.deaths + Alcohol+percentage.expenditure+Hepatitis.B+
         Measles+BMI+under.five.deaths+Polio+Total.expenditure+Diphtheria+HIV.AIDS+GDP+
         thinness..1.19.years+thinness.5.9.years+Income.composition.of.resources+Schooling, data=new.life) 
anova(g1)
#Removing Total Expenditure
g2<-lm(Life.expectancy~Adult.Mortality + infant.deaths + Alcohol+percentage.expenditure+Hepatitis.B+
         Measles+BMI+under.five.deaths+Polio+Diphtheria+HIV.AIDS+GDP+
         thinness..1.19.years+thinness.5.9.years+Income.composition.of.resources+Schooling, data=new.life) 
anova(g2)
anova(f1, g2)
step <- stepAIC(g, direction="both")# step1 take corelation. step2 take highest corellation
step$anova # display results
predict.lm(g, data.frame(Adult.Mortality=66, infant.deaths=1 ,Alcohol=10.62,percentage.expenditure=7172.275229,Hepatitis.B=94,
                         Measles=104,BMI=63.4,under.five.deaths=	1,Polio=92,Total.expenditure=9.5,Diphtheria=92,HIV.AIDS=0.1,GDP=42742.99898,Population=216917,
                         thinness..1.19.years=0.7,thinness.5.9.years=0.6,Income.composition.of.resources=0.925,Schooling=19.1) )


