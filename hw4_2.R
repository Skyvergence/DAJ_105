library(jsonlite)
library(httr)
library(tidyr)
library(wordcloud)
options(stringsAsFactors = F)

########### Import Data
url <- "https://data.cityofnewyork.us/api/views/25th-nujf/rows.json?accessType=DOWNLOAD"
GET(url, write_disk("name", overwrite=TRUE))
name.data <- fromJSON("name")
babyname <- data.frame(name.data[2])

########### Clean Data
babyname <- babyname[,-(1:8)]
colnames(babyname) <- c("year", "gender", "ethnic", "name", "count", "rank")
babyname_14 <- babyname[babyname$year == 2014,]
babyname_14$count <- as.numeric(babyname_14$count)
babyname_14_m <- babyname_14[babyname_14$gender == "MALE",]
babyname_14_f <- babyname_14[babyname_14$gender == "FEMALE",]

########## Count Name
sum_m <- tapply(babyname_14_m$count, babyname_14_m$name, sum)
boynamecount <- data.frame(sum_m)
sum_f <- tapply(babyname_14_f$count, babyname_14_f$name, sum)
girlnamecount <- data.frame(sum_f)

########## Word Cloud
palBlues <- brewer.pal(9, "Blues")
palBlues <- palBlues[-(1:2)]
par(family=('Heiti TC Light'))

wordcloud(
  rownames(boynamecount),
  boynamecount$sum_m,
  scale = c(4, .1),
  min.freq = 2,
  max.words = 100,
  random.order = F,
  rot.per = .15,
  colors = palBlues
)


palReds <- brewer.pal(9, "Reds")
palReds <- palReds[-(1:2)]
par(family=('Heiti TC Light'))

wordcloud(
  rownames(girlnamecount),
  girlnamecount$sum_f,
  scale = c(4, .1),
  min.freq = 2,
  max.words = 100,
  random.order = F,
  rot.per = .15,
  colors = palReds
)