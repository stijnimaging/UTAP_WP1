#
# Data processing and Statistics for UTAP WP1
#
# Create overview per DTI measure on how the regions are connected; 78 times and provide number of tracts
# If no connections are present the script will generate a zero on that line
#
# Department of Neurosurgery, Stijn Michielse, 2022
#
# Requirements

library(tidyselect)
library(tidyverse)
library(ggplot2)

setwd("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/")
rm(list = ls())

# Create one dataframe with session data per line
list_sessions <- c("A1a","A2","A3a","A4a","A5","A6")
list_regions <-  c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")

for (target in list_sessions) {
  print(paste("Session",target,sep = ""))
  load(file=paste0(paste0("Session",target),"_Right.rda"))
  load(file=paste0(paste0("Session",target),"_Left.rda"))
}
df <- SessionA6_Right

#
# Number of fibers per connection
#

# Loop over sessions and over 78 connections in the network
Fibers_matrix <- matrix(data = NA, nrow = 14, ncol = 14)
row.names(Fibers_matrix) <- list_regions
colnames(Fibers_matrix) <- list_regions

# AntCom
Fibers_matrix[1,2:13] <- df$fibers[1:12]
Fibers_matrix[2:13,1] <- df$fibers[1:12]
Fibers_matrix[1,1] <- 0

# Caudate
Fibers_matrix[2,3:13] <- df$fibers[13:23]
Fibers_matrix[3:13,2] <- df$fibers[13:23]
Fibers_matrix[2,2] <- 0

# GPe
Fibers_matrix[3,4:13] <- df$fibers[24:33]
Fibers_matrix[4:13,3] <- df$fibers[24:33]
Fibers_matrix[3,3] <- 0

# GPi
Fibers_matrix[4,5:13] <- df$fibers[34:42]
Fibers_matrix[5:13,4] <- df$fibers[34:42]
Fibers_matrix[4,4] <- 0

# IntCap
Fibers_matrix[5,6:13] <- df$fibers[43:50]
Fibers_matrix[6:13,5] <- df$fibers[43:50]
Fibers_matrix[5,5] <- 0

# IntThalAdh
Fibers_matrix[6,7:13] <- df$fibers[51:57]
Fibers_matrix[7:13,6] <- df$fibers[51:57]
Fibers_matrix[6,6] <- 0

# LocCoer
Fibers_matrix[7,8:13] <- df$fibers[58:63]
Fibers_matrix[8:13,7] <- df$fibers[58:63]
Fibers_matrix[7,7] <- 0

# Putamen
Fibers_matrix[8,9:13] <- df$fibers[64:68]
Fibers_matrix[9:13,8] <- df$fibers[64:68]
Fibers_matrix[8,8] <- 0

# RedNucl
Fibers_matrix[9,10:13] <- df$fibers[69:72]
Fibers_matrix[10:13,9] <- df$fibers[69:72]
Fibers_matrix[9,9] <- 0

# STN
Fibers_matrix[10,11:13] <- df$fibers[73:75]
Fibers_matrix[11:13,10] <- df$fibers[73:75]
Fibers_matrix[10,10] <- 0

# SubLentIntCap
Fibers_matrix[11,12:13] <- df$fibers[76:77]
Fibers_matrix[12:13,11] <- df$fibers[76:77]
Fibers_matrix[11,11] <- 0

# SubNig
Fibers_matrix[12,13:13] <- df$fibers[78:78]
Fibers_matrix[13:13,12] <- df$fibers[78:78]
Fibers_matrix[12,12] <- 0

# Thalamus
Fibers_matrix[13,13] <- 0

# VentPal
Fibers_matrix[14,1:14] <- 0
Fibers_matrix[1:14,14] <- 0

# Create visualisation
heatmap(Fibers_matrix, Colv = NA, Rowv = NA, scale = "column")
heatmap(Fibers_matrix, Colv = NA, Rowv = NA)
heatmap(Fibers_matrix, Colv = NA, Rowv = NA, scale = "column", xlab = "Region", main = "Fibers",cexRow=1.5)

library(reshape2)
data_melt <- melt(Fibers_matrix)
tiff(file = "SessionA6_Right.tiff", units="in", width=6, height=6, res=300)
ggplot(data_melt, aes(Var1, Var2)) +                           # Create heatmap with ggplot2
  geom_tile(aes(fill = value)) +
  ggtitle("Number of Fibers") +
  theme(axis.title.x = element_blank()) +
  theme(axis.title.y = element_blank()) +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_gradient(low = "white", high = "red", space = "Lab") +
  geom_raster( aes(fill=value)) +
  geom_text(  aes(x=Var1, y=Var2, label = value), color="black", size=3) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
dev.off()
