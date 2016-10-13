library(readxl)

setwd("C:/Users/Leo/Desktop/R105/R105/HW2")
path <- file.path("Online data FINAL 26.08.xlsx")
excel_sheets(path) 
data <- read_excel(path, sheet = 1, col_names = T)

for(i in 1:nrow(data)){
  for(j in 1:ncol(data)){
    if(is.na(data[i,j]) == F){
      if(data[i,j] == "n/a"){
        data[i,j] <- NA
      }
    }
  }
}

write.csv(data, "Online data FINAL 26.08.csv")
