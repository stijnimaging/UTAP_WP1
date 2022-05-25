#
# Data processing and Statistics for UTAP WP1
#
# Department of Neurosurgery, Stijn Michielse, 2022
#
# Requirements
library(dplyr)
library(tibble)
library(Rfit)

rm(list=ls())

# Go to the server working directory
setwd("/Volumes/research-1/UTAP_WP1/MRI_DATA/VALUES")

# Load data (contains number of voxels and volume in columns)
values_SessionA1a_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA1a_L.txt", header = TRUE, sep = " ")
values_SessionA1a_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA1a_R.txt", header = TRUE, sep = " ")
values_SessionA2_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA2_L.txt", header = TRUE, sep = " ")
values_SessionA2_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA2_R.txt", header = TRUE, sep = " ")
values_SessionA3a_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA3a_L.txt", header = TRUE, sep = " ")
values_SessionA3a_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA3a_R.txt", header = TRUE, sep = " ")
values_SessionA4a_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA4a_L.txt", header = TRUE, sep = " ")
values_SessionA4a_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA4a_R.txt", header = TRUE, sep = " ")
values_SessionA5_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA5_L.txt", header = TRUE, sep = " ")
values_SessionA5_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA5_R.txt", header = TRUE, sep = " ")
values_SessionA6_Left <- read.csv("VOLUMETRICS/Overview_volumes_SA6_L.txt", header = TRUE, sep = " ")
values_SessionA6_Right <- read.csv("VOLUMETRICS/Overview_volumes_SA6_R.txt", header = TRUE, sep = " ")

