# Factor Analysis
#Exploratory Factor Analysis (EFA) is a statistical technique that is used to identify 
#the latent relational structure among a set of variables and narrow down to smaller number 
#of variables. This essentially means that the variance of large number of variables can be 
#described by few summary variables, i.e., factors.
# Importing the dataset
install.packages("corrplot")
library(corrplot)
library(dplyr)
#For plotting the scatter density plots
library(GGally)

##############reading the dataset################################

who <- read.csv("C:/Users/prera/Downloads/Euroemp.csv")
head(who)

#############Dimesion of the dataset############################

dim(who)

##############     TOP 10 DEVELPED & DEVELOPING Countires      ######################

status.of.countries <- who[(who$Status %in% c("Developing") & who$Life.expectancy<55) | (who$Status %in% c("Developed") & who$Life.expectancy>80) ,]
dim(status.of.countries)
#View(status.of.countries)

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


fac.eff <- new.life[ ,c(4,5,7,11,16,17,19,20,21,22)]

View(fac.eff)
attach(fac.eff)
fac.eff[1]
# Computing Correlation Matrix
corrm.fac.eff <- cor(fac.eff[-1])
corrm.fac.eff
plot(corrm.fac.eff)
new.life_pca <- prcomp(fac.eff[-1], scale=TRUE)
summary(new.life_pca)
plot(new.life_pca)
# A table containing eigenvalues and %'s accounted, follows. Eigenvalues are the sdev^2
(eigen.fac.eff <- round(new.life_pca$sdev^2,2))
names(eigen.fac.eff) <- paste("PC",1:9,sep="")
eigen.fac.eff
sumlambdas <- sum(eigen.fac.eff)
sumlambdas
cumvar.fac.eff <- cumsum(propvar)
propvar <- round(eigen.fac.eff/sumlambdas,2)
propvar
cumvar.fac.eff <- cumsum(propvar)
cumvar.fac.eff
matlambdas <- rbind(eigen.fac.eff,propvar,cumvar.fac.eff)
matlambdas
rownames(matlambdas) <- c("Eigenvalues","Prop. variance","Cum. prop. variance")
rownames(matlambdas)
eigvec.emp <- new.life_pca$rotation
print(new.life_pca)
#Considering the observation of the standard deviation, we initially tried considering four 
#components as the SD after four components are comparatively higher also considering the 
#elbow diagram done in the previous section justifies for taking into account four components.
# Taking the first four PCs to generate linear combinations for all the variables with four factors
pcafactors.emp <- eigvec.emp[,1:4]
pcafactors.emp
# Multiplying each column of the eigenvector's matrix by the square-root of the corresponding eigenvalue in order to get the factor loadings
unrot.fact.emp <- sweep(pcafactors.emp,MARGIN=2,new.life_pca$sdev[1:4],`*`)
unrot.fact.emp
# Computing communalities
communalities.emp <- rowSums(unrot.fact.emp^2)
communalities.emp
# Performing the varimax rotation. The default in the varimax function is norm=TRUE thus, Kaiser normalization is carried out
rot.fact.emp <- varimax(unrot.fact.emp)
View(unrot.fact.emp)
rot.fact.emp
# The print method of varimax omits loadings less than abs(0.1). In order to display all the loadings, it is necessary to ask explicitly the contents of the object $loadings
fact.load.emp <- rot.fact.emp$loadings[1:9,1:4]
fact.load.emp

scale.emp <- scale(fac.eff[-1])
scale.emp
as.matrix(scale.emp)%%fact.load.emp%%solve(t(fact.load.emp)%*%fact.load.emp)

library(psych)
install.packages("psych", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(psych)
# On 4 factors analysis
fit.pc <- principal(fac.eff[-1], nfactors=4, rotate="varimax")
# On 3 factors analysis
fit.pc1 <- principal(fac.eff[-1], nfactors=3, rotate="varimax")

fit.pc
fit.pc1
round(fit.pc$values, 3)
round(fit.pc1$values, 3)
fit.pc$loadings
fit.pc1$loadings
# Loadings with more digits
for (i in c(1,3,2,4)) { print(fit.pc$loadings[[1,i]])}  # 4 components
for (i in c(1,3,2,4)) { print(fit.pc1$loadings[[1,i]])} # 3 components
# Communalities
fit.pc$communality
fit.pc1$communality
# Rotated factor scores, Notice the columns ordering: RC1, RC3, RC2 and RC4
fit.pc$scores
#fit.pc1$scores
# Play with FA utilities

fa.parallel(fac.eff[-1]) # See factor recommendation
fa.plot(fit.pc) # See Correlations within Factors
#fa.plot(fit.pc1)

fa.diagram(fit.pc) 
fa.diagram(fit.pc1)# Visualize the relationship for 4 components analysis
#We have observed 9 variables schooling, BMI, income composition of resources, Alcohol, 
#thinness 5.9 years, thinness 1.91 years, HIV/AIDS, Adult Mortality, GDP. We hypothesize 
#that there are four unobserved latent factors (RC1, RC2, RC3, RC4) that underly the observed
#variables as described in this diagram. Schooling, BMI, income composition of resources,
#Alcohol loads on RC1 with loadings 0.8, 0.8, 0.8 and 0.9 respectively. Thinness 5.9 years, 
#thinness 1.91 years loads on RC2 with loadings 0.9 and 0.9. HIV/AIDS, Adult Mortality on 
#RC3 with loadings 0.9 and 0.8.GDP loads on RC4 with loadings of 0.9.

#In a three-component analysis, we see that the common variance for the GDP and adult mortality 
#is comparatively less considering the four component analysis for the same. As the unique 
#variance of 0.4 GDP and unique variance of 0.3 Adult mortality is given away in 3 component 
#analysis. Where as, in 4 component analysis we obsevre the unique vareince of GDP, Adult Mortality
#is only 0.1 and 0.2 respectievly is given away. Therefore, we take Component as 4 for analysis.

vss(fac.eff[-1]) # See Factor recommendations for a simple structure