#
# Data processing and Statistics for UTAP WP1
#
# Department of Neurosurgery, Stijn Michielse, 2022
#
# Requirements
library(dplyr)
library(tibble)
library(Rfit)
library(xlsx)
library(tableone)
library(ggplot2)
library(dplyr)
library(tidyverse)

rm(list=ls())

# Go to the server working directory
setwd("/Volumes/research-1/UTAP_WP1/MRI_DATA/VALUES")

##
##
## MERGE VOLUMETRICS AND DTI DATA WITH DEMOGRAPHICS
##
##
load("PD_demograph.rda")
load("volumes_overview.rda")
load("Count_values.rda")
load("FA_values.rda")
load("AD_values.rda")
load("ADC_values.rda")
load("RD_values.rda")
load("CL_values.rda")
load("CP_values.rda")
load("CS_values.rda")

# Set volume measure correctly in mL
PD_demograph$Volume <- PD_demograph$Volume/1000000000

# Change status as factor
PD_demograph$Status <- as.factor(PD_demograph$Status)
levels(PD_demograph$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

Count_DG <- merge(PD_demograph,Count_values,by="SessionAx_V")
Volume_DG <- merge(PD_demograph,volumes_overview,by="SessionAx_V")
FA_DG <- merge(PD_demograph,FA_values,by="SessionAx_V")
AD_DG <- merge(PD_demograph,AD_values,by="SessionAx_V")
ADC_DG <- merge(PD_demograph,ADC_values,by="SessionAx_V")
RD_DG <- merge(PD_demograph,RD_values,by="SessionAx_V")
CL_DG <- merge(PD_demograph,CL_values,by="SessionAx_V")
CP_DG <- merge(PD_demograph,CP_values,by="SessionAx_V")
CS_DG <- merge(PD_demograph,CS_values,by="SessionAx_V")

#
# Significant volume difference HC-TD
#
# Data wrangling to extract only the ROI with significant findings
GPe <- data.frame(cbind(Volume_DG$Status, Volume_DG$GPe, "Globus pallidus externa"))
colnames(GPe) <- c("Status", "Value", "ROI")
IntThalAdh <- data.frame(cbind(Volume_DG$Status, Volume_DG$IntThalAdh, "Internal Thalamic Adhesion"))
colnames(IntThalAdh) <- c("Status", "Value", "ROI")
Putamen <- data.frame(cbind(Volume_DG$Status, Volume_DG$Putamen, "Putamen"))
colnames(Putamen) <- c("Status", "Value", "ROI")

GPe$Status <- as.factor(GPe$Status)
GPe$ROI <- as.factor(GPe$ROI)
GPe$Value <- as.numeric(GPe$Value)
levels(GPe$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")
IntThalAdh$Status <- as.factor(IntThalAdh$Status)
IntThalAdh$ROI <- as.factor(IntThalAdh$ROI)
IntThalAdh$Value <- as.numeric(IntThalAdh$Value)
levels(IntThalAdh$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")
Putamen$Status <- as.factor(Putamen$Status)
Putamen$ROI <- as.factor(Putamen$ROI)
Putamen$Value <- as.numeric(Putamen$Value)
levels(Putamen$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")


# Create violin plot GPe
tiff(file = "Volumes_GPe.tiff", units="in", width=6, height=4, res=300)
GPe_plot <- ggplot(GPe, aes(x=Status, y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5) +
  geom_boxplot(width=0.1, position=position_dodge(.9)) +
  labs(title="Globus Pallidus Externa Volume",x="", y = "Values") 
GPe_plot + stat_summary(fun.y=median, geom="point", size=2, color="red")
GPe_plot + scale_fill_manual(name = "Group", values=c("#fb6f92", "#77dd77","#70d6ff")) 
dev.off()

# Create violin plot IntThalAdh
tiff(file = "Volumes_IntThalAdh.tiff", units="in", width=6, height=4, res=300)
IntThalAdh_plot <- ggplot(IntThalAdh, aes(x=Status, y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5) +
  geom_boxplot(width=0.1, position=position_dodge(.9)) +
  labs(title="Internal Thalamic Adhesion Volume",x="", y = "Values") 
IntThalAdh_plot + stat_summary(fun.y=median, geom="point", size=2, color="red")
IntThalAdh_plot + scale_fill_manual(name = "Group", values=c("#fb6f92", "#77dd77","#70d6ff")) 
dev.off()

# Create violin plot Putamen
tiff(file = "Volumes_Putamen.tiff", units="in", width=6, height=4, res=300)
Putamen_plot <- ggplot(Putamen, aes(x=Status, y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5) +
  geom_boxplot(width=0.1, position=position_dodge(.9)) +
  labs(title="Putamen volume",x="", y = "Values") 
Putamen_plot + stat_summary(fun.y=median, geom="point", size=2, color="red")
Putamen_plot + scale_fill_manual(name = "Group", values=c("#fb6f92", "#77dd77","#70d6ff")) 
dev.off()

# FA Value differences
# Data wrangling to extract only the ROI with significant findings
Caudate <- data.frame(cbind(FA_DG$Status, FA_DG$Caudate, "Caudate"))
colnames(Caudate) <- c("Status", "Value", "ROI")
SubLentIntCap <- data.frame(cbind(FA_DG$Status, FA_DG$SubLentIntCap, "Sublenticular Internal Capsule"))
colnames(SubLentIntCap) <- c("Status", "Value", "ROI")
STN <- data.frame(cbind(FA_DG$Status, FA_DG$STN, "Sub Thalamic Nucleus"))
colnames(STN) <- c("Status", "Value", "ROI")

FA_ROI_signif <- rbind(Caudate, SubLentIntCap, STN)
save(FA_ROI_signif, file = "FA_sign.rda")

FA_ROI_signif$Status <- as.factor(FA_ROI_signif$Status)
FA_ROI_signif$ROI <- as.factor(FA_ROI_signif$ROI)
FA_ROI_signif$Value <- as.numeric(FA_ROI_signif$Value)
levels(FA_ROI_signif$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Violin Plot Render 
# Significant Findings on FA (each ROI)
tiff(file = "FA_sign.tiff", units="in", width=6, height=4, res=300)
V_FA_ROI_signif <- ggplot(FA_ROI_signif, aes(x=fct_inorder(ROI), y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5, position = position_dodge(width = 0.5)) +
  geom_boxplot(width=0.1, position=position_dodge(.5)) +
  labs(title="Fractional Anisotropy (FA)",x="", y = "")
V_FA_ROI_signif + scale_fill_manual(name = "Group:", values=c("#fb6f92", "#77dd77","#70d6ff")) + 
  theme_minimal() + theme(strip.background = element_blank(),strip.placement = "outside", 
                          axis.ticks.x = element_blank(), plot.title = element_text(hjust = 0.5), 
                          legend.position = "bottom") 
dev.off()

##
## ADC
##

# ADC Value differences
# Data wrangling to extract only the ROI with significant findings
IntThalAdh <- data.frame(cbind(ADC_DG$Status, ADC_DG$IntThalAdh, "Internal Thalamic Adhesion"))
colnames(IntThalAdh) <- c("Status", "Value", "ROI")
Thalamus <- data.frame(cbind(ADC_DG$Status, ADC_DG$Thalamus, "Thalamus"))
colnames(Thalamus) <- c("Status", "Value", "ROI")
STN <- data.frame(cbind(ADC_DG$Status, ADC_DG$STN, "Sub Thalamic Nucleus"))
colnames(STN) <- c("Status", "Value", "ROI")

ADC_ROI_signif <- rbind(IntThalAdh, Thalamus, STN)
save(ADC_ROI_signif, file = "ADC_sign.rda")

ADC_ROI_signif$Status <- as.factor(ADC_ROI_signif$Status)
ADC_ROI_signif$ROI <- as.factor(ADC_ROI_signif$ROI)
ADC_ROI_signif$Value <- as.numeric(ADC_ROI_signif$Value)*1000
levels(ADC_ROI_signif$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Violin Plot Render 
# Significant Findings on ADC (each ROI) Multiplied by factor 1000
tiff(file = "ADC_sign.tiff", units="in", width=6, height=4, res=300)
V_ADC_ROI_signif <- ggplot(ADC_ROI_signif, aes(x=fct_inorder(ROI), y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5, position = position_dodge(width = 0.5)) +
  geom_boxplot(width=0.1, position=position_dodge(.5)) +
  labs(title="Apparent Diffusion Coefficient (ADC)",x="", y = "")
V_ADC_ROI_signif + scale_fill_manual(name = "Group:", values=c("#fb6f92", "#77dd77","#70d6ff")) + 
  theme_minimal() + theme(strip.background = element_blank(),strip.placement = "outside", 
                          axis.ticks.x = element_blank(), plot.title = element_text(hjust = 0.5), 
                          legend.position = "bottom") 
dev.off()


##
## AD
##

# AD Value differences
# Data wrangling to extract only the ROI with significant findings
IntThalAdh <- data.frame(cbind(AD_DG$Status, AD_DG$IntThalAdh, "Int. Thalamic Adhesion"))
colnames(IntThalAdh) <- c("Status", "Value", "ROI")
Thalamus <- data.frame(cbind(AD_DG$Status, AD_DG$Thalamus, "Thalamus"))
colnames(Thalamus) <- c("Status", "Value", "ROI")
STN <- data.frame(cbind(AD_DG$Status, AD_DG$STN, "Sub Thalamic Nucleus"))
colnames(STN) <- c("Status", "Value", "ROI")
LocCoer <- data.frame(cbind(AD_DG$Status, AD_DG$LocCoer, "Locus Coerulus"))
colnames(LocCoer) <- c("Status", "Value", "ROI")
SubLentIntCap <- data.frame(cbind(AD_DG$Status, AD_DG$SubLentIntCap, "Sublen. Int. Capsule"))
colnames(SubLentIntCap) <- c("Status", "Value", "ROI")

AD_ROI_signif <- rbind(IntThalAdh, Thalamus, STN, LocCoer, SubLentIntCap)
save(AD_ROI_signif, file = "AD_sign.rda")

AD_ROI_signif$Status <- as.factor(AD_ROI_signif$Status)
AD_ROI_signif$ROI <- as.factor(AD_ROI_signif$ROI)
AD_ROI_signif$Value <- as.numeric(AD_ROI_signif$Value)*1000
levels(AD_ROI_signif$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Violin Plot Render 
# Significant Findings on ADC (each ROI) Multiplied by factor 1000
tiff(file = "AD_sign.tiff", units="in", width=6, height=4, res=300)
V_AD_ROI_signif <- ggplot(AD_ROI_signif, aes(x=fct_inorder(ROI), y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5, position = position_dodge(width = 0.5)) +
  geom_boxplot(width=0.1, position=position_dodge(.5)) +
  labs(title="Axial Diffusivity (AD)",x="", y = "")
V_AD_ROI_signif + scale_fill_manual(name = "Group:", values=c("#fb6f92", "#77dd77","#70d6ff")) + 
  theme_minimal() + theme(strip.background = element_blank(),strip.placement = "outside", 
                          axis.ticks.x = element_blank(), plot.title = element_text(hjust = 0.5), 
                          legend.position = "bottom") 
dev.off()

##
## RD
##

# RD Value differences
# Data wrangling to extract only the ROI with significant findings
IntThalAdh <- data.frame(cbind(RD_DG$Status, RD_DG$IntThalAdh, "Int. Thalamic Adhesion"))
colnames(IntThalAdh) <- c("Status", "Value", "ROI")
Thalamus <- data.frame(cbind(RD_DG$Status, RD_DG$Thalamus, "Thalamus"))
colnames(Thalamus) <- c("Status", "Value", "ROI")

RD_ROI_signif <- rbind(IntThalAdh, Thalamus)
save(RD_ROI_signif, file = "RD_sign.rda")

RD_ROI_signif$Status <- as.factor(RD_ROI_signif$Status)
RD_ROI_signif$ROI <- as.factor(RD_ROI_signif$ROI)
RD_ROI_signif$Value <- as.numeric(RD_ROI_signif$Value)
levels(RD_ROI_signif$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Violin Plot Render 
# Significant Findings on ADC (each ROI) Multiplied by factor 1000
tiff(file = "RD_sign.tiff", units="in", width=6, height=4, res=300)
V_RD_ROI_signif <- ggplot(RD_ROI_signif, aes(x=fct_inorder(ROI), y=Value, fill=Status)) + 
  geom_violin(trim=FALSE, alpha=0.5, position = position_dodge(width = 0.5)) +
  geom_boxplot(width=0.1, position=position_dodge(.5)) +
  labs(title="Radial Diffusivity (RD)",x="", y = "")
V_RD_ROI_signif + scale_fill_manual(name = "Group:", values=c("#fb6f92", "#77dd77","#70d6ff")) + 
  theme_minimal() + theme(strip.background = element_blank(),strip.placement = "outside", 
                          axis.ticks.x = element_blank(), plot.title = element_text(hjust = 0.5), 
                          legend.position = "bottom") 
dev.off()



####
#### Create boxplot figures
####
# Create violin plot GPe
tiff(file = "Volumes_GPe_box.tiff", units="in", width=6, height=4, res=300)
GPe_plot <- ggplot(GPe, aes(x=Status, y=Value, fill=Status)) + 
  geom_boxplot(width=0.1, position=position_dodge(.9)) +
  labs(title="Globus Pallidus Externa Volume",x="", y = "Values") 
GPe_plot + stat_summary(fun.y=median, geom="point", size=2, color="red")
GPe_plot + scale_fill_manual(name = "Group", values=c("#fb6f92", "#77dd77","#70d6ff")) 
dev.off()

