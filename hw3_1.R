##### Preparation #####

# Loading packages for reading xls files and drawing map
library(readxl)
library(rworldmap)

# Setting working directory if needed
setwd('hw3')

# Import longitudinal data
ldata <- read_excel("data/WORLD-MACHE_Gender_6.8.15.xls", "Sheet1", col_names=T)


##### Drawing map for data 1995, 2004, 2013 #####

# Mapping ldata to map's data by ISO3 standard
myPDF <- joinCountryData2Map(ldata
                             , joinCode = "ISO3"
                             , nameJoinColumn = "iso3")


# Drawing the map according to some column
map_1995 <- mapCountryData(myPDF
                           , nameColumnToPlot= "matleave_95"
                           , catMethod = "categorical"
                           , colourPalette = c("#e31a1c", "#eff3ff", "#bdd7e7", "#6baed6", "#2171b5")
                           , mapTitle = "Maternity leave in 1995"
                           , addLegend= F)

map_2004 <- mapCountryData(myPDF
                           , nameColumnToPlot= "matleave_04"
                           , catMethod = "categorical"
                           , colourPalette = c("#e31a1c", "#eff3ff", "#bdd7e7", "#6baed6", "#2171b5")
                           , mapTitle = "Maternity leave in 2004"
                           , addLegend= F)

map_2013 <- mapCountryData(myPDF
                           , nameColumnToPlot= "matleave_13"
                           , catMethod = "categorical"
                           , colourPalette = c("#e31a1c", "#eff3ff", "#bdd7e7", "#6baed6", "#2171b5")
                           , mapTitle = "Maternity leave in 2013"
                           , addLegend= F)