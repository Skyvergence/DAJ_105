##### Preparation #####

# Loading packages for reading xls files and drawing map
library(readxl)

# Setting working directory if needed
setwd('hw3')

# Import longitudinal data
ldata <- read_excel("data/WORLD-MACHE_Gender_6.8.15.xls", "Sheet1", col_names=T)
ldata <- ldata[,c(1:24)]


# Calculate the average matleave_13 by region
mean <- tapply(ldata$matleave_13, ldata$region, mean)
length <- tapply(ldata$matleave_13, ldata$region, length)
sd <- tapply(ldata$matleave_13, ldata$region, sd)
res <- data.frame(length)
res <- cbind(res, data.frame(mean))
res <- cbind(res, data.frame(sd))
colnames(res) <- c("num_countries", "avg_matleave_13", "standara_deviation")

# Calculate the average matleave from 1995 to 2013 by region
matleave <- ldata[,c(1:24)]
matleave[is.na(matleave)] <- 0
byregion <- aggregate(matleave[,6:24],by=list(matleave$region), mean)

# Plot matleave from 1995 to 2013 by region
par(mfrow=c(3,2), mai= c(0.4, 0.35, 0.35, 0.35))
for (x in c(1:6)){
  plot(unlist(byregion[x,]), type="o", xaxt = "n", col = "blue")
  axis(1, at=c(5,10,15,20),labels=c("1998", "2003", "2008", "2013"), col.axis="red", las=2)
  title(byregion[x, 1], line = -2, cex.main=2)
  
}
