library(readxl)
library(tidyr)
library(dplyr)
library(lubridate)
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
selector <- sapply(news$Split, function(x) any(x %in% rownames(legis)))

# Select news with legislator candidate. Create month variable
news <- news[selector,]
news$month <- month(news$Date)

# Create "Legis" varible, which has all the legislaotr candidate in the variable
news$Legis <- sapply(news$Split, function(x){intersect(x, rownames(legis))})
news2 <- unnest(news, Legis)

# Calculate how many seconds a legislator showed in a news in each month.
sum_sec <- tapply(as.numeric(news2$Sec), list(news2$Legis, news2$ month), sum)
sum_sec <- data.frame(sum_sec)
colnames(sum_sec) <- c("Oct", "Nov", "Dec")
sum_sec$name <- rownames(sum_sec)

# Select subset of legis data and rename it
legis_dta <- legis[,c(1,2,6,7,8)]
colnames(legis_dta) <- c("area", "name", "party", "vote", "vote_rate")

# Join sum_sec and legis_dta. Set NA to 0. Fix area = 0 problem
legis_dta <- full_join(legis_dta, sum_sec, by = c("name", "name"))
legis_dta[is.na(legis_dta)] <- 0
legis_dta[legis_dta$name == "林淑芬", "area"] <- "新北市02"

# Correlation test
cor.test(legis_dta$vote, legis_dta$Oct)
cor.test(legis_dta$vote, legis_dta$Nov)
cor.test(legis_dta$vote, legis_dta$Dec)



