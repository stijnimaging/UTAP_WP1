
library(dplyr)
rm(list=ls())

# Go to the server working directory
setwd("/Volumes/research-1/UTAP_WP1/MRI_DATA/VALUES")

# Load data (contains number of voxels and volume in columns)
values_sA1a_L <- read.csv("VOLUMETRICS/Overview_volumes_SA1a_L.txt", header = TRUE, sep = " ")
values_sA1a_R <- read.csv("VOLUMETRICS/Overview_volumes_SA1a_R.txt", header = TRUE, sep = " ")
values_sA2_L <- read.csv("VOLUMETRICS/Overview_volumes_SA2_L.txt", header = TRUE, sep = " ")
values_sA2_R <- read.csv("VOLUMETRICS/Overview_volumes_SA2_R.txt", header = TRUE, sep = " ")
values_sA3a_L <- read.csv("VOLUMETRICS/Overview_volumes_SA3a_L.txt", header = TRUE, sep = " ")
values_sA3a_R <- read.csv("VOLUMETRICS/Overview_volumes_SA3a_R.txt", header = TRUE, sep = " ")
values_sA4a_L <- read.csv("VOLUMETRICS/Overview_volumes_SA4a_L.txt", header = TRUE, sep = " ")
values_sA4a_R <- read.csv("VOLUMETRICS/Overview_volumes_SA4a_R.txt", header = TRUE, sep = " ")
values_sA5_L <- read.csv("VOLUMETRICS/Overview_volumes_SA5_L.txt", header = TRUE, sep = " ")
values_sA5_R <- read.csv("VOLUMETRICS/Overview_volumes_SA5_R.txt", header = TRUE, sep = " ")
values_sA6_L <- read.csv("VOLUMETRICS/Overview_volumes_SA6_L.txt", header = TRUE, sep = " ")
values_sA6_R <- read.csv("VOLUMETRICS/Overview_volumes_SA6_R.txt", header = TRUE, sep = " ")

# Select the volumes only and add to overview dataframe
volumes_overview <- data.frame(t(values_sA1a_L[3]))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA1a_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA1a_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA1a_RIGHT"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA2_L[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA2_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA2_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA2_RIGHT"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA3a_L[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA3a_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA3a_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA3a_RIGHT"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA4a_L[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA4a_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA4a_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA4a_RIGHT"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA5_L[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA5_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA5_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA5_RIGHT"

volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA6_L[3])))
rownames(volumes_overview)[rownames(volumes_overview) == "stats"] <- "sA6_LEFT"
volumes_overview <- rbind(volumes_overview, data.frame(t(values_sA6_R[4])))
rownames(volumes_overview)[rownames(volumes_overview) == "created"] <- "sA6_RIGHT"

# Add names to the variables
colnames(volumes_overview) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
save(volumes_overview,file="volumes_overview.Rda")

# Cleanup environment
rm(list = ls()[grepl("values", ls())])

#
##
### DTI METRICS
##
#

