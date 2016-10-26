##### Preparation #####

# Loading packages for reading xls files and drawing map
library(readxl)

# Setting working directory if needed
setwd('hw3')

# Import longitudinal data
ldata <- read_excel("data/WORLD-MACHE_Gender_6.8.15.xls", "Sheet1", col_names=T)

##### barplot of each country's data #####

# Assign the 3rd, 6 to 24 columns to a new variable matleave
matleave <- ldata[c(3, 6:24)] # selecting columns
matleave[is.na(matleave)] <- 0

###############
# Selecting rows with the '2013' column == 5
m5 <- matleave[matleave$matleave_13 == 5,]

# Find countries whose maternity_leave stay the same in m5
staySame <- apply(m5[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1

# Separate the countries with same maternity_leave from others
m55 <- m5[staySame, ]
m50 <- m5[!staySame, ]


# Assigning the 1st column as row names
rownames(m50) <- m50[,1]

# Deleting the 1st column
m50 <- m50[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m50))){
  barplot(unlist(m50[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#2171b5")
  title(rownames(m50)[x], line = -4, cex.main=3)
}

# Assigning the 1st column as row names
rownames(m55) <- m55[,1]

# Deleting the 1st column
m55 <- m55[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m55))){
  barplot(unlist(m55[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#2171b5")
  title(rownames(m55)[x], line = -4, cex.main=3)
}


###############
# Selecting rows with the '2013' column == 4
m4 <- matleave[matleave$matleave_13 == 4,]

# Find countries whose maternity_leave stay the same in m4
staySame <- apply(m4[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1

# Separate the countries with same maternity_leave from others
m44 <- m4[staySame, ]
m40 <- m4[!staySame, ]


# Assigning the 1st column as row names
rownames(m40) <- m40[,1]

# Deleting the 1st column
m40 <- m40[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m40))){
  barplot(unlist(m40[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#6baed6")
  title(rownames(m40)[x], line = -4, cex.main=3)
}

# Assigning the 1st column as row names
rownames(m44) <- m44[,1]

# Deleting the 1st column
m44 <- m44[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m44))){
  barplot(unlist(m44[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#6baed6")
  title(rownames(m44)[x], line = -4, cex.main=3)
}


###############
# Selecting rows with the '2013' column == 3
m3 <- matleave[matleave$matleave_13 == 3,]

# Find countries whose maternity_leave stay the same in m3
staySame <- apply(m3[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1

# Separate the countries with same maternity_leave from others
m33 <- m3[staySame, ]
m30 <- m3[!staySame, ]


# Assigning the 1st column as row names
rownames(m30) <- m30[,1]

# Deleting the 1st column
m30 <- m30[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m30))){
  barplot(unlist(m30[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#bdd7e7")
  title(rownames(m30)[x], line = -4, cex.main=3)
}

# Assigning the 1st column as row names
rownames(m33) <- m33[,1]

# Deleting the 1st column
m33 <- m33[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m33))){
  barplot(unlist(m33[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#bdd7e7")
  title(rownames(m33)[x], line = -4, cex.main=3)
}


###############
# Selecting rows with the '2013' column == 2
m2 <- matleave[matleave$matleave_13 == 2,]

# Find countries whose maternity_leave stay the same in m3
staySame <- apply(m2[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1

# Separate the countries with same maternity_leave from others
m22 <- m2[staySame, ]
m20 <- m2[!staySame, ]


# Assigning the 1st column as row names
rownames(m20) <- m20[,1]

# Deleting the 1st column
m20 <- m20[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m20))){
  barplot(unlist(m20[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#eff3ff")
  title(rownames(m20)[x], line = -4, cex.main=3)
}

# Assigning the 1st column as row names
rownames(m22) <- m22[,1]

# Deleting the 1st column
m22 <- m22[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m22))){
  barplot(unlist(m22[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#eff3ff")
  title(rownames(m22)[x], line = -4, cex.main=3)
}


###############
# Selecting rows with the '2013' column == 1
m1 <- matleave[matleave$matleave_13 == 1,]

# Find countries whose maternity_leave stay the same in m3
staySame <- apply(m1[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1

# Separate the countries with same maternity_leave from others
m11 <- m1[staySame, ]
m10 <- m1[!staySame, ]


# Assigning the 1st column as row names
rownames(m11) <- m11[,1]

# Deleting the 1st column
m11 <- m11[,-1]

# plotting consequent figure in 12*6 grids (12 rows 6 columns)
par(mfrow=c(12,6), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m11))){
  barplot(unlist(m11[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5), col = "#e31a1c")
  title(rownames(m11)[x], line = -4, cex.main=3)
}

