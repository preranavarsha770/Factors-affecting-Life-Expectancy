# Importing the dataset
install.packages("corrplot")
library(corrplot)
library(dplyr)
#For plotting the scatter density plots
library(GGally)

##############reading the dataset################################

who <- read.csv("C:\\asif_work\\2nd semester\\MVA\\Project\\Life_Expectancy_Data.csv")
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

install.packages("cluster", lib="/Library/Frameworks/R.framework/Versions/3.5/Resources/library")
library(cluster)

bar <- subset.data.frame(new.life, Year == '2015')
dim(bar)
rownames(bar)<-1:16
dim(bar)
View(bar)
new.life123<- na.omit(bar)
dim(new.life123)
#cluster.life <- bar[ c(1:10),c(4,5,7,11,16,17,19,20,21,22)]



cluster.life <- read.csv("C:\\asif_work\\2nd semester\\MVA\\life1.csv",row.names=1, fill = TRUE)

View(cluster.life)

dist.mat5 <- as.dist(cluster.life)
dim(cluster.life)
dist.mat5
#index(cluster.life, data.frame(1="app"))

#Single
mat5.nn <- hclust(dist.mat5, method = "single")
plot(mat5.nn, hang=-1,xlab="Object",ylab="Distance",
     main="Dendrogram. Nearest neighbor linkage")

#Default - Complete
mat5.fn <- hclust(dist.mat5)
plot(mat5.fn,hang=-1,xlab="Object",ylab="Distance",
     main="Dendrogram. Farthest neighbor linkage")

#Average
mat5.avl <- hclust(dist.mat5,method="average")
plot(mat5.avl,hang=-1,xlab="Object",ylab="Distance",
     main="Dendrogram. Group average linkage")


# Canines
matstd.can <- scale(cluster.life)

# Creating a (Euclidean) distance matrix of the standardized data 
dist.canine <- dist(matstd.can, method="euclidean")

# Invoking hclust command (cluster analysis by single linkage method)      
cluscanine.nn <- hclust(dist.canine, method = "single") 

# Plotting vertical dendrogram      
# create extra margin room in the dendrogram, on the bottom 
par(mar=c(6, 4, 4, 2) + 0.1)
plot(as.dendrogram(cluscanine.nn),ylab="Distance between countries",ylim=c(0,2.5),main="Dendrogram of ten random contries")

# New Example

employ <- cluster.life
attach(employ)
dim(employ)
# Hirerarchic cluster analysis, Nearest-neighbor

# Standardizing the data with scale()
matstd.employ <- scale(employ[,1:10])
View(matstd.employ)
# Creating a (Euclidean) distance matrix of the standardized data
dist.employ <- dist(matstd.employ, method="euclidean")
# Invoking hclust command (cluster analysis by single linkage method)
clusemploy.nn <- hclust(dist.employ, method = "single")


#Plotting

# Create extra margin room in the dendrogram, on the bottom (Countries labels)
par(mar=c(8, 4, 4, 2) + 0.1)
# Object "clusemploy.nn" is converted into a object of class "dendrogram"
# in order to allow better flexibility in the (vertical) dendrogram plotting.
plot(as.dendrogram(clusemploy.nn),ylab="Distance between countries",ylim=c(0,6),
     main="Dendrogram. Life expectancy in developed and developing groups  \n from ten countries in 2015")

#Horizontal Dendrogram

dev.new()
par(mar=c(5, 4, 4, 7) +0.1)
plot(as.dendrogram(clusemploy.nn), xlab= "Distance between countries", xlim=c(6,0),
     horiz = TRUE,main="Dendrogram. Life expectancy in developed and developing groups  \n from ten countries in 2015")

#K-Means Clustering

# Standardizing the data with scale()
matstd.employ <- scale(cluster.life)
# K-means, k=2, 3, 4, 5, 6
# Centers (k's) are numbers thus, 10 random sets are chosen
# Computing the percentage of variation accounted for. Two clusters
(kmeans2.employ <- kmeans(matstd.employ,2,nstart = 10))
perc.var.2 <- round(100*(1 - kmeans2.employ$betweenss/kmeans2.employ$totss),1)
names(perc.var.2) <- "Perc. 2 clus"
perc.var.2



# Saving four k-means clusters in a list
clus1 <- matrix(names(kmeans2.employ$cluster[kmeans2.employ$cluster == 1]), 
                ncol=1, nrow=length(kmeans2.employ$cluster[kmeans2.employ$cluster == 1]))
colnames(clus1) <- "Cluster 1"
clus2 <- matrix(names(kmeans2.employ$cluster[kmeans2.employ$cluster == 2]), 
                ncol=1, nrow=length(kmeans2.employ$cluster[kmeans2.employ$cluster == 2]))
colnames(clus2) <- "Cluster 2"

list(clus1,clus2)

# graph for cluster
library(factoextra)
fviz_cluster(kmeans2.employ, data= cluster.life)