# Load DTI metrics data (use the F-F-T pattern to select every 3rd row)
values_sA1a_L <- read.delim("DTI/sA1a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA1a_R <- read.delim("DTI/sA1a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA2_L <- read.delim("DTI/sA2_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA2_R <- read.delim("DTI/sA2_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA3a_L <- read.delim("DTI/sA3a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA3a_R <- read.delim("DTI/sA3a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA4a_L <- read.delim("DTI/sA4a_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA4a_R <- read.delim("DTI/sA4a_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA5_L <- read.delim("DTI/sA5_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA5_R <- read.delim("DTI/sA5_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA6_L <- read.delim("DTI/sA6_LH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]
values_sA6_R <- read.delim("DTI/sA6_RH_ROI_Metrics.txt", header = TRUE, sep = "", dec = ".")[c(FALSE, FALSE, TRUE,FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, TRUE), ]


###
### Count number of tracts 
### 
# located in the 9th column, and rows 1 - 8 - 15 - ...

# Session A1a
# Use 9th column to extract data
# LEFT
Count_values <- data.frame(values_sA1a_L[1,9],values_sA1a_L[8,9],values_sA1a_L[15,9],values_sA1a_L[22,9],values_sA1a_L[29,9],values_sA1a_L[36,9],values_sA1a_L[43,9],values_sA1a_L[50,9],values_sA1a_L[57,9],values_sA1a_L[64,9],values_sA1a_L[71,9],values_sA1a_L[78,9],values_sA1a_L[85,9],values_sA1a_L[92,9])
colnames(Count_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA1a_R[1,9],values_sA1a_R[8,9],values_sA1a_R[15,9],values_sA1a_R[22,9],values_sA1a_R[29,9],values_sA1a_R[36,9],values_sA1a_R[43,9],values_sA1a_R[50,9],values_sA1a_R[57,9],values_sA1a_R[64,9],values_sA1a_R[71,9],values_sA1a_R[78,9],values_sA1a_R[85,9],values_sA1a_R[92,9])

# Session A2
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_sA2_L[1,9],values_sA2_L[8,9],values_sA2_L[15,9],values_sA2_L[22,9],values_sA2_L[29,9],values_sA2_L[36,9],values_sA2_L[43,9],values_sA2_L[50,9],values_sA2_L[57,9],values_sA2_L[64,9],values_sA2_L[71,9],values_sA2_L[78,9],values_sA2_L[85,9],values_sA2_L[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA2_R[1,9],values_sA2_R[8,9],values_sA2_R[15,9],values_sA2_R[22,9],values_sA2_R[29,9],values_sA2_R[36,9],values_sA2_R[43,9],values_sA2_R[50,9],values_sA2_R[57,9],values_sA2_R[64,9],values_sA2_R[71,9],values_sA2_R[78,9],values_sA2_R[85,9],values_sA2_R[92,9])

# Session A3a
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_sA3a_L[1,9],values_sA3a_L[8,9],values_sA3a_L[15,9],values_sA3a_L[22,9],values_sA3a_L[29,9],values_sA3a_L[36,9],values_sA3a_L[43,9],values_sA3a_L[50,9],values_sA3a_L[57,9],values_sA3a_L[64,9],values_sA3a_L[71,9],values_sA3a_L[78,9],values_sA3a_L[85,9],values_sA3a_L[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA3a_R[1,9],values_sA3a_R[8,9],values_sA3a_R[15,9],values_sA3a_R[22,9],values_sA3a_R[29,9],values_sA3a_R[36,9],values_sA3a_R[43,9],values_sA3a_R[50,9],values_sA3a_R[57,9],values_sA3a_R[64,9],values_sA3a_R[71,9],values_sA3a_R[78,9],values_sA3a_R[85,9],values_sA3a_R[92,9])

# Session A4a
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_sA4a_L[1,9],values_sA4a_L[8,9],values_sA4a_L[15,9],values_sA4a_L[22,9],values_sA4a_L[29,9],values_sA4a_L[36,9],values_sA4a_L[43,9],values_sA4a_L[50,9],values_sA4a_L[57,9],values_sA4a_L[64,9],values_sA4a_L[71,9],values_sA4a_L[78,9],values_sA4a_L[85,9],values_sA4a_L[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA4a_R[1,9],values_sA4a_R[8,9],values_sA4a_R[15,9],values_sA4a_R[22,9],values_sA4a_R[29,9],values_sA4a_R[36,9],values_sA4a_R[43,9],values_sA4a_R[50,9],values_sA4a_R[57,9],values_sA4a_R[64,9],values_sA4a_R[71,9],values_sA4a_R[78,9],values_sA4a_R[85,9],values_sA4a_R[92,9])

# Session A5
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_sA5_L[1,9],values_sA5_L[8,9],values_sA5_L[15,9],values_sA5_L[22,9],values_sA5_L[29,9],values_sA5_L[36,9],values_sA5_L[43,9],values_sA5_L[50,9],values_sA5_L[57,9],values_sA5_L[64,9],values_sA5_L[71,9],values_sA5_L[78,9],values_sA5_L[85,9],values_sA5_L[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA5_R[1,9],values_sA5_R[8,9],values_sA5_R[15,9],values_sA5_R[22,9],values_sA5_R[29,9],values_sA5_R[36,9],values_sA5_R[43,9],values_sA5_R[50,9],values_sA5_R[57,9],values_sA5_R[64,9],values_sA5_R[71,9],values_sA5_R[78,9],values_sA5_R[85,9],values_sA5_R[92,9])

# Session A6
# LEFT
Count_values[nrow(Count_values) + 1,] <- c(values_sA6_L[1,9],values_sA6_L[8,9],values_sA6_L[15,9],values_sA6_L[22,9],values_sA6_L[29,9],values_sA6_L[36,9],values_sA6_L[43,9],values_sA6_L[50,9],values_sA6_L[57,9],values_sA6_L[64,9],values_sA6_L[71,9],values_sA6_L[78,9],values_sA6_L[85,9],values_sA6_L[92,9])
# RIGHT
Count_values[nrow(Count_values) + 1,] <- c(values_sA6_R[1,9],values_sA6_R[8,9],values_sA6_R[15,9],values_sA6_R[22,9],values_sA6_R[29,9],values_sA6_R[36,9],values_sA6_R[43,9],values_sA6_R[50,9],values_sA6_R[57,9],values_sA6_R[64,9],values_sA6_R[71,9],values_sA6_R[78,9],values_sA6_R[85,9],values_sA6_R[92,9])

rownames(Count_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(Count_values,file="Count_values.Rda")


###
### FA Values
###
# Use 4th column to extract data and rows 1 - 8 - 15 - ...

# Session A1a
FA_values <- data.frame(values_sA1a_L[1,4],values_sA1a_L[8,4],values_sA1a_L[15,4],values_sA1a_L[22,4],values_sA1a_L[29,4],values_sA1a_L[36,4],values_sA1a_L[43,4],values_sA1a_L[50,4],values_sA1a_L[57,4],values_sA1a_L[64,4],values_sA1a_L[71,4],values_sA1a_L[78,4],values_sA1a_L[85,4],values_sA1a_L[92,4])
colnames(FA_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA1a_R[1,4],values_sA1a_R[8,4],values_sA1a_R[15,4],values_sA1a_R[22,4],values_sA1a_R[29,4],values_sA1a_R[36,4],values_sA1a_R[43,4],values_sA1a_R[50,4],values_sA1a_R[57,4],values_sA1a_R[64,4],values_sA1a_R[71,4],values_sA1a_R[78,4],values_sA1a_R[85,4],values_sA1a_R[92,4])

# Session A2
FA_values[nrow(FA_values) + 1,] <- c(values_sA2_L[1,4],values_sA2_L[8,4],values_sA2_L[15,4],values_sA2_L[22,4],values_sA2_L[29,4],values_sA2_L[36,4],values_sA2_L[43,4],values_sA2_L[50,4],values_sA2_L[57,4],values_sA2_L[64,4],values_sA2_L[71,4],values_sA2_L[78,4],values_sA2_L[85,4],values_sA2_L[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA2_R[1,4],values_sA2_R[8,4],values_sA2_R[15,4],values_sA2_R[22,4],values_sA2_R[29,4],values_sA2_R[36,4],values_sA2_R[43,4],values_sA2_R[50,4],values_sA2_R[57,4],values_sA2_R[64,4],values_sA2_R[71,4],values_sA2_R[78,4],values_sA2_R[85,4],values_sA2_R[92,4])

# Session A3a
FA_values[nrow(FA_values) + 1,] <- c(values_sA3a_L[1,4],values_sA3a_L[8,4],values_sA3a_L[15,4],values_sA3a_L[22,4],values_sA3a_L[29,4],values_sA3a_L[36,4],values_sA3a_L[43,4],values_sA3a_L[50,4],values_sA3a_L[57,4],values_sA3a_L[64,4],values_sA3a_L[71,4],values_sA3a_L[78,4],values_sA3a_L[85,4],values_sA3a_L[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA3a_R[1,4],values_sA3a_R[8,4],values_sA3a_R[15,4],values_sA3a_R[22,4],values_sA3a_R[29,4],values_sA3a_R[36,4],values_sA3a_R[43,4],values_sA3a_R[50,4],values_sA3a_R[57,4],values_sA3a_R[64,4],values_sA3a_R[71,4],values_sA3a_R[78,4],values_sA3a_R[85,4],values_sA3a_R[92,4])

# Session A4a
FA_values[nrow(FA_values) + 1,] <- c(values_sA4a_L[1,4],values_sA4a_L[8,4],values_sA4a_L[15,4],values_sA4a_L[22,4],values_sA4a_L[29,4],values_sA4a_L[36,4],values_sA4a_L[43,4],values_sA4a_L[50,4],values_sA4a_L[57,4],values_sA4a_L[64,4],values_sA4a_L[71,4],values_sA4a_L[78,4],values_sA4a_L[85,4],values_sA4a_L[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA4a_R[1,4],values_sA4a_R[8,4],values_sA4a_R[15,4],values_sA4a_R[22,4],values_sA4a_R[29,4],values_sA4a_R[36,4],values_sA4a_R[43,4],values_sA4a_R[50,4],values_sA4a_R[57,4],values_sA4a_R[64,4],values_sA4a_R[71,4],values_sA4a_R[78,4],values_sA4a_R[85,4],values_sA4a_R[92,4])

# Session A5
FA_values[nrow(FA_values) + 1,] <- c(values_sA5_L[1,4],values_sA5_L[8,4],values_sA5_L[15,4],values_sA5_L[22,4],values_sA5_L[29,4],values_sA5_L[36,4],values_sA5_L[43,4],values_sA5_L[50,4],values_sA5_L[57,4],values_sA5_L[64,4],values_sA5_L[71,4],values_sA5_L[78,4],values_sA5_L[85,4],values_sA5_L[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA5_R[1,4],values_sA5_R[8,4],values_sA5_R[15,4],values_sA5_R[22,4],values_sA5_R[29,4],values_sA5_R[36,4],values_sA5_R[43,4],values_sA5_R[50,4],values_sA5_R[57,4],values_sA5_R[64,4],values_sA5_R[71,4],values_sA5_R[78,4],values_sA5_R[85,4],values_sA5_R[92,4])

# Session A6
FA_values[nrow(FA_values) + 1,] <- c(values_sA6_L[1,4],values_sA6_L[8,4],values_sA6_L[15,4],values_sA6_L[22,4],values_sA6_L[29,4],values_sA6_L[36,4],values_sA6_L[43,4],values_sA6_L[50,4],values_sA6_L[57,4],values_sA6_L[64,4],values_sA6_L[71,4],values_sA6_L[78,4],values_sA6_L[85,4],values_sA6_L[92,4])
# RIGHT
FA_values[nrow(FA_values) + 1,] <- c(values_sA6_R[1,4],values_sA6_R[8,4],values_sA6_R[15,4],values_sA6_R[22,4],values_sA6_R[29,4],values_sA6_R[36,4],values_sA6_R[43,4],values_sA6_R[50,4],values_sA6_R[57,4],values_sA6_R[64,4],values_sA6_R[71,4],values_sA6_R[78,4],values_sA6_R[85,4],values_sA6_R[92,4])

rownames(FA_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(FA_values,file="FA_values.Rda")

###
### ADC 2 - 9 - 16 - ...
###

# Session A1a
ADC_values <- data.frame(values_sA1a_L[2,4],values_sA1a_L[9,4],values_sA1a_L[16,4],values_sA1a_L[23,4],values_sA1a_L[30,4],values_sA1a_L[37,4],values_sA1a_L[44,4],values_sA1a_L[51,4],values_sA1a_L[58,4],values_sA1a_L[65,4],values_sA1a_L[72,4],values_sA1a_L[79,4],values_sA1a_L[86,4],values_sA1a_L[93,4])
colnames(ADC_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA1a_R[2,4],values_sA1a_R[9,4],values_sA1a_R[16,4],values_sA1a_R[23,4],values_sA1a_R[30,4],values_sA1a_R[37,4],values_sA1a_R[44,4],values_sA1a_R[51,4],values_sA1a_R[58,4],values_sA1a_R[65,4],values_sA1a_R[72,4],values_sA1a_R[79,4],values_sA1a_R[86,4],values_sA1a_R[93,4])

# Session A2
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA2_L[2,4],values_sA2_L[9,4],values_sA2_L[16,4],values_sA2_L[23,4],values_sA2_L[30,4],values_sA2_L[37,4],values_sA2_L[44,4],values_sA2_L[51,4],values_sA2_L[58,4],values_sA2_L[65,4],values_sA2_L[72,4],values_sA2_L[79,4],values_sA2_L[86,4],values_sA2_L[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA2_R[2,4],values_sA2_R[9,4],values_sA2_R[16,4],values_sA2_R[23,4],values_sA2_R[30,4],values_sA2_R[37,4],values_sA2_R[44,4],values_sA2_R[51,4],values_sA2_R[58,4],values_sA2_R[65,4],values_sA2_R[72,4],values_sA2_R[79,4],values_sA2_R[86,4],values_sA2_R[93,4])

# Session A3a
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA3a_L[2,4],values_sA3a_L[9,4],values_sA3a_L[16,4],values_sA3a_L[23,4],values_sA3a_L[30,4],values_sA3a_L[37,4],values_sA3a_L[44,4],values_sA3a_L[51,4],values_sA3a_L[58,4],values_sA3a_L[65,4],values_sA3a_L[72,4],values_sA3a_L[79,4],values_sA3a_L[86,4],values_sA3a_L[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA3a_R[2,4],values_sA3a_R[9,4],values_sA3a_R[16,4],values_sA3a_R[23,4],values_sA3a_R[30,4],values_sA3a_R[37,4],values_sA3a_R[44,4],values_sA3a_R[51,4],values_sA3a_R[58,4],values_sA3a_R[65,4],values_sA3a_R[72,4],values_sA3a_R[79,4],values_sA3a_R[86,4],values_sA3a_R[93,4])

# Session A4a
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA4a_L[2,4],values_sA4a_L[9,4],values_sA4a_L[16,4],values_sA4a_L[23,4],values_sA4a_L[30,4],values_sA4a_L[37,4],values_sA4a_L[44,4],values_sA4a_L[51,4],values_sA4a_L[58,4],values_sA4a_L[65,4],values_sA4a_L[72,4],values_sA4a_L[79,4],values_sA4a_L[86,4],values_sA4a_L[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA4a_R[2,4],values_sA4a_R[9,4],values_sA4a_R[16,4],values_sA4a_R[23,4],values_sA4a_R[30,4],values_sA4a_R[37,4],values_sA4a_R[44,4],values_sA4a_R[51,4],values_sA4a_R[58,4],values_sA4a_R[65,4],values_sA4a_R[72,4],values_sA4a_R[79,4],values_sA4a_R[86,4],values_sA4a_R[93,4])

# Session A5
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA5_L[2,4],values_sA5_L[9,4],values_sA5_L[16,4],values_sA5_L[23,4],values_sA5_L[30,4],values_sA5_L[37,4],values_sA5_L[44,4],values_sA5_L[51,4],values_sA5_L[58,4],values_sA5_L[65,4],values_sA5_L[72,4],values_sA5_L[79,4],values_sA5_L[86,4],values_sA5_L[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA5_R[2,4],values_sA5_R[9,4],values_sA5_R[16,4],values_sA5_R[23,4],values_sA5_R[30,4],values_sA5_R[37,4],values_sA5_R[44,4],values_sA5_R[51,4],values_sA5_R[58,4],values_sA5_R[65,4],values_sA5_R[72,4],values_sA5_R[79,4],values_sA5_R[86,4],values_sA5_R[93,4])

# Session A6
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA6_L[2,4],values_sA6_L[9,4],values_sA6_L[16,4],values_sA6_L[23,4],values_sA6_L[30,4],values_sA6_L[37,4],values_sA6_L[44,4],values_sA6_L[51,4],values_sA6_L[58,4],values_sA6_L[65,4],values_sA6_L[72,4],values_sA6_L[79,4],values_sA6_L[86,4],values_sA6_L[93,4])
# RIGHT
ADC_values[nrow(ADC_values) + 1,] <- c(values_sA6_R[2,4],values_sA6_R[9,4],values_sA6_R[16,4],values_sA6_R[23,4],values_sA6_R[30,4],values_sA6_R[37,4],values_sA6_R[44,4],values_sA6_R[51,4],values_sA6_R[58,4],values_sA6_R[65,4],values_sA6_R[72,4],values_sA6_R[79,4],values_sA6_R[86,4],values_sA6_R[93,4])

rownames(ADC_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(ADC_values,file="ADC_values.Rda")


###
### AD 3 - 10 - 17 - ...
###

# Session A1a
AD_values <- data.frame(values_sA1a_L[3,4],values_sA1a_L[10,4],values_sA1a_L[17,4],values_sA1a_L[24,4],values_sA1a_L[31,4],values_sA1a_L[38,4],values_sA1a_L[45,4],values_sA1a_L[52,4],values_sA1a_L[59,4],values_sA1a_L[66,4],values_sA1a_L[73,4],values_sA1a_L[80,4],values_sA1a_L[87,4],values_sA1a_L[94,4])
colnames(AD_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA1a_R[3,4],values_sA1a_R[10,4],values_sA1a_R[17,4],values_sA1a_R[24,4],values_sA1a_R[31,4],values_sA1a_R[38,4],values_sA1a_R[45,4],values_sA1a_R[52,4],values_sA1a_R[59,4],values_sA1a_R[66,4],values_sA1a_R[73,4],values_sA1a_R[80,4],values_sA1a_R[87,4],values_sA1a_R[94,4])

# Session A2
AD_values[nrow(AD_values) + 1,] <- c(values_sA2_L[3,4],values_sA2_L[10,4],values_sA2_L[17,4],values_sA2_L[24,4],values_sA2_L[31,4],values_sA2_L[38,4],values_sA2_L[45,4],values_sA2_L[52,4],values_sA2_L[59,4],values_sA2_L[66,4],values_sA2_L[73,4],values_sA2_L[80,4],values_sA2_L[87,4],values_sA2_L[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA2_R[3,4],values_sA2_R[10,4],values_sA2_R[17,4],values_sA2_R[24,4],values_sA2_R[31,4],values_sA2_R[38,4],values_sA2_R[45,4],values_sA2_R[52,4],values_sA2_R[59,4],values_sA2_R[66,4],values_sA2_R[73,4],values_sA2_R[80,4],values_sA2_R[87,4],values_sA2_R[94,4])

# Session A3a
AD_values[nrow(AD_values) + 1,] <- c(values_sA3a_L[3,4],values_sA3a_L[10,4],values_sA3a_L[17,4],values_sA3a_L[24,4],values_sA3a_L[31,4],values_sA3a_L[38,4],values_sA3a_L[45,4],values_sA3a_L[52,4],values_sA3a_L[59,4],values_sA3a_L[66,4],values_sA3a_L[73,4],values_sA3a_L[80,4],values_sA3a_L[87,4],values_sA3a_L[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA3a_R[3,4],values_sA3a_R[10,4],values_sA3a_R[17,4],values_sA3a_R[24,4],values_sA3a_R[31,4],values_sA3a_R[38,4],values_sA3a_R[45,4],values_sA3a_R[52,4],values_sA3a_R[59,4],values_sA3a_R[66,4],values_sA3a_R[73,4],values_sA3a_R[80,4],values_sA3a_R[87,4],values_sA3a_R[94,4])

# Session A4a
AD_values[nrow(AD_values) + 1,] <- c(values_sA4a_L[3,4],values_sA4a_L[10,4],values_sA4a_L[17,4],values_sA4a_L[24,4],values_sA4a_L[31,4],values_sA4a_L[38,4],values_sA4a_L[45,4],values_sA4a_L[52,4],values_sA4a_L[59,4],values_sA4a_L[66,4],values_sA4a_L[73,4],values_sA4a_L[80,4],values_sA4a_L[87,4],values_sA4a_L[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA4a_R[3,4],values_sA4a_R[10,4],values_sA4a_R[17,4],values_sA4a_R[24,4],values_sA4a_R[31,4],values_sA4a_R[38,4],values_sA4a_R[45,4],values_sA4a_R[52,4],values_sA4a_R[59,4],values_sA4a_R[66,4],values_sA4a_R[73,4],values_sA4a_R[80,4],values_sA4a_R[87,4],values_sA4a_R[94,4])

# Session A5
AD_values[nrow(AD_values) + 1,] <- c(values_sA5_L[3,4],values_sA5_L[10,4],values_sA5_L[17,4],values_sA5_L[24,4],values_sA5_L[31,4],values_sA5_L[38,4],values_sA5_L[45,4],values_sA5_L[52,4],values_sA5_L[59,4],values_sA5_L[66,4],values_sA5_L[73,4],values_sA5_L[80,4],values_sA5_L[87,4],values_sA5_L[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA5_R[3,4],values_sA5_R[10,4],values_sA5_R[17,4],values_sA5_R[24,4],values_sA5_R[31,4],values_sA5_R[38,4],values_sA5_R[45,4],values_sA5_R[52,4],values_sA5_R[59,4],values_sA5_R[66,4],values_sA5_R[73,4],values_sA5_R[80,4],values_sA5_R[87,4],values_sA5_R[94,4])

# Session A6
AD_values[nrow(AD_values) + 1,] <- c(values_sA6_L[3,4],values_sA6_L[10,4],values_sA6_L[17,4],values_sA6_L[24,4],values_sA6_L[31,4],values_sA6_L[38,4],values_sA6_L[45,4],values_sA6_L[52,4],values_sA6_L[59,4],values_sA6_L[66,4],values_sA6_L[73,4],values_sA6_L[80,4],values_sA6_L[87,4],values_sA6_L[94,4])
# RIGHT
AD_values[nrow(AD_values) + 1,] <- c(values_sA6_R[3,4],values_sA6_R[10,4],values_sA6_R[17,4],values_sA6_R[24,4],values_sA6_R[31,4],values_sA6_R[38,4],values_sA6_R[45,4],values_sA6_R[52,4],values_sA6_R[59,4],values_sA6_R[66,4],values_sA6_R[73,4],values_sA6_R[80,4],values_sA6_R[87,4],values_sA6_R[94,4])

rownames(AD_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(AD_values,file="AD_values.Rda")


###
### RD 4 - 11 - 18 - ...
###

# Session A1a
RD_values <- data.frame(values_sA1a_L[4,4],values_sA1a_L[11,4],values_sA1a_L[18,4],values_sA1a_L[25,4],values_sA1a_L[32,4],values_sA1a_L[39,4],values_sA1a_L[46,4],values_sA1a_L[53,4],values_sA1a_L[60,4],values_sA1a_L[67,4],values_sA1a_L[74,4],values_sA1a_L[81,4],values_sA1a_L[88,4],values_sA1a_L[95,4])
colnames(RD_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA1a_R[4,4],values_sA1a_R[11,4],values_sA1a_R[18,4],values_sA1a_R[25,4],values_sA1a_R[32,4],values_sA1a_R[39,4],values_sA1a_R[46,4],values_sA1a_R[53,4],values_sA1a_R[60,4],values_sA1a_R[67,4],values_sA1a_R[74,4],values_sA1a_R[81,4],values_sA1a_R[88,4],values_sA1a_R[95,4])

# Session A2
RD_values[nrow(RD_values) + 1,] <- c(values_sA2_L[4,4],values_sA2_L[11,4],values_sA2_L[18,4],values_sA2_L[25,4],values_sA2_L[32,4],values_sA2_L[39,4],values_sA2_L[46,4],values_sA2_L[53,4],values_sA2_L[60,4],values_sA2_L[67,4],values_sA2_L[74,4],values_sA2_L[81,4],values_sA2_L[88,4],values_sA2_L[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA2_R[4,4],values_sA2_R[11,4],values_sA2_R[18,4],values_sA2_R[25,4],values_sA2_R[32,4],values_sA2_R[39,4],values_sA2_R[46,4],values_sA2_R[53,4],values_sA2_R[60,4],values_sA2_R[67,4],values_sA2_R[74,4],values_sA2_R[81,4],values_sA2_R[88,4],values_sA2_R[95,4])

# Session A3a
RD_values[nrow(RD_values) + 1,] <- c(values_sA3a_L[4,4],values_sA3a_L[11,4],values_sA3a_L[18,4],values_sA3a_L[25,4],values_sA3a_L[32,4],values_sA3a_L[39,4],values_sA3a_L[46,4],values_sA3a_L[53,4],values_sA3a_L[60,4],values_sA3a_L[67,4],values_sA3a_L[74,4],values_sA3a_L[81,4],values_sA3a_L[88,4],values_sA3a_L[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA3a_R[4,4],values_sA3a_R[11,4],values_sA3a_R[18,4],values_sA3a_R[25,4],values_sA3a_R[32,4],values_sA3a_R[39,4],values_sA3a_R[46,4],values_sA3a_R[53,4],values_sA3a_R[60,4],values_sA3a_R[67,4],values_sA3a_R[74,4],values_sA3a_R[81,4],values_sA3a_R[88,4],values_sA3a_R[95,4])

# Session A4a
RD_values[nrow(RD_values) + 1,] <- c(values_sA4a_L[4,4],values_sA4a_L[11,4],values_sA4a_L[18,4],values_sA4a_L[25,4],values_sA4a_L[32,4],values_sA4a_L[39,4],values_sA4a_L[46,4],values_sA4a_L[53,4],values_sA4a_L[60,4],values_sA4a_L[67,4],values_sA4a_L[74,4],values_sA4a_L[81,4],values_sA4a_L[88,4],values_sA4a_L[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA4a_R[4,4],values_sA4a_R[11,4],values_sA4a_R[18,4],values_sA4a_R[25,4],values_sA4a_R[32,4],values_sA4a_R[39,4],values_sA4a_R[46,4],values_sA4a_R[53,4],values_sA4a_R[60,4],values_sA4a_R[67,4],values_sA4a_R[74,4],values_sA4a_R[81,4],values_sA4a_R[88,4],values_sA4a_R[95,4])

# Session A5
RD_values[nrow(RD_values) + 1,] <- c(values_sA5_L[4,4],values_sA5_L[11,4],values_sA5_L[18,4],values_sA5_L[25,4],values_sA5_L[32,4],values_sA5_L[39,4],values_sA5_L[46,4],values_sA5_L[53,4],values_sA5_L[60,4],values_sA5_L[67,4],values_sA5_L[74,4],values_sA5_L[81,4],values_sA5_L[88,4],values_sA5_L[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA5_R[4,4],values_sA5_R[11,4],values_sA5_R[18,4],values_sA5_R[25,4],values_sA5_R[32,4],values_sA5_R[39,4],values_sA5_R[46,4],values_sA5_R[53,4],values_sA5_R[60,4],values_sA5_R[67,4],values_sA5_R[74,4],values_sA5_R[81,4],values_sA5_R[88,4],values_sA5_R[95,4])

# Session A6
RD_values[nrow(RD_values) + 1,] <- c(values_sA6_L[4,4],values_sA6_L[11,4],values_sA6_L[18,4],values_sA6_L[25,4],values_sA6_L[32,4],values_sA6_L[39,4],values_sA6_L[46,4],values_sA6_L[53,4],values_sA6_L[60,4],values_sA6_L[67,4],values_sA6_L[74,4],values_sA6_L[81,4],values_sA6_L[88,4],values_sA6_L[95,4])
# RIGHT
RD_values[nrow(RD_values) + 1,] <- c(values_sA6_R[4,4],values_sA6_R[11,4],values_sA6_R[18,4],values_sA6_R[25,4],values_sA6_R[32,4],values_sA6_R[39,4],values_sA6_R[46,4],values_sA6_R[53,4],values_sA6_R[60,4],values_sA6_R[67,4],values_sA6_R[74,4],values_sA6_R[81,4],values_sA6_R[88,4],values_sA6_R[95,4])

rownames(RD_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(RD_values,file="RD_values.Rda")


###
### CL 5 - 12 - 19 - ...
###

# Session A1a
CL_values <- data.frame(values_sA1a_L[5,4],values_sA1a_L[12,4],values_sA1a_L[19,4],values_sA1a_L[26,4],values_sA1a_L[33,4],values_sA1a_L[40,4],values_sA1a_L[47,4],values_sA1a_L[54,4],values_sA1a_L[61,4],values_sA1a_L[68,4],values_sA1a_L[75,4],values_sA1a_L[82,4],values_sA1a_L[89,4],values_sA1a_L[96,4])
colnames(CL_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA1a_R[5,4],values_sA1a_R[12,4],values_sA1a_R[19,4],values_sA1a_R[26,4],values_sA1a_R[33,4],values_sA1a_R[40,4],values_sA1a_R[47,4],values_sA1a_R[54,4],values_sA1a_R[61,4],values_sA1a_R[68,4],values_sA1a_R[75,4],values_sA1a_R[82,4],values_sA1a_R[89,4],values_sA1a_R[96,4])

# Session A2
CL_values[nrow(CL_values) + 1,] <- c(values_sA2_L[5,4],values_sA2_L[12,4],values_sA2_L[19,4],values_sA2_L[26,4],values_sA2_L[33,4],values_sA2_L[40,4],values_sA2_L[47,4],values_sA2_L[54,4],values_sA2_L[61,4],values_sA2_L[68,4],values_sA2_L[75,4],values_sA2_L[82,4],values_sA2_L[89,4],values_sA2_L[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA2_R[5,4],values_sA2_R[12,4],values_sA2_R[19,4],values_sA2_R[26,4],values_sA2_R[33,4],values_sA2_R[40,4],values_sA2_R[47,4],values_sA2_R[54,4],values_sA2_R[61,4],values_sA2_R[68,4],values_sA2_R[75,4],values_sA2_R[82,4],values_sA2_R[89,4],values_sA2_R[96,4])

# Session A3a
CL_values[nrow(CL_values) + 1,] <- c(values_sA3a_L[5,4],values_sA3a_L[12,4],values_sA3a_L[19,4],values_sA3a_L[26,4],values_sA3a_L[33,4],values_sA3a_L[40,4],values_sA3a_L[47,4],values_sA3a_L[54,4],values_sA3a_L[61,4],values_sA3a_L[68,4],values_sA3a_L[75,4],values_sA3a_L[82,4],values_sA3a_L[89,4],values_sA3a_L[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA3a_R[5,4],values_sA3a_R[12,4],values_sA3a_R[19,4],values_sA3a_R[26,4],values_sA3a_R[33,4],values_sA3a_R[40,4],values_sA3a_R[47,4],values_sA3a_R[54,4],values_sA3a_R[61,4],values_sA3a_R[68,4],values_sA3a_R[75,4],values_sA3a_R[82,4],values_sA3a_R[89,4],values_sA3a_R[96,4])

# Session A4a
CL_values[nrow(CL_values) + 1,] <- c(values_sA4a_L[5,4],values_sA4a_L[12,4],values_sA4a_L[19,4],values_sA4a_L[26,4],values_sA4a_L[33,4],values_sA4a_L[40,4],values_sA4a_L[47,4],values_sA4a_L[54,4],values_sA4a_L[61,4],values_sA4a_L[68,4],values_sA4a_L[75,4],values_sA4a_L[82,4],values_sA4a_L[89,4],values_sA4a_L[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA4a_R[5,4],values_sA4a_R[12,4],values_sA4a_R[19,4],values_sA4a_R[26,4],values_sA4a_R[33,4],values_sA4a_R[40,4],values_sA4a_R[47,4],values_sA4a_R[54,4],values_sA4a_R[61,4],values_sA4a_R[68,4],values_sA4a_R[75,4],values_sA4a_R[82,4],values_sA4a_R[89,4],values_sA4a_R[96,4])

# Session A5
CL_values[nrow(CL_values) + 1,] <- c(values_sA5_L[5,4],values_sA5_L[12,4],values_sA5_L[19,4],values_sA5_L[26,4],values_sA5_L[33,4],values_sA5_L[40,4],values_sA5_L[47,4],values_sA5_L[54,4],values_sA5_L[61,4],values_sA5_L[68,4],values_sA5_L[75,4],values_sA5_L[82,4],values_sA5_L[89,4],values_sA5_L[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA5_R[5,4],values_sA5_R[12,4],values_sA5_R[19,4],values_sA5_R[26,4],values_sA5_R[33,4],values_sA5_R[40,4],values_sA5_R[47,4],values_sA5_R[54,4],values_sA5_R[61,4],values_sA5_R[68,4],values_sA5_R[75,4],values_sA5_R[82,4],values_sA5_R[89,4],values_sA5_R[96,4])

# Session A6
CL_values[nrow(CL_values) + 1,] <- c(values_sA6_L[5,4],values_sA6_L[12,4],values_sA6_L[19,4],values_sA6_L[26,4],values_sA6_L[33,4],values_sA6_L[40,4],values_sA6_L[47,4],values_sA6_L[54,4],values_sA6_L[61,4],values_sA6_L[68,4],values_sA6_L[75,4],values_sA6_L[82,4],values_sA6_L[89,4],values_sA6_L[96,4])
# RIGHT
CL_values[nrow(CL_values) + 1,] <- c(values_sA6_R[5,4],values_sA6_R[12,4],values_sA6_R[19,4],values_sA6_R[26,4],values_sA6_R[33,4],values_sA6_R[40,4],values_sA6_R[47,4],values_sA6_R[54,4],values_sA6_R[61,4],values_sA6_R[68,4],values_sA6_R[75,4],values_sA6_R[82,4],values_sA6_R[89,4],values_sA6_R[96,4])

rownames(CL_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(CL_values,file="CL_values.Rda")


###
### CP 6 - 13 - 20 - ...
###

# Session A1a
CP_values <- data.frame(values_sA1a_L[6,4],values_sA1a_L[13,4],values_sA1a_L[20,4],values_sA1a_L[27,4],values_sA1a_L[34,4],values_sA1a_L[41,4],values_sA1a_L[48,4],values_sA1a_L[55,4],values_sA1a_L[62,4],values_sA1a_L[69,4],values_sA1a_L[76,4],values_sA1a_L[83,4],values_sA1a_L[90,4],values_sA1a_L[97,4])
colnames(CP_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA1a_R[6,4],values_sA1a_R[13,4],values_sA1a_R[20,4],values_sA1a_R[27,4],values_sA1a_R[34,4],values_sA1a_R[41,4],values_sA1a_R[48,4],values_sA1a_R[55,4],values_sA1a_R[62,4],values_sA1a_R[69,4],values_sA1a_R[76,4],values_sA1a_R[83,4],values_sA1a_R[90,4],values_sA1a_R[97,4])

# Session A2
CP_values[nrow(CP_values) + 1,] <- c(values_sA2_L[6,4],values_sA2_L[13,4],values_sA2_L[20,4],values_sA2_L[27,4],values_sA2_L[34,4],values_sA2_L[41,4],values_sA2_L[48,4],values_sA2_L[55,4],values_sA2_L[62,4],values_sA2_L[69,4],values_sA2_L[76,4],values_sA2_L[83,4],values_sA2_L[90,4],values_sA2_L[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA2_R[6,4],values_sA2_R[13,4],values_sA2_R[20,4],values_sA2_R[27,4],values_sA2_R[34,4],values_sA2_R[41,4],values_sA2_R[48,4],values_sA2_R[55,4],values_sA2_R[62,4],values_sA2_R[69,4],values_sA2_R[76,4],values_sA2_R[83,4],values_sA2_R[90,4],values_sA2_R[97,4])

# Session A3a
CP_values[nrow(CP_values) + 1,] <- c(values_sA3a_L[6,4],values_sA3a_L[13,4],values_sA3a_L[20,4],values_sA3a_L[27,4],values_sA3a_L[34,4],values_sA3a_L[41,4],values_sA3a_L[48,4],values_sA3a_L[55,4],values_sA3a_L[62,4],values_sA3a_L[69,4],values_sA3a_L[76,4],values_sA3a_L[83,4],values_sA3a_L[90,4],values_sA3a_L[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA3a_R[6,4],values_sA3a_R[13,4],values_sA3a_R[20,4],values_sA3a_R[27,4],values_sA3a_R[34,4],values_sA3a_R[41,4],values_sA3a_R[48,4],values_sA3a_R[55,4],values_sA3a_R[62,4],values_sA3a_R[69,4],values_sA3a_R[76,4],values_sA3a_R[83,4],values_sA3a_R[90,4],values_sA3a_R[97,4])

# Session A4a
CP_values[nrow(CP_values) + 1,] <- c(values_sA4a_L[6,4],values_sA4a_L[13,4],values_sA4a_L[20,4],values_sA4a_L[27,4],values_sA4a_L[34,4],values_sA4a_L[41,4],values_sA4a_L[48,4],values_sA4a_L[55,4],values_sA4a_L[62,4],values_sA4a_L[69,4],values_sA4a_L[76,4],values_sA4a_L[83,4],values_sA4a_L[90,4],values_sA4a_L[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA4a_R[6,4],values_sA4a_R[13,4],values_sA4a_R[20,4],values_sA4a_R[27,4],values_sA4a_R[34,4],values_sA4a_R[41,4],values_sA4a_R[48,4],values_sA4a_R[55,4],values_sA4a_R[62,4],values_sA4a_R[69,4],values_sA4a_R[76,4],values_sA4a_R[83,4],values_sA4a_R[90,4],values_sA4a_R[97,4])

# Session A5
CP_values[nrow(CP_values) + 1,] <- c(values_sA5_L[6,4],values_sA5_L[13,4],values_sA5_L[20,4],values_sA5_L[27,4],values_sA5_L[34,4],values_sA5_L[41,4],values_sA5_L[48,4],values_sA5_L[55,4],values_sA5_L[62,4],values_sA5_L[69,4],values_sA5_L[76,4],values_sA5_L[83,4],values_sA5_L[90,4],values_sA5_L[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA5_R[6,4],values_sA5_R[13,4],values_sA5_R[20,4],values_sA5_R[27,4],values_sA5_R[34,4],values_sA5_R[41,4],values_sA5_R[48,4],values_sA5_R[55,4],values_sA5_R[62,4],values_sA5_R[69,4],values_sA5_R[76,4],values_sA5_R[83,4],values_sA5_R[90,4],values_sA5_R[97,4])

# Session A6
CP_values[nrow(CP_values) + 1,] <- c(values_sA6_L[6,4],values_sA6_L[13,4],values_sA6_L[20,4],values_sA6_L[27,4],values_sA6_L[34,4],values_sA6_L[41,4],values_sA6_L[48,4],values_sA6_L[55,4],values_sA6_L[62,4],values_sA6_L[69,4],values_sA6_L[76,4],values_sA6_L[83,4],values_sA6_L[90,4],values_sA6_L[97,4])
# RIGHT
CP_values[nrow(CP_values) + 1,] <- c(values_sA6_R[6,4],values_sA6_R[13,4],values_sA6_R[20,4],values_sA6_R[27,4],values_sA6_R[34,4],values_sA6_R[41,4],values_sA6_R[48,4],values_sA6_R[55,4],values_sA6_R[62,4],values_sA6_R[69,4],values_sA6_R[76,4],values_sA6_R[83,4],values_sA6_R[90,4],values_sA6_R[97,4])

rownames(CP_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(CP_values,file="CP_values.Rda")


###
### CS 7 - 14 - 21 - ...
###

# Session A1a
CS_values <- data.frame(values_sA1a_L[7,4],values_sA1a_L[14,4],values_sA1a_L[21,4],values_sA1a_L[28,4],values_sA1a_L[35,4],values_sA1a_L[42,4],values_sA1a_L[49,4],values_sA1a_L[56,4],values_sA1a_L[63,4],values_sA1a_L[70,4],values_sA1a_L[77,4],values_sA1a_L[84,4],values_sA1a_L[91,4],values_sA1a_L[98,4])
colnames(CS_values) <- c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA1a_R[7,4],values_sA1a_R[14,4],values_sA1a_R[21,4],values_sA1a_R[28,4],values_sA1a_R[35,4],values_sA1a_R[42,4],values_sA1a_R[49,4],values_sA1a_R[56,4],values_sA1a_R[63,4],values_sA1a_R[70,4],values_sA1a_R[77,4],values_sA1a_R[84,4],values_sA1a_R[91,4],values_sA1a_R[98,4])

# Session A2
CS_values[nrow(CS_values) + 1,] <- c(values_sA2_L[7,4],values_sA2_L[14,4],values_sA2_L[21,4],values_sA2_L[28,4],values_sA2_L[35,4],values_sA2_L[42,4],values_sA2_L[49,4],values_sA2_L[56,4],values_sA2_L[63,4],values_sA2_L[70,4],values_sA2_L[77,4],values_sA2_L[84,4],values_sA2_L[91,4],values_sA2_L[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA2_R[7,4],values_sA2_R[14,4],values_sA2_R[21,4],values_sA2_R[28,4],values_sA2_R[35,4],values_sA2_R[42,4],values_sA2_R[49,4],values_sA2_R[56,4],values_sA2_R[63,4],values_sA2_R[70,4],values_sA2_R[77,4],values_sA2_R[84,4],values_sA2_R[91,4],values_sA2_R[98,4])

# Session A3a
CS_values[nrow(CS_values) + 1,] <- c(values_sA3a_L[7,4],values_sA3a_L[14,4],values_sA3a_L[21,4],values_sA3a_L[28,4],values_sA3a_L[35,4],values_sA3a_L[42,4],values_sA3a_L[49,4],values_sA3a_L[56,4],values_sA3a_L[63,4],values_sA3a_L[70,4],values_sA3a_L[77,4],values_sA3a_L[84,4],values_sA3a_L[91,4],values_sA3a_L[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA3a_R[7,4],values_sA3a_R[14,4],values_sA3a_R[21,4],values_sA3a_R[28,4],values_sA3a_R[35,4],values_sA3a_R[42,4],values_sA3a_R[49,4],values_sA3a_R[56,4],values_sA3a_R[63,4],values_sA3a_R[70,4],values_sA3a_R[77,4],values_sA3a_R[84,4],values_sA3a_R[91,4],values_sA3a_R[98,4])

# Session A4a
CS_values[nrow(CS_values) + 1,] <- c(values_sA4a_L[7,4],values_sA4a_L[14,4],values_sA4a_L[21,4],values_sA4a_L[28,4],values_sA4a_L[35,4],values_sA4a_L[42,4],values_sA4a_L[49,4],values_sA4a_L[56,4],values_sA4a_L[63,4],values_sA4a_L[70,4],values_sA4a_L[77,4],values_sA4a_L[84,4],values_sA4a_L[91,4],values_sA4a_L[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA4a_R[7,4],values_sA4a_R[14,4],values_sA4a_R[21,4],values_sA4a_R[28,4],values_sA4a_R[35,4],values_sA4a_R[42,4],values_sA4a_R[49,4],values_sA4a_R[56,4],values_sA4a_R[63,4],values_sA4a_R[70,4],values_sA4a_R[77,4],values_sA4a_R[84,4],values_sA4a_R[91,4],values_sA4a_R[98,4])

# Session A5
CS_values[nrow(CS_values) + 1,] <- c(values_sA5_L[7,4],values_sA5_L[14,4],values_sA5_L[21,4],values_sA5_L[28,4],values_sA5_L[35,4],values_sA5_L[42,4],values_sA5_L[49,4],values_sA5_L[56,4],values_sA5_L[63,4],values_sA5_L[70,4],values_sA5_L[77,4],values_sA5_L[84,4],values_sA5_L[91,4],values_sA5_L[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA5_R[7,4],values_sA5_R[14,4],values_sA5_R[21,4],values_sA5_R[28,4],values_sA5_R[35,4],values_sA5_R[42,4],values_sA5_R[49,4],values_sA5_R[56,4],values_sA5_R[63,4],values_sA5_R[70,4],values_sA5_R[77,4],values_sA5_R[84,4],values_sA5_R[91,4],values_sA5_R[98,4])

# Session A6
CS_values[nrow(CS_values) + 1,] <- c(values_sA6_L[7,4],values_sA6_L[14,4],values_sA6_L[21,4],values_sA6_L[28,4],values_sA6_L[35,4],values_sA6_L[42,4],values_sA6_L[49,4],values_sA6_L[56,4],values_sA6_L[63,4],values_sA6_L[70,4],values_sA6_L[77,4],values_sA6_L[84,4],values_sA6_L[91,4],values_sA6_L[98,4])
# RIGHT
CS_values[nrow(CS_values) + 1,] <- c(values_sA6_R[7,4],values_sA6_R[14,4],values_sA6_R[21,4],values_sA6_R[28,4],values_sA6_R[35,4],values_sA6_R[42,4],values_sA6_R[49,4],values_sA6_R[56,4],values_sA6_R[63,4],values_sA6_R[70,4],values_sA6_R[77,4],values_sA6_R[84,4],values_sA6_R[91,4],values_sA6_R[98,4])

rownames(CS_values) <- c("sA1a_L", "sA1a_R", "sA2_L", "sA2_R", "sA3a_L", "sA3a_R", "sA4a_L", "sA4a_R", "sA5_L", "sA5_R", "sA6_L", "sA6_R")
save(CS_values,file="CS_values.Rda")

# Cleanup environment
rm(list = ls()[grepl("values_", ls())])


load("PD_demograph.rda")
