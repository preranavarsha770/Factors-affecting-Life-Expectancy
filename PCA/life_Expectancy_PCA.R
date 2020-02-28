# Importing the dataset
install.packages("corrplot")
library(corrplot)
library(dplyr)
#For plotting the scatter density plots
library(GGally)

##############reading the dataset################################

who <- read.csv("C:/Users/prera/Downloads/Life_Expectancy_Data.csv")
head(who)

#############Dimesion of the dataset############################

dim(who)

##############     TOP 10 DEVELPED & DEVELOPING Countires      ######################

status.of.countries <- who[(who$Status %in% c("Developing") & who$Life.expectancy<55) | (who$Status %in% c("Developed") & who$Life.expectancy>85) ,]
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

#View(new.life)

############ Finding the summary or the distribution of the Dataset ##################

g<-lm(Life.expectancy~Adult.Mortality + infant.deaths + Alcohol+percentage.expenditure+Hepatitis.B+
        Measles+BMI+under.five.deaths+Polio+Total.expenditure+Diphtheria+HIV.AIDS+GDP+Population+
        thinness..1.19.years+thinness.5.9.years+Income.composition.of.resources+Schooling, data=new.life) 
summary(g)

##################PLOTTING FOR CORREALTION######################################
attach(new.life)

plot(Life.expectancy, Alcohol, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="Alcohol")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,Adult.Mortality, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="Adult.Mortality")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,Schooling, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="Schooling")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,percentage.expenditure, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="percentage.expenditure")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,Income.composition.of.resources, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="Income.composition.of.resources")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,BMI, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="BMI")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,HIV.AIDS, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="HIV.AIDS")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,GDP, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="GDP")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,thinness..1.19.years, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="thinness..1.19.years")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

plot(Life.expectancy,GDP, pch=c(1,4)[as.numeric(Status)],xlab="Life.expectancy",ylab="thinness.5.9.years")
legend(158, 233, legend=c("Developed","Developing"), pch=c(4,1), horiz=TRUE)

# deleting the first three column as it is not the part of the dependent or independent variables
# deleting is onlt done to check the correlation of the varibles.

corr.plot <- select(new.life, -c(1,2,3))
#View(WHONew)
dim(corr.plot)
ggpairs(as.data.frame(corr.plot[,1:length(corr.plot)]))

###################### CORRELATION TESTING ######################################
#The Pearson product-moment correlation coefficient (Pearson's correlation, for short) is a measure of the strength and direction of association that exists between two variables measured on at least an interval scale.

cor.test(new.life$Life.expectancy, new.life$Adult.Mortality)
cor.test(new.life$Life.expectancy, new.life$infant.deaths)
cor.test(new.life$Life.expectancy, new.life$ Alcohol)
cor.test(new.life$Life.expectancy, new.life$percentage.expenditure)
cor.test(new.life$Life.expectancy, new.life$Adult.Mortality)
cor.test(new.life$Life.expectancy, new.life$infant.deaths)
cor.test(new.life$Life.expectancy, new.life$Income.composition.of.resources)
cor.test(new.life$Life.expectancy, new.life$Schooling)

###################### Plotting done for all the    ##################################

dim(new.life)
life <- new.life[ ,c(4,5,7,11,16,17,19,20,21,22)]
dim(life)
labs.diagonal <- c("Life.expectancy","Adult.Mortality","Alcohol","BMI","HIV.AIDS","GDP","thinness..1.19.years","thinness.5.9.years","Income.composition.of.resources","Schooling")
pairs(life, labels=labs.diagonal, pch=c(1,16)[as.numeric(Status)],font.labels = )
par(xpd=NA)
legend(-0.001,0.07,c("Developed","Developing"),pch=c(1,16), cex=0.7, text.font=2) # gives the legend points the correct symbol

###########  TESTING OF COVARAINCE################

#Take a subset by Status
cov(subset(new.life, Status == "Developed")[,c("Life.expectancy","Adult.Mortality","Alcohol","BMI","HIV.AIDS","GDP","thinness..1.19.years","thinness.5.9.years","Income.composition.of.resources","Schooling")])
cov(subset(new.life, Status == "Developing")[,c("Life.expectancy","Adult.Mortality","Alcohol","BMI","HIV.AIDS","GDP","thinness..1.19.years","thinness.5.9.years","Income.composition.of.resources","Schooling")])

