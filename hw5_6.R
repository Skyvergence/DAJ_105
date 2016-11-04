library(readxl)
library(tidyr)
library(dplyr)
options(stringsAsFactors = F)

# Import electionNews data
load("HW5/data/ElectionNews_student.RData")

# Import legislator spent data and set row name as legislator's name
legis <- read_excel("HW5/data/2016_leg_spent.xls"
                    , sheet = 1
                    , col_names = T)
legis <- data.frame(legis)
rownames(legis) <- legis$姓名

# Select subset of ElectNews as new data frame
news <- ElectNews[c(1, 3, 9, 10, 11, 12, 13)]

# Split person in news data. Construct a legislator candidate selector
news$Split <- strsplit(news$Person, '／')
selector <- sapply(news$Split, function(x) any((x %in% rownames(legis))==F))
news <- news[selector,]

news$Legis <- sapply(news$Split, function(x){intersect(x, rownames(legis))})

# Find non legislator candidates
for(i in 1:nrow(news)){
  news$non_Legis[[i]] <- setdiff(news$Split[[i]], news$Legis[[i]])
}

# Use unnest to count how many seconds a non legislator candidate show in news  
news2 <- unnest(news, non_Legis)
length <- tapply(news2$Sec,news2$non_Legis, length)
length <- data.frame(length)

sum <- tapply(as.numeric(news2$Sec),news2$non_Legis, sum)
sum <- data.frame(sum)
length <- cbind(length, sum)
