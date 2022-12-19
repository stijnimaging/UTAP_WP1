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
setwd("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/")
rm(list = ls())

# The one variable that needs to be changed! A1a, A2, A3a, A4a, A5 or A6
target <- "A2"
session <- paste("Session",target,sep = "")
#
# Process FA values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="FA_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
FA_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$FA_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$FA_mean[i] <- 0
  }
}  

Left <- filter(results, str_detect(results$file_name, "^*mask_L"))
Right <- filter(results, str_detect(results$file_name, "^*mask_R"))

#
# Process AD values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="AD_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
AD_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$AD_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$AD_mean[i] <- 0
  }
}  
Left_AD <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$AD_mean <- Left_AD$AD_mean
Right_AD <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$AD_mean <- Right_AD$AD_mean

#
# Process ADC values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="ADC_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
ADC_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$ADC_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$ADC_mean[i] <- 0
  }
}  
Left_ADC <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$ADC_mean <- Left_ADC$ADC_mean
Right_ADC <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$ADC_mean <- Right_ADC$ADC_mean


#
# Process RD values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="RD_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
RD_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$RD_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$RD_mean[i] <- 0
  }
}  
Left_RD <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$RD_mean <- Left_RD$RD_mean
Right_RD <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$RD_mean <- Right_RD$RD_mean


#
# Process CL values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="CL_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
CL_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$CL_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$CL_mean[i] <- 0
  }
}  
Left_CL <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$CL_mean <- Left_CL$CL_mean
Right_CL <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$CL_mean <- Right_CL$CL_mean

#
# Process CP values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="CP_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
CP_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$CP_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$CP_mean[i] <- 0
  }
}  
Left_CP <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$CP_mean <- Left_CP$CP_mean
Right_CP <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$CP_mean <- Right_CP$CP_mean

#
# Process CS values
#
# Create variables
data_files <- list.files(path=paste(paste("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/s", target, sep = ""),"/VALUES/",sep = ""), pattern="CS_Mask*", full.names=TRUE, recursive=FALSE)
results <- data.frame(file_name = vector(mode = "character", length = length(data_files)))
results$file_name <- "empty"
fibers <- vector(mode = "integer", length = length(data_files))
CS_mean <- vector(mode = "integer", length = length(data_files))

for (i in 1:length(data_files)){
  if (length(readLines(data_files[i])) > 0) {
    df <- read.table(data_files[i], skip = 0,  dec = ".") # Load file
    df <- t(df) # Transpose dataframe
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8) # Grab filename 
    results$fibers[i] <- length(df) # Length is number of fibers
    results$CS_mean[i] <- mean(df) # Get mean values
  } else {
    results$file_name[i] <- substr(data_files[i],70,nchar(data_files[i])-8)
    results$fibers[i] <- 0
    results$CS_mean[i] <- 0
  }
}  
Left_CS <- filter(results, str_detect(results$file_name, "^*mask_L"))
Left$CS_mean <- Left_CS$CS_mean
Right_CS <- filter(results, str_detect(results$file_name, "^*mask_R"))
Right$CS_mean <- Right_CS$CS_mean

# Set rownames
if (nchar(target)==2) { # Name is without a (and add F to the variable)
  Left2 <- Left[,-1]
  rownames(Left2) <- paste0("F", Left[,1])
  Right2 <- Right[,-1]
  rownames(Right2) <- paste0("F", Right[,1])
} else { # Name is with a (no need to add F to the variable)
  Left2 <- Left[,-1]
  rownames(Left2) <- Left[,1]
  Right2 <- Right[,-1]
  rownames(Right2) <- Right[,1]
}


# Assign names to variables
assign(paste(paste("Session", target, sep = ""),"_Left", sep = ""), Left2)
assign(paste(paste("Session", target, sep = ""),"_Right", sep = ""), Right2)

# Clean up environment
rm(list = ls()[grepl("Right_", ls())])
rm(list = ls()[grepl("Left_", ls())])


# Save output
save(list = paste0(paste0("Session", target),"_Left"), file=paste0(paste0("Session",target),"_Left.rda"))
save(list = paste0(paste0("Session", target),"_Right"), file=paste0(paste0("Session",target),"_Right.rda"))

