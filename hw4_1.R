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
