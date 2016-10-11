library(xml2)
library(rvest)
library(dplyr)

setwd("C:/Users/Leo/Desktop/R105/R105/HW2")
source("html_table_fixed.R")

url <- "https://www.ubs.com/microsites/prices-earnings/edition-2015.html"
doc <- read_html(url)

tables <- html_nodes(doc, "table")
table <- html_table(tables[1], fill = TRUE)
table_df <- data.frame(table)
for (i in 2:4){
  table <- html_table(tables[i], fill = TRUE)
  table_temp_df <- data.frame(table)
  table_temp_df <- table_temp_df[,c(2,4)]
  table_df <- inner_join(table_df, table_temp_df, by = c("City.1" = "City.1"))
}

table_df <- table_df[,c(-1,-3)]
colnames(table_df) <- c("City", "Working time", "Prices", "Wages", "Purchasing Power")