# Select the volumes only and add to overview dataframe
volumes_overview <- data.frame(t(values_SessionA1a_Left[3]))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA1a_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA1a_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA1a_Right"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA2_Left[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA2_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA2_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA2_Right"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA3a_Left[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA3a_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA3a_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA3a_Right"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA4a_Left[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA4a_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA4a_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA4a_Right"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA5_Left[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA5_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA5_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA5_Right"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA6_Left[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "SessionA6_Left"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_SessionA6_Right[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "SessionA6_Right"

# Add names to the variables
colnames(volumes_overview) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
volumes_overview <- tibble::rownames_to_column(volumes_overview, "SessionAx_V")
save(volumes_overview,file="volumes_overview.Rda")

# Cleanup environment
rm(list = ls()[grepl("values", ls())])

#
##
### DTI METRICS
##
#

# Load DTI metrics data (use the F-F-T pattern to select every 3rd row)
values_SessionA1a_Left <- read.delim("DTI/SA1a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA1a_Right <- read.delim("DTI/SA1a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA2_Left <- read.delim("DTI/SA2_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA2_Right <- read.delim("DTI/SA2_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA3a_Left <- read.delim("DTI/SA3a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA3a_Right <- read.delim("DTI/SA3a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA4a_Left <- read.delim("DTI/SA4a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA4a_Right <- read.delim("DTI/SA4a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA5_Left <- read.delim("DTI/SA5_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA5_Right <- read.delim("DTI/SA5_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA6_Left <- read.delim("DTI/SA6_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_SessionA6_Right <- read.delim("DTI/SA6_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]


###
### Count number of tracts 
### 
# located in the 9th column, and rows 1 - 8 - 15 - ...

# Session A1a
# Use 9th column to extract data
# LEFT
Count_values <- data.frame(values_SessionA1a_Left[1,9],values_SessionA1a_Left[8,9],values_SessionA1a_Left[15,9],values_SessionA1a_Left[22,9],values_SessionA1a_Left[29,9],values_SessionA1a_Left[36,9],values_SessionA1a_Left[43,9],values_SessionA1a_Left[50,9],values_SessionA1a_Left[57,9],values_SessionA1a_Left[64,9],values_SessionA1a_Left[71,9],values_SessionA1a_Left[78,9],values_SessionA1a_Left[85,9],values_SessionA1a_Left[92,9])
colnames(Count_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA1a_Right[1,9],values_SessionA1a_Right[8,9],values_SessionA1a_Right[15,9],values_SessionA1a_Right[22,9],values_SessionA1a_Right[29,9],values_SessionA1a_Right[36,9],values_SessionA1a_Right[43,9],values_SessionA1a_Right[50,9],values_SessionA1a_Right[57,9],values_SessionA1a_Right[64,9],values_SessionA1a_Right[71,9],values_SessionA1a_Right[78,9],values_SessionA1a_Right[85,9],values_SessionA1a_Right[92,9])

# Session A2
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA2_Left[1,9],values_SessionA2_Left[8,9],values_SessionA2_Left[15,9],values_SessionA2_Left[22,9],values_SessionA2_Left[29,9],values_SessionA2_Left[36,9],values_SessionA2_Left[43,9],values_SessionA2_Left[50,9],values_SessionA2_Left[57,9],values_SessionA2_Left[64,9],values_SessionA2_Left[71,9],values_SessionA2_Left[78,9],values_SessionA2_Left[85,9],values_SessionA2_Left[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA2_Right[1,9],values_SessionA2_Right[8,9],values_SessionA2_Right[15,9],values_SessionA2_Right[22,9],values_SessionA2_Right[29,9],values_SessionA2_Right[36,9],values_SessionA2_Right[43,9],values_SessionA2_Right[50,9],values_SessionA2_Right[57,9],values_SessionA2_Right[64,9],values_SessionA2_Right[71,9],values_SessionA2_Right[78,9],values_SessionA2_Right[85,9],values_SessionA2_Right[92,9])

# Session A3a
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA3a_Left[1,9],values_SessionA3a_Left[8,9],values_SessionA3a_Left[15,9],values_SessionA3a_Left[22,9],values_SessionA3a_Left[29,9],values_SessionA3a_Left[36,9],values_SessionA3a_Left[43,9],values_SessionA3a_Left[50,9],values_SessionA3a_Left[57,9],values_SessionA3a_Left[64,9],values_SessionA3a_Left[71,9],values_SessionA3a_Left[78,9],values_SessionA3a_Left[85,9],values_SessionA3a_Left[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA3a_Right[1,9],values_SessionA3a_Right[8,9],values_SessionA3a_Right[15,9],values_SessionA3a_Right[22,9],values_SessionA3a_Right[29,9],values_SessionA3a_Right[36,9],values_SessionA3a_Right[43,9],values_SessionA3a_Right[50,9],values_SessionA3a_Right[57,9],values_SessionA3a_Right[64,9],values_SessionA3a_Right[71,9],values_SessionA3a_Right[78,9],values_SessionA3a_Right[85,9],values_SessionA3a_Right[92,9])

# Session A4a
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA4a_Left[1,9],values_SessionA4a_Left[8,9],values_SessionA4a_Left[15,9],values_SessionA4a_Left[22,9],values_SessionA4a_Left[29,9],values_SessionA4a_Left[36,9],values_SessionA4a_Left[43,9],values_SessionA4a_Left[50,9],values_SessionA4a_Left[57,9],values_SessionA4a_Left[64,9],values_SessionA4a_Left[71,9],values_SessionA4a_Left[78,9],values_SessionA4a_Left[85,9],values_SessionA4a_Left[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA4a_Right[1,9],values_SessionA4a_Right[8,9],values_SessionA4a_Right[15,9],values_SessionA4a_Right[22,9],values_SessionA4a_Right[29,9],values_SessionA4a_Right[36,9],values_SessionA4a_Right[43,9],values_SessionA4a_Right[50,9],values_SessionA4a_Right[57,9],values_SessionA4a_Right[64,9],values_SessionA4a_Right[71,9],values_SessionA4a_Right[78,9],values_SessionA4a_Right[85,9],values_SessionA4a_Right[92,9])

# Session A5
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA5_Left[1,9],values_SessionA5_Left[8,9],values_SessionA5_Left[15,9],values_SessionA5_Left[22,9],values_SessionA5_Left[29,9],values_SessionA5_Left[36,9],values_SessionA5_Left[43,9],values_SessionA5_Left[50,9],values_SessionA5_Left[57,9],values_SessionA5_Left[64,9],values_SessionA5_Left[71,9],values_SessionA5_Left[78,9],values_SessionA5_Left[85,9],values_SessionA5_Left[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA5_Right[1,9],values_SessionA5_Right[8,9],values_SessionA5_Right[15,9],values_SessionA5_Right[22,9],values_SessionA5_Right[29,9],values_SessionA5_Right[36,9],values_SessionA5_Right[43,9],values_SessionA5_Right[50,9],values_SessionA5_Right[57,9],values_SessionA5_Right[64,9],values_SessionA5_Right[71,9],values_SessionA5_Right[78,9],values_SessionA5_Right[85,9],values_SessionA5_Right[92,9])

# Session A6
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA6_Left[1,9],values_SessionA6_Left[8,9],values_SessionA6_Left[15,9],values_SessionA6_Left[22,9],values_SessionA6_Left[29,9],values_SessionA6_Left[36,9],values_SessionA6_Left[43,9],values_SessionA6_Left[50,9],values_SessionA6_Left[57,9],values_SessionA6_Left[64,9],values_SessionA6_Left[71,9],values_SessionA6_Left[78,9],values_SessionA6_Left[85,9],values_SessionA6_Left[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_SessionA6_Right[1,9],values_SessionA6_Right[8,9],values_SessionA6_Right[15,9],values_SessionA6_Right[22,9],values_SessionA6_Right[29,9],values_SessionA6_Right[36,9],values_SessionA6_Right[43,9],values_SessionA6_Right[50,9],values_SessionA6_Right[57,9],values_SessionA6_Right[64,9],values_SessionA6_Right[71,9],values_SessionA6_Right[78,9],values_SessionA6_Right[85,9],values_SessionA6_Right[92,9])

rownames(Count_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
Count_values <- tibble::rownames_to_column(Count_values, "SessionAx_V")
save(Count_values,file="Count_values.Rda")


###
### FA Values
###
# Use 4th column to extract data and rows 1 - 8 - 15 - ...

# Session A1a
FA_values <- data.frame(values_SessionA1a_Left[1,4],values_SessionA1a_Left[8,4],values_SessionA1a_Left[15,4],values_SessionA1a_Left[22,4],values_SessionA1a_Left[29,4],values_SessionA1a_Left[36,4],values_SessionA1a_Left[43,4],values_SessionA1a_Left[50,4],values_SessionA1a_Left[57,4],values_SessionA1a_Left[64,4],values_SessionA1a_Left[71,4],values_SessionA1a_Left[78,4],values_SessionA1a_Left[85,4],values_SessionA1a_Left[92,4])
colnames(FA_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA1a_Right[1,4],values_SessionA1a_Right[8,4],values_SessionA1a_Right[15,4],values_SessionA1a_Right[22,4],values_SessionA1a_Right[29,4],values_SessionA1a_Right[36,4],values_SessionA1a_Right[43,4],values_SessionA1a_Right[50,4],values_SessionA1a_Right[57,4],values_SessionA1a_Right[64,4],values_SessionA1a_Right[71,4],values_SessionA1a_Right[78,4],values_SessionA1a_Right[85,4],values_SessionA1a_Right[92,4])

# Session A2
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA2_Left[1,4],values_SessionA2_Left[8,4],values_SessionA2_Left[15,4],values_SessionA2_Left[22,4],values_SessionA2_Left[29,4],values_SessionA2_Left[36,4],values_SessionA2_Left[43,4],values_SessionA2_Left[50,4],values_SessionA2_Left[57,4],values_SessionA2_Left[64,4],values_SessionA2_Left[71,4],values_SessionA2_Left[78,4],values_SessionA2_Left[85,4],values_SessionA2_Left[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA2_Right[1,4],values_SessionA2_Right[8,4],values_SessionA2_Right[15,4],values_SessionA2_Right[22,4],values_SessionA2_Right[29,4],values_SessionA2_Right[36,4],values_SessionA2_Right[43,4],values_SessionA2_Right[50,4],values_SessionA2_Right[57,4],values_SessionA2_Right[64,4],values_SessionA2_Right[71,4],values_SessionA2_Right[78,4],values_SessionA2_Right[85,4],values_SessionA2_Right[92,4])

# Session A3a
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA3a_Left[1,4],values_SessionA3a_Left[8,4],values_SessionA3a_Left[15,4],values_SessionA3a_Left[22,4],values_SessionA3a_Left[29,4],values_SessionA3a_Left[36,4],values_SessionA3a_Left[43,4],values_SessionA3a_Left[50,4],values_SessionA3a_Left[57,4],values_SessionA3a_Left[64,4],values_SessionA3a_Left[71,4],values_SessionA3a_Left[78,4],values_SessionA3a_Left[85,4],values_SessionA3a_Left[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA3a_Right[1,4],values_SessionA3a_Right[8,4],values_SessionA3a_Right[15,4],values_SessionA3a_Right[22,4],values_SessionA3a_Right[29,4],values_SessionA3a_Right[36,4],values_SessionA3a_Right[43,4],values_SessionA3a_Right[50,4],values_SessionA3a_Right[57,4],values_SessionA3a_Right[64,4],values_SessionA3a_Right[71,4],values_SessionA3a_Right[78,4],values_SessionA3a_Right[85,4],values_SessionA3a_Right[92,4])

# Session A4a
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA4a_Left[1,4],values_SessionA4a_Left[8,4],values_SessionA4a_Left[15,4],values_SessionA4a_Left[22,4],values_SessionA4a_Left[29,4],values_SessionA4a_Left[36,4],values_SessionA4a_Left[43,4],values_SessionA4a_Left[50,4],values_SessionA4a_Left[57,4],values_SessionA4a_Left[64,4],values_SessionA4a_Left[71,4],values_SessionA4a_Left[78,4],values_SessionA4a_Left[85,4],values_SessionA4a_Left[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA4a_Right[1,4],values_SessionA4a_Right[8,4],values_SessionA4a_Right[15,4],values_SessionA4a_Right[22,4],values_SessionA4a_Right[29,4],values_SessionA4a_Right[36,4],values_SessionA4a_Right[43,4],values_SessionA4a_Right[50,4],values_SessionA4a_Right[57,4],values_SessionA4a_Right[64,4],values_SessionA4a_Right[71,4],values_SessionA4a_Right[78,4],values_SessionA4a_Right[85,4],values_SessionA4a_Right[92,4])

# Session A5
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA5_Left[1,4],values_SessionA5_Left[8,4],values_SessionA5_Left[15,4],values_SessionA5_Left[22,4],values_SessionA5_Left[29,4],values_SessionA5_Left[36,4],values_SessionA5_Left[43,4],values_SessionA5_Left[50,4],values_SessionA5_Left[57,4],values_SessionA5_Left[64,4],values_SessionA5_Left[71,4],values_SessionA5_Left[78,4],values_SessionA5_Left[85,4],values_SessionA5_Left[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA5_Right[1,4],values_SessionA5_Right[8,4],values_SessionA5_Right[15,4],values_SessionA5_Right[22,4],values_SessionA5_Right[29,4],values_SessionA5_Right[36,4],values_SessionA5_Right[43,4],values_SessionA5_Right[50,4],values_SessionA5_Right[57,4],values_SessionA5_Right[64,4],values_SessionA5_Right[71,4],values_SessionA5_Right[78,4],values_SessionA5_Right[85,4],values_SessionA5_Right[92,4])

# Session A6
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA6_Left[1,4],values_SessionA6_Left[8,4],values_SessionA6_Left[15,4],values_SessionA6_Left[22,4],values_SessionA6_Left[29,4],values_SessionA6_Left[36,4],values_SessionA6_Left[43,4],values_SessionA6_Left[50,4],values_SessionA6_Left[57,4],values_SessionA6_Left[64,4],values_SessionA6_Left[71,4],values_SessionA6_Left[78,4],values_SessionA6_Left[85,4],values_SessionA6_Left[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_SessionA6_Right[1,4],values_SessionA6_Right[8,4],values_SessionA6_Right[15,4],values_SessionA6_Right[22,4],values_SessionA6_Right[29,4],values_SessionA6_Right[36,4],values_SessionA6_Right[43,4],values_SessionA6_Right[50,4],values_SessionA6_Right[57,4],values_SessionA6_Right[64,4],values_SessionA6_Right[71,4],values_SessionA6_Right[78,4],values_SessionA6_Right[85,4],values_SessionA6_Right[92,4])

rownames(FA_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
FA_values <- tibble::rownames_to_column(FA_values, "SessionAx_V")
save(FA_values,file="FA_values.Rda")

###
### ADC 2 - 9 - 16 - ...
###

# Session A1a
ADC_values <- data.frame(values_SessionA1a_Left[2,4],values_SessionA1a_Left[9,4],values_SessionA1a_Left[16,4],values_SessionA1a_Left[23,4],values_SessionA1a_Left[30,4],values_SessionA1a_Left[37,4],values_SessionA1a_Left[44,4],values_SessionA1a_Left[51,4],values_SessionA1a_Left[58,4],values_SessionA1a_Left[65,4],values_SessionA1a_Left[72,4],values_SessionA1a_Left[79,4],values_SessionA1a_Left[86,4],values_SessionA1a_Left[93,4])
colnames(ADC_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA1a_Right[2,4],values_SessionA1a_Right[9,4],values_SessionA1a_Right[16,4],values_SessionA1a_Right[23,4],values_SessionA1a_Right[30,4],values_SessionA1a_Right[37,4],values_SessionA1a_Right[44,4],values_SessionA1a_Right[51,4],values_SessionA1a_Right[58,4],values_SessionA1a_Right[65,4],values_SessionA1a_Right[72,4],values_SessionA1a_Right[79,4],values_SessionA1a_Right[86,4],values_SessionA1a_Right[93,4])

# Session A2
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA2_Left[2,4],values_SessionA2_Left[9,4],values_SessionA2_Left[16,4],values_SessionA2_Left[23,4],values_SessionA2_Left[30,4],values_SessionA2_Left[37,4],values_SessionA2_Left[44,4],values_SessionA2_Left[51,4],values_SessionA2_Left[58,4],values_SessionA2_Left[65,4],values_SessionA2_Left[72,4],values_SessionA2_Left[79,4],values_SessionA2_Left[86,4],values_SessionA2_Left[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA2_Right[2,4],values_SessionA2_Right[9,4],values_SessionA2_Right[16,4],values_SessionA2_Right[23,4],values_SessionA2_Right[30,4],values_SessionA2_Right[37,4],values_SessionA2_Right[44,4],values_SessionA2_Right[51,4],values_SessionA2_Right[58,4],values_SessionA2_Right[65,4],values_SessionA2_Right[72,4],values_SessionA2_Right[79,4],values_SessionA2_Right[86,4],values_SessionA2_Right[93,4])

# Session A3a
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA3a_Left[2,4],values_SessionA3a_Left[9,4],values_SessionA3a_Left[16,4],values_SessionA3a_Left[23,4],values_SessionA3a_Left[30,4],values_SessionA3a_Left[37,4],values_SessionA3a_Left[44,4],values_SessionA3a_Left[51,4],values_SessionA3a_Left[58,4],values_SessionA3a_Left[65,4],values_SessionA3a_Left[72,4],values_SessionA3a_Left[79,4],values_SessionA3a_Left[86,4],values_SessionA3a_Left[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA3a_Right[2,4],values_SessionA3a_Right[9,4],values_SessionA3a_Right[16,4],values_SessionA3a_Right[23,4],values_SessionA3a_Right[30,4],values_SessionA3a_Right[37,4],values_SessionA3a_Right[44,4],values_SessionA3a_Right[51,4],values_SessionA3a_Right[58,4],values_SessionA3a_Right[65,4],values_SessionA3a_Right[72,4],values_SessionA3a_Right[79,4],values_SessionA3a_Right[86,4],values_SessionA3a_Right[93,4])

# Session A4a
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA4a_Left[2,4],values_SessionA4a_Left[9,4],values_SessionA4a_Left[16,4],values_SessionA4a_Left[23,4],values_SessionA4a_Left[30,4],values_SessionA4a_Left[37,4],values_SessionA4a_Left[44,4],values_SessionA4a_Left[51,4],values_SessionA4a_Left[58,4],values_SessionA4a_Left[65,4],values_SessionA4a_Left[72,4],values_SessionA4a_Left[79,4],values_SessionA4a_Left[86,4],values_SessionA4a_Left[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA4a_Right[2,4],values_SessionA4a_Right[9,4],values_SessionA4a_Right[16,4],values_SessionA4a_Right[23,4],values_SessionA4a_Right[30,4],values_SessionA4a_Right[37,4],values_SessionA4a_Right[44,4],values_SessionA4a_Right[51,4],values_SessionA4a_Right[58,4],values_SessionA4a_Right[65,4],values_SessionA4a_Right[72,4],values_SessionA4a_Right[79,4],values_SessionA4a_Right[86,4],values_SessionA4a_Right[93,4])

# Session A5
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA5_Left[2,4],values_SessionA5_Left[9,4],values_SessionA5_Left[16,4],values_SessionA5_Left[23,4],values_SessionA5_Left[30,4],values_SessionA5_Left[37,4],values_SessionA5_Left[44,4],values_SessionA5_Left[51,4],values_SessionA5_Left[58,4],values_SessionA5_Left[65,4],values_SessionA5_Left[72,4],values_SessionA5_Left[79,4],values_SessionA5_Left[86,4],values_SessionA5_Left[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA5_Right[2,4],values_SessionA5_Right[9,4],values_SessionA5_Right[16,4],values_SessionA5_Right[23,4],values_SessionA5_Right[30,4],values_SessionA5_Right[37,4],values_SessionA5_Right[44,4],values_SessionA5_Right[51,4],values_SessionA5_Right[58,4],values_SessionA5_Right[65,4],values_SessionA5_Right[72,4],values_SessionA5_Right[79,4],values_SessionA5_Right[86,4],values_SessionA5_Right[93,4])

# Session A6
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA6_Left[2,4],values_SessionA6_Left[9,4],values_SessionA6_Left[16,4],values_SessionA6_Left[23,4],values_SessionA6_Left[30,4],values_SessionA6_Left[37,4],values_SessionA6_Left[44,4],values_SessionA6_Left[51,4],values_SessionA6_Left[58,4],values_SessionA6_Left[65,4],values_SessionA6_Left[72,4],values_SessionA6_Left[79,4],values_SessionA6_Left[86,4],values_SessionA6_Left[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_SessionA6_Right[2,4],values_SessionA6_Right[9,4],values_SessionA6_Right[16,4],values_SessionA6_Right[23,4],values_SessionA6_Right[30,4],values_SessionA6_Right[37,4],values_SessionA6_Right[44,4],values_SessionA6_Right[51,4],values_SessionA6_Right[58,4],values_SessionA6_Right[65,4],values_SessionA6_Right[72,4],values_SessionA6_Right[79,4],values_SessionA6_Right[86,4],values_SessionA6_Right[93,4])

rownames(ADC_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
ADC_values <- tibble::rownames_to_column(ADC_values, "SessionAx_V")
save(ADC_values,file="ADC_values.Rda")


###
### AD 3 - 10 - 17 - ...
###

# Session A1a
AD_values <- data.frame(values_SessionA1a_Left[3,4],values_SessionA1a_Left[10,4],values_SessionA1a_Left[17,4],values_SessionA1a_Left[24,4],values_SessionA1a_Left[31,4],values_SessionA1a_Left[38,4],values_SessionA1a_Left[45,4],values_SessionA1a_Left[52,4],values_SessionA1a_Left[59,4],values_SessionA1a_Left[66,4],values_SessionA1a_Left[73,4],values_SessionA1a_Left[80,4],values_SessionA1a_Left[87,4],values_SessionA1a_Left[94,4])
colnames(AD_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA1a_Right[3,4],values_SessionA1a_Right[10,4],values_SessionA1a_Right[17,4],values_SessionA1a_Right[24,4],values_SessionA1a_Right[31,4],values_SessionA1a_Right[38,4],values_SessionA1a_Right[45,4],values_SessionA1a_Right[52,4],values_SessionA1a_Right[59,4],values_SessionA1a_Right[66,4],values_SessionA1a_Right[73,4],values_SessionA1a_Right[80,4],values_SessionA1a_Right[87,4],values_SessionA1a_Right[94,4])

# Session A2
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA2_Left[3,4],values_SessionA2_Left[10,4],values_SessionA2_Left[17,4],values_SessionA2_Left[24,4],values_SessionA2_Left[31,4],values_SessionA2_Left[38,4],values_SessionA2_Left[45,4],values_SessionA2_Left[52,4],values_SessionA2_Left[59,4],values_SessionA2_Left[66,4],values_SessionA2_Left[73,4],values_SessionA2_Left[80,4],values_SessionA2_Left[87,4],values_SessionA2_Left[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA2_Right[3,4],values_SessionA2_Right[10,4],values_SessionA2_Right[17,4],values_SessionA2_Right[24,4],values_SessionA2_Right[31,4],values_SessionA2_Right[38,4],values_SessionA2_Right[45,4],values_SessionA2_Right[52,4],values_SessionA2_Right[59,4],values_SessionA2_Right[66,4],values_SessionA2_Right[73,4],values_SessionA2_Right[80,4],values_SessionA2_Right[87,4],values_SessionA2_Right[94,4])

# Session A3a
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA3a_Left[3,4],values_SessionA3a_Left[10,4],values_SessionA3a_Left[17,4],values_SessionA3a_Left[24,4],values_SessionA3a_Left[31,4],values_SessionA3a_Left[38,4],values_SessionA3a_Left[45,4],values_SessionA3a_Left[52,4],values_SessionA3a_Left[59,4],values_SessionA3a_Left[66,4],values_SessionA3a_Left[73,4],values_SessionA3a_Left[80,4],values_SessionA3a_Left[87,4],values_SessionA3a_Left[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA3a_Right[3,4],values_SessionA3a_Right[10,4],values_SessionA3a_Right[17,4],values_SessionA3a_Right[24,4],values_SessionA3a_Right[31,4],values_SessionA3a_Right[38,4],values_SessionA3a_Right[45,4],values_SessionA3a_Right[52,4],values_SessionA3a_Right[59,4],values_SessionA3a_Right[66,4],values_SessionA3a_Right[73,4],values_SessionA3a_Right[80,4],values_SessionA3a_Right[87,4],values_SessionA3a_Right[94,4])

# Session A4a
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA4a_Left[3,4],values_SessionA4a_Left[10,4],values_SessionA4a_Left[17,4],values_SessionA4a_Left[24,4],values_SessionA4a_Left[31,4],values_SessionA4a_Left[38,4],values_SessionA4a_Left[45,4],values_SessionA4a_Left[52,4],values_SessionA4a_Left[59,4],values_SessionA4a_Left[66,4],values_SessionA4a_Left[73,4],values_SessionA4a_Left[80,4],values_SessionA4a_Left[87,4],values_SessionA4a_Left[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA4a_Right[3,4],values_SessionA4a_Right[10,4],values_SessionA4a_Right[17,4],values_SessionA4a_Right[24,4],values_SessionA4a_Right[31,4],values_SessionA4a_Right[38,4],values_SessionA4a_Right[45,4],values_SessionA4a_Right[52,4],values_SessionA4a_Right[59,4],values_SessionA4a_Right[66,4],values_SessionA4a_Right[73,4],values_SessionA4a_Right[80,4],values_SessionA4a_Right[87,4],values_SessionA4a_Right[94,4])

# Session A5
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA5_Left[3,4],values_SessionA5_Left[10,4],values_SessionA5_Left[17,4],values_SessionA5_Left[24,4],values_SessionA5_Left[31,4],values_SessionA5_Left[38,4],values_SessionA5_Left[45,4],values_SessionA5_Left[52,4],values_SessionA5_Left[59,4],values_SessionA5_Left[66,4],values_SessionA5_Left[73,4],values_SessionA5_Left[80,4],values_SessionA5_Left[87,4],values_SessionA5_Left[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA5_Right[3,4],values_SessionA5_Right[10,4],values_SessionA5_Right[17,4],values_SessionA5_Right[24,4],values_SessionA5_Right[31,4],values_SessionA5_Right[38,4],values_SessionA5_Right[45,4],values_SessionA5_Right[52,4],values_SessionA5_Right[59,4],values_SessionA5_Right[66,4],values_SessionA5_Right[73,4],values_SessionA5_Right[80,4],values_SessionA5_Right[87,4],values_SessionA5_Right[94,4])

# Session A6
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA6_Left[3,4],values_SessionA6_Left[10,4],values_SessionA6_Left[17,4],values_SessionA6_Left[24,4],values_SessionA6_Left[31,4],values_SessionA6_Left[38,4],values_SessionA6_Left[45,4],values_SessionA6_Left[52,4],values_SessionA6_Left[59,4],values_SessionA6_Left[66,4],values_SessionA6_Left[73,4],values_SessionA6_Left[80,4],values_SessionA6_Left[87,4],values_SessionA6_Left[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_SessionA6_Right[3,4],values_SessionA6_Right[10,4],values_SessionA6_Right[17,4],values_SessionA6_Right[24,4],values_SessionA6_Right[31,4],values_SessionA6_Right[38,4],values_SessionA6_Right[45,4],values_SessionA6_Right[52,4],values_SessionA6_Right[59,4],values_SessionA6_Right[66,4],values_SessionA6_Right[73,4],values_SessionA6_Right[80,4],values_SessionA6_Right[87,4],values_SessionA6_Right[94,4])

rownames(AD_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
AD_values <- tibble::rownames_to_column(AD_values, "SessionAx_V")
save(AD_values,file="AD_values.Rda")


###
### RD 4 - 11 - 18 - ...
###

# Session A1a
RD_values <- data.frame(values_SessionA1a_Left[4,4],values_SessionA1a_Left[11,4],values_SessionA1a_Left[18,4],values_SessionA1a_Left[25,4],values_SessionA1a_Left[32,4],values_SessionA1a_Left[39,4],values_SessionA1a_Left[46,4],values_SessionA1a_Left[53,4],values_SessionA1a_Left[60,4],values_SessionA1a_Left[67,4],values_SessionA1a_Left[74,4],values_SessionA1a_Left[81,4],values_SessionA1a_Left[88,4],values_SessionA1a_Left[95,4])
colnames(RD_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA1a_Right[4,4],values_SessionA1a_Right[11,4],values_SessionA1a_Right[18,4],values_SessionA1a_Right[25,4],values_SessionA1a_Right[32,4],values_SessionA1a_Right[39,4],values_SessionA1a_Right[46,4],values_SessionA1a_Right[53,4],values_SessionA1a_Right[60,4],values_SessionA1a_Right[67,4],values_SessionA1a_Right[74,4],values_SessionA1a_Right[81,4],values_SessionA1a_Right[88,4],values_SessionA1a_Right[95,4])

# Session A2
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA2_Left[4,4],values_SessionA2_Left[11,4],values_SessionA2_Left[18,4],values_SessionA2_Left[25,4],values_SessionA2_Left[32,4],values_SessionA2_Left[39,4],values_SessionA2_Left[46,4],values_SessionA2_Left[53,4],values_SessionA2_Left[60,4],values_SessionA2_Left[67,4],values_SessionA2_Left[74,4],values_SessionA2_Left[81,4],values_SessionA2_Left[88,4],values_SessionA2_Left[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA2_Right[4,4],values_SessionA2_Right[11,4],values_SessionA2_Right[18,4],values_SessionA2_Right[25,4],values_SessionA2_Right[32,4],values_SessionA2_Right[39,4],values_SessionA2_Right[46,4],values_SessionA2_Right[53,4],values_SessionA2_Right[60,4],values_SessionA2_Right[67,4],values_SessionA2_Right[74,4],values_SessionA2_Right[81,4],values_SessionA2_Right[88,4],values_SessionA2_Right[95,4])

# Session A3a
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA3a_Left[4,4],values_SessionA3a_Left[11,4],values_SessionA3a_Left[18,4],values_SessionA3a_Left[25,4],values_SessionA3a_Left[32,4],values_SessionA3a_Left[39,4],values_SessionA3a_Left[46,4],values_SessionA3a_Left[53,4],values_SessionA3a_Left[60,4],values_SessionA3a_Left[67,4],values_SessionA3a_Left[74,4],values_SessionA3a_Left[81,4],values_SessionA3a_Left[88,4],values_SessionA3a_Left[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA3a_Right[4,4],values_SessionA3a_Right[11,4],values_SessionA3a_Right[18,4],values_SessionA3a_Right[25,4],values_SessionA3a_Right[32,4],values_SessionA3a_Right[39,4],values_SessionA3a_Right[46,4],values_SessionA3a_Right[53,4],values_SessionA3a_Right[60,4],values_SessionA3a_Right[67,4],values_SessionA3a_Right[74,4],values_SessionA3a_Right[81,4],values_SessionA3a_Right[88,4],values_SessionA3a_Right[95,4])

# Session A4a
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA4a_Left[4,4],values_SessionA4a_Left[11,4],values_SessionA4a_Left[18,4],values_SessionA4a_Left[25,4],values_SessionA4a_Left[32,4],values_SessionA4a_Left[39,4],values_SessionA4a_Left[46,4],values_SessionA4a_Left[53,4],values_SessionA4a_Left[60,4],values_SessionA4a_Left[67,4],values_SessionA4a_Left[74,4],values_SessionA4a_Left[81,4],values_SessionA4a_Left[88,4],values_SessionA4a_Left[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA4a_Right[4,4],values_SessionA4a_Right[11,4],values_SessionA4a_Right[18,4],values_SessionA4a_Right[25,4],values_SessionA4a_Right[32,4],values_SessionA4a_Right[39,4],values_SessionA4a_Right[46,4],values_SessionA4a_Right[53,4],values_SessionA4a_Right[60,4],values_SessionA4a_Right[67,4],values_SessionA4a_Right[74,4],values_SessionA4a_Right[81,4],values_SessionA4a_Right[88,4],values_SessionA4a_Right[95,4])

# Session A5
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA5_Left[4,4],values_SessionA5_Left[11,4],values_SessionA5_Left[18,4],values_SessionA5_Left[25,4],values_SessionA5_Left[32,4],values_SessionA5_Left[39,4],values_SessionA5_Left[46,4],values_SessionA5_Left[53,4],values_SessionA5_Left[60,4],values_SessionA5_Left[67,4],values_SessionA5_Left[74,4],values_SessionA5_Left[81,4],values_SessionA5_Left[88,4],values_SessionA5_Left[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA5_Right[4,4],values_SessionA5_Right[11,4],values_SessionA5_Right[18,4],values_SessionA5_Right[25,4],values_SessionA5_Right[32,4],values_SessionA5_Right[39,4],values_SessionA5_Right[46,4],values_SessionA5_Right[53,4],values_SessionA5_Right[60,4],values_SessionA5_Right[67,4],values_SessionA5_Right[74,4],values_SessionA5_Right[81,4],values_SessionA5_Right[88,4],values_SessionA5_Right[95,4])

# Session A6
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA6_Left[4,4],values_SessionA6_Left[11,4],values_SessionA6_Left[18,4],values_SessionA6_Left[25,4],values_SessionA6_Left[32,4],values_SessionA6_Left[39,4],values_SessionA6_Left[46,4],values_SessionA6_Left[53,4],values_SessionA6_Left[60,4],values_SessionA6_Left[67,4],values_SessionA6_Left[74,4],values_SessionA6_Left[81,4],values_SessionA6_Left[88,4],values_SessionA6_Left[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_SessionA6_Right[4,4],values_SessionA6_Right[11,4],values_SessionA6_Right[18,4],values_SessionA6_Right[25,4],values_SessionA6_Right[32,4],values_SessionA6_Right[39,4],values_SessionA6_Right[46,4],values_SessionA6_Right[53,4],values_SessionA6_Right[60,4],values_SessionA6_Right[67,4],values_SessionA6_Right[74,4],values_SessionA6_Right[81,4],values_SessionA6_Right[88,4],values_SessionA6_Right[95,4])

rownames(RD_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
RD_values <- tibble::rownames_to_column(RD_values, "SessionAx_V")
save(RD_values,file="RD_values.Rda")


###
### CL 5 - 12 - 19 - ...
###

# Session A1a
CL_values <- data.frame(values_SessionA1a_Left[5,4],values_SessionA1a_Left[12,4],values_SessionA1a_Left[19,4],values_SessionA1a_Left[26,4],values_SessionA1a_Left[33,4],values_SessionA1a_Left[40,4],values_SessionA1a_Left[47,4],values_SessionA1a_Left[54,4],values_SessionA1a_Left[61,4],values_SessionA1a_Left[68,4],values_SessionA1a_Left[75,4],values_SessionA1a_Left[82,4],values_SessionA1a_Left[89,4],values_SessionA1a_Left[96,4])
colnames(CL_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA1a_Right[5,4],values_SessionA1a_Right[12,4],values_SessionA1a_Right[19,4],values_SessionA1a_Right[26,4],values_SessionA1a_Right[33,4],values_SessionA1a_Right[40,4],values_SessionA1a_Right[47,4],values_SessionA1a_Right[54,4],values_SessionA1a_Right[61,4],values_SessionA1a_Right[68,4],values_SessionA1a_Right[75,4],values_SessionA1a_Right[82,4],values_SessionA1a_Right[89,4],values_SessionA1a_Right[96,4])

# Session A2
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA2_Left[5,4],values_SessionA2_Left[12,4],values_SessionA2_Left[19,4],values_SessionA2_Left[26,4],values_SessionA2_Left[33,4],values_SessionA2_Left[40,4],values_SessionA2_Left[47,4],values_SessionA2_Left[54,4],values_SessionA2_Left[61,4],values_SessionA2_Left[68,4],values_SessionA2_Left[75,4],values_SessionA2_Left[82,4],values_SessionA2_Left[89,4],values_SessionA2_Left[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA2_Right[5,4],values_SessionA2_Right[12,4],values_SessionA2_Right[19,4],values_SessionA2_Right[26,4],values_SessionA2_Right[33,4],values_SessionA2_Right[40,4],values_SessionA2_Right[47,4],values_SessionA2_Right[54,4],values_SessionA2_Right[61,4],values_SessionA2_Right[68,4],values_SessionA2_Right[75,4],values_SessionA2_Right[82,4],values_SessionA2_Right[89,4],values_SessionA2_Right[96,4])

# Session A3a
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA3a_Left[5,4],values_SessionA3a_Left[12,4],values_SessionA3a_Left[19,4],values_SessionA3a_Left[26,4],values_SessionA3a_Left[33,4],values_SessionA3a_Left[40,4],values_SessionA3a_Left[47,4],values_SessionA3a_Left[54,4],values_SessionA3a_Left[61,4],values_SessionA3a_Left[68,4],values_SessionA3a_Left[75,4],values_SessionA3a_Left[82,4],values_SessionA3a_Left[89,4],values_SessionA3a_Left[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA3a_Right[5,4],values_SessionA3a_Right[12,4],values_SessionA3a_Right[19,4],values_SessionA3a_Right[26,4],values_SessionA3a_Right[33,4],values_SessionA3a_Right[40,4],values_SessionA3a_Right[47,4],values_SessionA3a_Right[54,4],values_SessionA3a_Right[61,4],values_SessionA3a_Right[68,4],values_SessionA3a_Right[75,4],values_SessionA3a_Right[82,4],values_SessionA3a_Right[89,4],values_SessionA3a_Right[96,4])

# Session A4a
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA4a_Left[5,4],values_SessionA4a_Left[12,4],values_SessionA4a_Left[19,4],values_SessionA4a_Left[26,4],values_SessionA4a_Left[33,4],values_SessionA4a_Left[40,4],values_SessionA4a_Left[47,4],values_SessionA4a_Left[54,4],values_SessionA4a_Left[61,4],values_SessionA4a_Left[68,4],values_SessionA4a_Left[75,4],values_SessionA4a_Left[82,4],values_SessionA4a_Left[89,4],values_SessionA4a_Left[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA4a_Right[5,4],values_SessionA4a_Right[12,4],values_SessionA4a_Right[19,4],values_SessionA4a_Right[26,4],values_SessionA4a_Right[33,4],values_SessionA4a_Right[40,4],values_SessionA4a_Right[47,4],values_SessionA4a_Right[54,4],values_SessionA4a_Right[61,4],values_SessionA4a_Right[68,4],values_SessionA4a_Right[75,4],values_SessionA4a_Right[82,4],values_SessionA4a_Right[89,4],values_SessionA4a_Right[96,4])

# Session A5
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA5_Left[5,4],values_SessionA5_Left[12,4],values_SessionA5_Left[19,4],values_SessionA5_Left[26,4],values_SessionA5_Left[33,4],values_SessionA5_Left[40,4],values_SessionA5_Left[47,4],values_SessionA5_Left[54,4],values_SessionA5_Left[61,4],values_SessionA5_Left[68,4],values_SessionA5_Left[75,4],values_SessionA5_Left[82,4],values_SessionA5_Left[89,4],values_SessionA5_Left[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA5_Right[5,4],values_SessionA5_Right[12,4],values_SessionA5_Right[19,4],values_SessionA5_Right[26,4],values_SessionA5_Right[33,4],values_SessionA5_Right[40,4],values_SessionA5_Right[47,4],values_SessionA5_Right[54,4],values_SessionA5_Right[61,4],values_SessionA5_Right[68,4],values_SessionA5_Right[75,4],values_SessionA5_Right[82,4],values_SessionA5_Right[89,4],values_SessionA5_Right[96,4])

# Session A6
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA6_Left[5,4],values_SessionA6_Left[12,4],values_SessionA6_Left[19,4],values_SessionA6_Left[26,4],values_SessionA6_Left[33,4],values_SessionA6_Left[40,4],values_SessionA6_Left[47,4],values_SessionA6_Left[54,4],values_SessionA6_Left[61,4],values_SessionA6_Left[68,4],values_SessionA6_Left[75,4],values_SessionA6_Left[82,4],values_SessionA6_Left[89,4],values_SessionA6_Left[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_SessionA6_Right[5,4],values_SessionA6_Right[12,4],values_SessionA6_Right[19,4],values_SessionA6_Right[26,4],values_SessionA6_Right[33,4],values_SessionA6_Right[40,4],values_SessionA6_Right[47,4],values_SessionA6_Right[54,4],values_SessionA6_Right[61,4],values_SessionA6_Right[68,4],values_SessionA6_Right[75,4],values_SessionA6_Right[82,4],values_SessionA6_Right[89,4],values_SessionA6_Right[96,4])

rownames(CL_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
CL_values <- tibble::rownames_to_column(CL_values, "SessionAx_V")
save(CL_values,file="CL_values.Rda")


###
### CP 6 - 13 - 20 - ...
###

# Session A1a
CP_values <- data.frame(values_SessionA1a_Left[6,4],values_SessionA1a_Left[13,4],values_SessionA1a_Left[20,4],values_SessionA1a_Left[27,4],values_SessionA1a_Left[34,4],values_SessionA1a_Left[41,4],values_SessionA1a_Left[48,4],values_SessionA1a_Left[55,4],values_SessionA1a_Left[62,4],values_SessionA1a_Left[69,4],values_SessionA1a_Left[76,4],values_SessionA1a_Left[83,4],values_SessionA1a_Left[90,4],values_SessionA1a_Left[97,4])
colnames(CP_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA1a_Right[6,4],values_SessionA1a_Right[13,4],values_SessionA1a_Right[20,4],values_SessionA1a_Right[27,4],values_SessionA1a_Right[34,4],values_SessionA1a_Right[41,4],values_SessionA1a_Right[48,4],values_SessionA1a_Right[55,4],values_SessionA1a_Right[62,4],values_SessionA1a_Right[69,4],values_SessionA1a_Right[76,4],values_SessionA1a_Right[83,4],values_SessionA1a_Right[90,4],values_SessionA1a_Right[97,4])

# Session A2
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA2_Left[6,4],values_SessionA2_Left[13,4],values_SessionA2_Left[20,4],values_SessionA2_Left[27,4],values_SessionA2_Left[34,4],values_SessionA2_Left[41,4],values_SessionA2_Left[48,4],values_SessionA2_Left[55,4],values_SessionA2_Left[62,4],values_SessionA2_Left[69,4],values_SessionA2_Left[76,4],values_SessionA2_Left[83,4],values_SessionA2_Left[90,4],values_SessionA2_Left[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA2_Right[6,4],values_SessionA2_Right[13,4],values_SessionA2_Right[20,4],values_SessionA2_Right[27,4],values_SessionA2_Right[34,4],values_SessionA2_Right[41,4],values_SessionA2_Right[48,4],values_SessionA2_Right[55,4],values_SessionA2_Right[62,4],values_SessionA2_Right[69,4],values_SessionA2_Right[76,4],values_SessionA2_Right[83,4],values_SessionA2_Right[90,4],values_SessionA2_Right[97,4])

# Session A3a
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA3a_Left[6,4],values_SessionA3a_Left[13,4],values_SessionA3a_Left[20,4],values_SessionA3a_Left[27,4],values_SessionA3a_Left[34,4],values_SessionA3a_Left[41,4],values_SessionA3a_Left[48,4],values_SessionA3a_Left[55,4],values_SessionA3a_Left[62,4],values_SessionA3a_Left[69,4],values_SessionA3a_Left[76,4],values_SessionA3a_Left[83,4],values_SessionA3a_Left[90,4],values_SessionA3a_Left[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA3a_Right[6,4],values_SessionA3a_Right[13,4],values_SessionA3a_Right[20,4],values_SessionA3a_Right[27,4],values_SessionA3a_Right[34,4],values_SessionA3a_Right[41,4],values_SessionA3a_Right[48,4],values_SessionA3a_Right[55,4],values_SessionA3a_Right[62,4],values_SessionA3a_Right[69,4],values_SessionA3a_Right[76,4],values_SessionA3a_Right[83,4],values_SessionA3a_Right[90,4],values_SessionA3a_Right[97,4])

# Session A4a
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA4a_Left[6,4],values_SessionA4a_Left[13,4],values_SessionA4a_Left[20,4],values_SessionA4a_Left[27,4],values_SessionA4a_Left[34,4],values_SessionA4a_Left[41,4],values_SessionA4a_Left[48,4],values_SessionA4a_Left[55,4],values_SessionA4a_Left[62,4],values_SessionA4a_Left[69,4],values_SessionA4a_Left[76,4],values_SessionA4a_Left[83,4],values_SessionA4a_Left[90,4],values_SessionA4a_Left[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA4a_Right[6,4],values_SessionA4a_Right[13,4],values_SessionA4a_Right[20,4],values_SessionA4a_Right[27,4],values_SessionA4a_Right[34,4],values_SessionA4a_Right[41,4],values_SessionA4a_Right[48,4],values_SessionA4a_Right[55,4],values_SessionA4a_Right[62,4],values_SessionA4a_Right[69,4],values_SessionA4a_Right[76,4],values_SessionA4a_Right[83,4],values_SessionA4a_Right[90,4],values_SessionA4a_Right[97,4])

# Session A5
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA5_Left[6,4],values_SessionA5_Left[13,4],values_SessionA5_Left[20,4],values_SessionA5_Left[27,4],values_SessionA5_Left[34,4],values_SessionA5_Left[41,4],values_SessionA5_Left[48,4],values_SessionA5_Left[55,4],values_SessionA5_Left[62,4],values_SessionA5_Left[69,4],values_SessionA5_Left[76,4],values_SessionA5_Left[83,4],values_SessionA5_Left[90,4],values_SessionA5_Left[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA5_Right[6,4],values_SessionA5_Right[13,4],values_SessionA5_Right[20,4],values_SessionA5_Right[27,4],values_SessionA5_Right[34,4],values_SessionA5_Right[41,4],values_SessionA5_Right[48,4],values_SessionA5_Right[55,4],values_SessionA5_Right[62,4],values_SessionA5_Right[69,4],values_SessionA5_Right[76,4],values_SessionA5_Right[83,4],values_SessionA5_Right[90,4],values_SessionA5_Right[97,4])

# Session A6
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA6_Left[6,4],values_SessionA6_Left[13,4],values_SessionA6_Left[20,4],values_SessionA6_Left[27,4],values_SessionA6_Left[34,4],values_SessionA6_Left[41,4],values_SessionA6_Left[48,4],values_SessionA6_Left[55,4],values_SessionA6_Left[62,4],values_SessionA6_Left[69,4],values_SessionA6_Left[76,4],values_SessionA6_Left[83,4],values_SessionA6_Left[90,4],values_SessionA6_Left[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_SessionA6_Right[6,4],values_SessionA6_Right[13,4],values_SessionA6_Right[20,4],values_SessionA6_Right[27,4],values_SessionA6_Right[34,4],values_SessionA6_Right[41,4],values_SessionA6_Right[48,4],values_SessionA6_Right[55,4],values_SessionA6_Right[62,4],values_SessionA6_Right[69,4],values_SessionA6_Right[76,4],values_SessionA6_Right[83,4],values_SessionA6_Right[90,4],values_SessionA6_Right[97,4])

rownames(CP_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
CP_values <- tibble::rownames_to_column(CP_values, "SessionAx_V")
save(CP_values,file="CP_values.Rda")


###
### CS 7 - 14 - 21 - ...
###

# Session A1a
CS_values <- data.frame(values_SessionA1a_Left[7,4],values_SessionA1a_Left[14,4],values_SessionA1a_Left[21,4],values_SessionA1a_Left[28,4],values_SessionA1a_Left[35,4],values_SessionA1a_Left[42,4],values_SessionA1a_Left[49,4],values_SessionA1a_Left[56,4],values_SessionA1a_Left[63,4],values_SessionA1a_Left[70,4],values_SessionA1a_Left[77,4],values_SessionA1a_Left[84,4],values_SessionA1a_Left[91,4],values_SessionA1a_Left[98,4])
colnames(CS_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA1a_Right[7,4],values_SessionA1a_Right[14,4],values_SessionA1a_Right[21,4],values_SessionA1a_Right[28,4],values_SessionA1a_Right[35,4],values_SessionA1a_Right[42,4],values_SessionA1a_Right[49,4],values_SessionA1a_Right[56,4],values_SessionA1a_Right[63,4],values_SessionA1a_Right[70,4],values_SessionA1a_Right[77,4],values_SessionA1a_Right[84,4],values_SessionA1a_Right[91,4],values_SessionA1a_Right[98,4])

# Session A2
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA2_Left[7,4],values_SessionA2_Left[14,4],values_SessionA2_Left[21,4],values_SessionA2_Left[28,4],values_SessionA2_Left[35,4],values_SessionA2_Left[42,4],values_SessionA2_Left[49,4],values_SessionA2_Left[56,4],values_SessionA2_Left[63,4],values_SessionA2_Left[70,4],values_SessionA2_Left[77,4],values_SessionA2_Left[84,4],values_SessionA2_Left[91,4],values_SessionA2_Left[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA2_Right[7,4],values_SessionA2_Right[14,4],values_SessionA2_Right[21,4],values_SessionA2_Right[28,4],values_SessionA2_Right[35,4],values_SessionA2_Right[42,4],values_SessionA2_Right[49,4],values_SessionA2_Right[56,4],values_SessionA2_Right[63,4],values_SessionA2_Right[70,4],values_SessionA2_Right[77,4],values_SessionA2_Right[84,4],values_SessionA2_Right[91,4],values_SessionA2_Right[98,4])

# Session A3a
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA3a_Left[7,4],values_SessionA3a_Left[14,4],values_SessionA3a_Left[21,4],values_SessionA3a_Left[28,4],values_SessionA3a_Left[35,4],values_SessionA3a_Left[42,4],values_SessionA3a_Left[49,4],values_SessionA3a_Left[56,4],values_SessionA3a_Left[63,4],values_SessionA3a_Left[70,4],values_SessionA3a_Left[77,4],values_SessionA3a_Left[84,4],values_SessionA3a_Left[91,4],values_SessionA3a_Left[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA3a_Right[7,4],values_SessionA3a_Right[14,4],values_SessionA3a_Right[21,4],values_SessionA3a_Right[28,4],values_SessionA3a_Right[35,4],values_SessionA3a_Right[42,4],values_SessionA3a_Right[49,4],values_SessionA3a_Right[56,4],values_SessionA3a_Right[63,4],values_SessionA3a_Right[70,4],values_SessionA3a_Right[77,4],values_SessionA3a_Right[84,4],values_SessionA3a_Right[91,4],values_SessionA3a_Right[98,4])

# Session A4a
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA4a_Left[7,4],values_SessionA4a_Left[14,4],values_SessionA4a_Left[21,4],values_SessionA4a_Left[28,4],values_SessionA4a_Left[35,4],values_SessionA4a_Left[42,4],values_SessionA4a_Left[49,4],values_SessionA4a_Left[56,4],values_SessionA4a_Left[63,4],values_SessionA4a_Left[70,4],values_SessionA4a_Left[77,4],values_SessionA4a_Left[84,4],values_SessionA4a_Left[91,4],values_SessionA4a_Left[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA4a_Right[7,4],values_SessionA4a_Right[14,4],values_SessionA4a_Right[21,4],values_SessionA4a_Right[28,4],values_SessionA4a_Right[35,4],values_SessionA4a_Right[42,4],values_SessionA4a_Right[49,4],values_SessionA4a_Right[56,4],values_SessionA4a_Right[63,4],values_SessionA4a_Right[70,4],values_SessionA4a_Right[77,4],values_SessionA4a_Right[84,4],values_SessionA4a_Right[91,4],values_SessionA4a_Right[98,4])

# Session A5
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA5_Left[7,4],values_SessionA5_Left[14,4],values_SessionA5_Left[21,4],values_SessionA5_Left[28,4],values_SessionA5_Left[35,4],values_SessionA5_Left[42,4],values_SessionA5_Left[49,4],values_SessionA5_Left[56,4],values_SessionA5_Left[63,4],values_SessionA5_Left[70,4],values_SessionA5_Left[77,4],values_SessionA5_Left[84,4],values_SessionA5_Left[91,4],values_SessionA5_Left[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA5_Right[7,4],values_SessionA5_Right[14,4],values_SessionA5_Right[21,4],values_SessionA5_Right[28,4],values_SessionA5_Right[35,4],values_SessionA5_Right[42,4],values_SessionA5_Right[49,4],values_SessionA5_Right[56,4],values_SessionA5_Right[63,4],values_SessionA5_Right[70,4],values_SessionA5_Right[77,4],values_SessionA5_Right[84,4],values_SessionA5_Right[91,4],values_SessionA5_Right[98,4])

# Session A6
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA6_Left[7,4],values_SessionA6_Left[14,4],values_SessionA6_Left[21,4],values_SessionA6_Left[28,4],values_SessionA6_Left[35,4],values_SessionA6_Left[42,4],values_SessionA6_Left[49,4],values_SessionA6_Left[56,4],values_SessionA6_Left[63,4],values_SessionA6_Left[70,4],values_SessionA6_Left[77,4],values_SessionA6_Left[84,4],values_SessionA6_Left[91,4],values_SessionA6_Left[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_SessionA6_Right[7,4],values_SessionA6_Right[14,4],values_SessionA6_Right[21,4],values_SessionA6_Right[28,4],values_SessionA6_Right[35,4],values_SessionA6_Right[42,4],values_SessionA6_Right[49,4],values_SessionA6_Right[56,4],values_SessionA6_Right[63,4],values_SessionA6_Right[70,4],values_SessionA6_Right[77,4],values_SessionA6_Right[84,4],values_SessionA6_Right[91,4],values_SessionA6_Right[98,4])

rownames(CS_values) <- c("SessionA1a_Left", "SessionA1a_Right", "SessionA2_Left", "SessionA2_Right", "SessionA3a_Left", "SessionA3a_Right", "SessionA4a_Left", "SessionA4a_Right", "SessionA5_Left", "SessionA5_Right", "SessionA6_Left", "SessionA6_Right")
CS_values <- tibble::rownames_to_column(CS_values, "SessionAx_V")
save(CS_values,file="CS_values.Rda")

# Cleanup environment
rm(list = ls()[grepl("values_", ls())])