cov(new.life[, c("Life.expectancy","Adult.Mortality","BMI","HIV.AIDS","GDP","thinness..1.19.years","thinness.5.9.years","Income.composition.of.resources","Schooling")])

###########  TESTING OF cHI SQUARE TEST   ################
##The chi-squared statistic is a single number that tells you how much difference exists between your observed counts and the counts you would expect if there were no relationship at all in the population.
chisq.test(table(new.life$Life.expectancy,new.life$Adult.Mortality))
chisq.test(table(new.life$Life.expectancy,new.life$Alcohol))
chisq.test(table(new.life$Life.expectancy,new.life$infant.deaths))
chisq.test(table(new.life$Life.expectancy,new.life$percentage.expenditure))
chisq.test(table(new.life$Life.expectancy,new.life$HIV.AIDS))
chisq.test(table(new.life$Life.expectancy,new.life$GDP))
chisq.test(table(new.life$Life.expectancy,new.life$Income.composition.of.resources))
chisq.test(table(new.life$Life.expectancy,new.life$Schooling))
chisq.test(table(new.life$Life.expectancy,new.life$BMI))

############  t test #######################
##A t-test is a type of inferential statistic used to determine if there is a significant difference between the means of two groups, which may be related in certain features.

#t-tests, one by one for Developed vs. developing
with(data=new.life,t.test(Life.expectancy[Status=="Developed"],Life.expectancy[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(Adult.Mortality[Status=="Developed"],Adult.Mortality[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(infant.deaths[Status=="Developed"],infant.deaths[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(HIV.AIDS[Status=="Developed"],HIV.AIDS[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(GDP[Status=="Developed"],GDP[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(thinness..1.19.years[Status=="Developed"],thinness..1.19.years[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(thinness.5.9.years[Status=="Developed"],thinness.5.9.years[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(Income.composition.of.resources[Status=="Developed"],Income.composition.of.resources[Status=="Developing"],var.equal=TRUE))
with(data=new.life,t.test(Schooling[Status=="Developed"],Schooling[Status=="Developing"],var.equal=TRUE))

#PCA------------------------------
life1 <- new.life[ ,c(5,7,11,16,17,19,20,21,22)]
cor(life1)
# Using prcomp to compute the principal components (eigenvalues and eigenvectors). With scale=TRUE, variable means are set to zero, and variances set to one
life_pca <- prcomp(life1,scale=TRUE)
life_pca
summary(life_pca)
(eigen_life <- life_pca$sdev^2)
names(eigen_life) <- paste("PC",1:9,sep="")
eigen_life
sumlambdas <- sum(eigen_life)
sumlambdas
propvar <- eigen_life/sumlambdas # eigan value/total varience
propvar #at this step we need to see till which PC we need to keep by adding the PC'S
cumvar_life <- cumsum(propvar)
cumvar_life
matlambdas <- rbind(eigen_life,propvar,cumvar_life)
rownames(matlambdas) <- c("Eigenvalues","Prop. variance","Cum. prop. variance")
round(matlambdas,4)
summary(life_pca)
life_pca$rotation
print(life_pca)
life_pca$x # this gives the new data set for our table
# Identifying the scores by their survival status
sparrtyp_pca <- cbind(data.frame(Status),life_pca$x)
sparrtyp_pca
# Means of scores for all the PC's classified by Survival status
tabmeansPC <- aggregate(sparrtyp_pca[,2:10],by=list(Status=new.life$Status),mean)# this tells mean which is a kind of t testS
tabmeansPC
tabmeansPC <- tabmeansPC[rev(order(tabmeansPC$Status)),]
tabmeansPC
tabfmeans <- t(tabmeansPC[,-1])
tabfmeans
colnames(tabfmeans) <- t(as.vector(tabmeansPC[1]))
tabfmeans
# Standard deviations of scores for all the PC's classified by Survival status
tabsdsPC <- aggregate(sparrtyp_pca[,2:10],by=list(Status=new.life$Status),sd)
tabfsds <- t(tabsdsPC[,-1])
colnames(tabfsds) <- t(as.vector(tabsdsPC[1]))
tabfsds
t.test(PC1~new.life$Status,data=sparrtyp_pca)
t.test(PC2~new.life$Status,data=sparrtyp_pca)
t.test(PC3~new.life$Status,data=sparrtyp_pca)
t.test(PC4~new.life$Status,data=sparrtyp_pca)
t.test(PC5~new.life$Status,data=sparrtyp_pca)
t.test(PC6~new.life$Status,data=sparrtyp_pca)
t.test(PC7~new.life$Status,data=sparrtyp_pca)
t.test(PC8~new.life$Status,data=sparrtyp_pca)
t.test(PC9~new.life$Status,data=sparrtyp_pca)
# F ratio tests
var.test(PC1~new.life$Status,data=sparrtyp_pca)
var.test(PC2~new.life$Status,data=sparrtyp_pca)
var.test(PC3~new.life$Status,data=sparrtyp_pca)
var.test(PC4~new.life$Status,data=sparrtyp_pca)
var.test(PC5~new.life$Status,data=sparrtyp_pca)
var.test(PC6~new.life$Status,data=sparrtyp_pca)
var.test(PC7~new.life$Status,data=sparrtyp_pca)
var.test(PC8~new.life$Status,data=sparrtyp_pca)
var.test(PC9~new.life$Status,data=sparrtyp_pca)


# Levene's tests (one-sided)
library(car)
(LTPC1 <- leveneTest(PC1~new.life$Status,data=sparrtyp_pca))
(LTPC1 <- leveneTest(PC1~new.life$Status,data=sparrtyp_pca))
(p_PC1_1sided <- LTPC1[[3]][1]/2)
(LTPC2 <- leveneTest(PC2~new.life$Status,data=sparrtyp_pca))
(p_PC2_1sided=LTPC2[[3]][1]/2)
(LTPC3 <- leveneTest(PC3~new.life$Status,data=sparrtyp_pca))
(p_PC3_1sided <- LTPC3[[3]][1]/2)
(LTPC4 <- leveneTest(PC4~new.life$Status,data=sparrtyp_pca))
(p_PC4_1sided <- LTPC4[[3]][1]/2)
(LTPC5 <- leveneTest(PC5~new.life$Status,data=sparrtyp_pca))
(p_PC5_1sided <- LTPC5[[3]][1]/2)
(LTPC6 <- leveneTest(PC6~new.life$Status,data=sparrtyp_pca))
(p_PC6_1sided <- LTPC6[[3]][1]/2)
(LTPC7 <- leveneTest(PC7~new.life$Status,data=sparrtyp_pca))
(p_PC7_1sided <- LTPC7[[3]][1]/2)
(LTPC8 <- leveneTest(PC8~new.life$Status,data=sparrtyp_pca))
(p_PC8_1sided <- LTPC8[[3]][1]/2)
(LTPC9 <- leveneTest(PC9~new.life$Status,data=sparrtyp_pca))
(p_PC9_1sided <- LTPC9[[3]][1]/2)
# Plotting the scores for the first and second components
legend("bottomleft", legend=c("Developing","Developed"), pch=c(1,16))
plot(sparrtyp_pca$PC1, sparrtyp_pca$PC2,pch=ifelse(sparrtyp_pca$Status == "Developing",1,16),xlab="PC1", ylab="PC2", main="Life Expectancy against values for PC1 & PC2")
abline(h=0)
abline(v=0)
# This tells where do we stop 
plot(eigen_life, xlab = "Component number", ylab = "Component variance", type = "l", main = "Scree diagram")

plot(log(eigen_life), xlab = "Component number",ylab = "log(Component variance)", type="l",main = "Log(eigenvalue) diagram")
print(summary(life_pca))
View(life_pca)
diag(cov(life_pca$x))
xlim <- range(life_pca$x[,1])
life_pca$x[,1]
life_pca$x
plot(life_pca$x,xlim=xlim,ylim=xlim)
life_pca$rotation[,1]
life_pca$rotation
plot(life1)
life_pca$x
plot(life_pca)
