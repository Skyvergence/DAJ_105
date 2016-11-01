library(httr)
library(readxl)
library(ggplot2)

########## Import data
url <- 'http://nidss.cdc.gov.tw/Download/Age_County_Gender_0749.csv'
GET(url, write_disk("test.csv", overwrite=TRUE))
data <- read.csv("test.csv", sep=',', fileEncoding = 'big5')

########## 計算各縣市確定病例數
length <- tapply(data$確定病例數, data$縣市, length)
county_cases <- data.frame(length)
county_cases$county <- rownames(county_cases)
county_cases$num_cases <- county_cases$length
county_cases <- county_cases[,-1]
rownames(county_cases) <- 1:nrow(county_cases)

county_cases$county <- factor(county_cases$county,
                              levels = county_cases$county[order(county_cases$num_cases)])

ggplot(county_cases, aes(county, num_cases, fill=num_cases))+
  geom_bar(stat="identity", width=.60) +
  coord_flip() +
  xlab("縣市")+
  ylab("確定病例數")+
  scale_fill_gradient(low = "gray", high = "darkblue") +
  ggtitle("各縣市確定病例數") +  
  theme(text = element_text(size=12))

########## 計算各年齡層確定病例數
length_2 <- tapply(data$確定病例數, data$年齡層, length)
age_level <- data.frame(length_2)
age_level$age <- rownames(age_level)
age_level$num_cases <- age_level$length
age_level <- age_level[,-1]
rownames(age_level) <- 1:nrow(age_level)
age_level <- rbind(age_level,c("20-24", "0"))

age_level$age <- factor(age_level$age,
                              levels = c("0", "1", "2", "3", "4", "5-9", "10-14"
                                         , "15-19", "20-24", "25-29", "30-34"))
age_level$num_cases <- as.numeric(age_level$num_cases)

ggplot(age_level, aes(age, num_cases, fill=num_cases))+
  geom_bar(stat="identity", width=.60) +
  coord_flip() +
  xlab("年齡層")+
  ylab("確定病例數")+
  scale_fill_gradient(low = "gray", high = "darkblue") +
  ggtitle("各年齡層確定病例數") +  
  theme(text = element_text(size=12))


########## 計算年份的確定病例數
length_3 <- tapply(data$確定病例數, data$發病年份, length)
year_cases <- data.frame(length_3)
year_cases$year <- rownames(year_cases)
year_cases$num_cases <- year_cases$length_3
year_cases <- year_cases[,-1]
rownames(year_cases) <- 1:nrow(year_cases)

year_cases$year <- factor(year_cases$year,
                            levels = 2016:2003)

ggplot(year_cases, aes(year, num_cases, fill=num_cases))+
  geom_bar(stat="identity", width=.60) +
  coord_flip() +
  xlab("年份")+
  ylab("確定病例數")+
  scale_fill_gradient(low = "gray", high = "darkblue") +
  ggtitle("各年份確定病例數") +  
  theme(text = element_text(size=12))


########## 計算月份的確定病例數
length_4 <- tapply(data$確定病例數, data$發病月份, length)
month_cases <- data.frame(length_4)
month_cases$month <- rownames(month_cases)
month_cases$num_cases <- month_cases$length_4
month_cases <- month_cases[,-1]
rownames(month_cases) <- 1:nrow(month_cases)

month_cases$month <- factor(month_cases$month,
                          levels = c("12","11","10","9", "8", "7", "6"
                                     , "5", "4", "3", "2", "1"))

ggplot(month_cases, aes(month, num_cases, fill=num_cases))+
  geom_bar(stat="identity", width=.60) +
  coord_flip() +
  xlab("月份")+
  ylab("確定病例數")+
  scale_fill_gradient(low = "gray", high = "darkblue") +
  ggtitle("各月份確定病例數") +  
  theme(text = element_text(size=12))
