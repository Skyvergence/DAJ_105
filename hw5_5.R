library(readxl)
options(stringsAsFactors = F)

legis <- read_excel("HW5/data/2016_leg_spent.xls"
                    , sheet = 1
                    , col_names = T)

party_areavote <- tapply(as.numeric(legis$得票數), list(legis$地區, legis$推薦政黨), sum)
party_areavote <- as.data.frame(party_areavote)
party_areavote[is.na(party_areavote)] <- 0