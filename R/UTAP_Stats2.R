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


rm(list=ls())

# Go to the server working directory
setwd("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES")

# First create a demographics table
load("PD_demograph.rda")

# Set volume measure correctly in mL
PD_demograph$Volume <- PD_demograph$Volume/1000000000
# Multiply AX, ADC and RD by 1000
PD_demograph$AD_Mean <- PD_demograph$AD_Mean*1000
PD_demograph$ADC_Mean <- PD_demograph$ADC_Mean*1000
PD_demograph$RD_Mean <- PD_demograph$RD_Mean*1000

# Change status as factor
PD_demograph$Status <- as.factor(PD_demograph$Status)
levels(PD_demograph$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Make up table and write to xlsx
varlist <- c("Age", "Sex", "DoD", "PMI", "Volume","FA_Mean", "ADC_Mean", "AD_Mean", "RD_Mean", "CL_Mean", "CP_Mean", "CS_Mean")
catVars <- c("Sex")
var_nonnormal <- c("Age", "Sex", "DoD", "PMI", "Volume","FA_Mean", "ADC_Mean", "AD_Mean", "RD_Mean", "CL_Mean", "CP_Mean", "CS_Mean")
tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = PD_demograph, factorVars = catVars)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "UTAP_demographics.xlsx")

# Perform Pairwise comparisons 3x
# AR-HC
# AR-TD
# HC-TD

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

Count_DG <- merge(PD_demograph,Count_values,by="SessionAx_V")
Volume_DG <- merge(PD_demograph,volumes_overview,by="SessionAx_V")
FA_DG <- merge(PD_demograph,FA_values,by="SessionAx_V")
AD_DG <- merge(PD_demograph,AD_values,by="SessionAx_V")
ADC_DG <- merge(PD_demograph,ADC_values,by="SessionAx_V")
RD_DG <- merge(PD_demograph,RD_values,by="SessionAx_V")
CL_DG <- merge(PD_demograph,CL_values,by="SessionAx_V")
CP_DG <- merge(PD_demograph,CP_values,by="SessionAx_V")
CS_DG <- merge(PD_demograph,CS_values,by="SessionAx_V")

##
## Is there any difference in FA value between the groups in any of the regions of interest?
##

# Calculate p-values
FA_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(FA_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(FA_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
FA_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
FA_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
FA_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
FA_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
FA_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
FA_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
FA_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
FA_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
FA_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
FA_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
FA_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
FA_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
FA_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
FA_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
FA_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
FA_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
FA_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
FA_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
FA_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
FA_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
FA_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
FA_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
FA_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
FA_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
FA_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
FA_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
FA_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
FA_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
FA_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
FA_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
FA_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
FA_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
FA_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
FA_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
FA_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
FA_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
FA_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
FA_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
FA_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
FA_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
FA_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
FA_DG$Status[9] <- "1HC"
FA_DG$Status[10] <- "1HC"
FA_DG$Status[11] <- "1HC"
FA_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
FA_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
FA_DG$Status[9] <- "HC"
FA_DG$Status[10] <- "HC"
FA_DG$Status[11] <- "HC"
FA_DG$Status[12] <- "HC"

##
## Is there any difference in AD value between the groups in any of the regions of interest?
##

# Calculate p-values
AD_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(AD_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(AD_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
AD_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
AD_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
AD_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
AD_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
AD_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
AD_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
AD_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
AD_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
AD_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
AD_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
AD_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
AD_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
AD_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
AD_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
AD_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
AD_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
AD_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
AD_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
AD_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
AD_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
AD_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
AD_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
AD_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
AD_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
AD_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
AD_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
AD_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
AD_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
AD_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
AD_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
AD_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
AD_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
AD_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
AD_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
AD_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
AD_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
AD_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
AD_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
AD_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
AD_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
AD_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
AD_DG$Status[9] <- "1HC"
AD_DG$Status[10] <- "1HC"
AD_DG$Status[11] <- "1HC"
AD_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
AD_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
AD_DG$Status[9] <- "HC"
AD_DG$Status[10] <- "HC"
AD_DG$Status[11] <- "HC"
AD_DG$Status[12] <- "HC"


##
## Is there any difference in ADC value between the groups in any of the regions of interest?
##

# Calculate p-values
ADC_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(ADC_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(ADC_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
ADC_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
ADC_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
ADC_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
ADC_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
ADC_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
ADC_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
ADC_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
ADC_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
ADC_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
ADC_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
ADC_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
ADC_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
ADC_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
ADC_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
ADC_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
ADC_DG$Status[9] <- "1HC"
ADC_DG$Status[10] <- "1HC"
ADC_DG$Status[11] <- "1HC"
ADC_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
ADC_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
ADC_DG$Status[9] <- "HC"
ADC_DG$Status[10] <- "HC"
ADC_DG$Status[11] <- "HC"
ADC_DG$Status[12] <- "HC"

##
## Is there any difference in RD value between the groups in any of the regions of interest?
##

# Calculate p-values
RD_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(RD_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(RD_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
RD_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
RD_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
RD_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
RD_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
RD_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
RD_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
RD_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
RD_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
RD_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
RD_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
RD_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
RD_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
RD_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
RD_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
RD_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
RD_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
RD_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
RD_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
RD_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
RD_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
RD_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
RD_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
RD_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
RD_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
RD_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
RD_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
RD_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
RD_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
RD_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
RD_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
RD_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
RD_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
RD_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
RD_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
RD_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
RD_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
RD_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
RD_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
RD_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
RD_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
RD_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
RD_DG$Status[9] <- "1HC"
RD_DG$Status[10] <- "1HC"
RD_DG$Status[11] <- "1HC"
RD_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
RD_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
RD_DG$Status[9] <- "HC"
RD_DG$Status[10] <- "HC"
RD_DG$Status[11] <- "HC"
RD_DG$Status[12] <- "HC"

##
## Is there any difference in CL value between the groups in any of the regions of interest?
##

# Calculate p-values
CL_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(CL_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(CL_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
CL_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
CL_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
CL_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
CL_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
CL_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
CL_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
CL_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
CL_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
CL_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
CL_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
CL_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
CL_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
CL_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
CL_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
CL_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
CL_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
CL_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
CL_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
CL_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
CL_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
CL_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
CL_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
CL_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
CL_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
CL_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
CL_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
CL_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
CL_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
CL_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
CL_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
CL_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
CL_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
CL_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
CL_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
CL_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
CL_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
CL_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
CL_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
CL_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
CL_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
CL_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
CL_DG$Status[9] <- "1HC"
CL_DG$Status[10] <- "1HC"
CL_DG$Status[11] <- "1HC"
CL_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
CL_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
CL_DG$Status[9] <- "HC"
CL_DG$Status[10] <- "HC"
CL_DG$Status[11] <- "HC"
CL_DG$Status[12] <- "HC"

##
## Is there any difference in CP value between the groups in any of the regions of interest?
##

# Calculate p-values
CP_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(CP_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(CP_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
CP_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
CP_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
CP_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
CP_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
CP_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
CP_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
CP_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
CP_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
CP_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
CP_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
CP_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
CP_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
CP_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
CP_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
CP_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
CP_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
CP_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
CP_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
CP_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
CP_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
CP_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
CP_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
CP_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
CP_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
CP_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
CP_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
CP_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
CP_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
CP_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
CP_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
CP_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
CP_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
CP_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
CP_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
CP_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
CP_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
CP_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
CP_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
CP_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
CP_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
CP_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
CP_DG$Status[9] <- "1HC"
CP_DG$Status[10] <- "1HC"
CP_DG$Status[11] <- "1HC"
CP_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
CP_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
CP_DG$Status[9] <- "HC"
CP_DG$Status[10] <- "HC"
CP_DG$Status[11] <- "HC"
CP_DG$Status[12] <- "HC"

##
## Is there any difference in CS value between the groups in any of the regions of interest?
##

# Calculate p-values
CS_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(CS_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(CS_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
CS_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
CS_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
CS_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
CS_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
CS_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
CS_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
CS_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
CS_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
CS_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
CS_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
CS_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
CS_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
CS_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
CS_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
CS_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
CS_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
CS_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
CS_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
CS_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
CS_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
CS_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
CS_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
CS_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
CS_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
CS_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
CS_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
CS_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
CS_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
CS_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
CS_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
CS_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
CS_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
CS_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
CS_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
CS_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
CS_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
CS_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
CS_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
CS_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
CS_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
CS_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
CS_DG$Status[9] <- "1HC"
CS_DG$Status[10] <- "1HC"
CS_DG$Status[11] <- "1HC"
CS_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
CS_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
CS_DG$Status[9] <- "HC"
CS_DG$Status[10] <- "HC"
CS_DG$Status[11] <- "HC"
CS_DG$Status[12] <- "HC"




##
## Is there any difference in Volumes between the groups in any of the regions of interest?
##

# Calculate p-values
Volume_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(Volume_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(Volume_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
Volume_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
Volume_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
Volume_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
Volume_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
Volume_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
Volume_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
Volume_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
Volume_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
Volume_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
Volume_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
Volume_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
Volume_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
Volume_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
Volume_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
Volume_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
Volume_DG$Status[9] <- "1HC"
Volume_DG$Status[10] <- "1HC"
Volume_DG$Status[11] <- "1HC"
Volume_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + Volume, data = Volume_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
Volume_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
Volume_DG$Status[9] <- "HC"
Volume_DG$Status[10] <- "HC"
Volume_DG$Status[11] <- "HC"
Volume_DG$Status[12] <- "HC"

##
## Is there any difference in Fibers between the groups in any of the regions of interest?
##

# Calculate p-values
Fibers_pvalues <- data.frame(matrix(ncol = 3, nrow = 14))
colnames(Fibers_pvalues) <- c('AR-HC', 'AR-TD', 'HC-TD')
rownames(Fibers_pvalues) <- c('AntCom', 'Caudate', 'GPe', 'GPi', 'IntCap', 'IntThalAdh', 'LocCoer', 'Putamen','RedNucl', 'STN', 'SubLentIntCap', 'SubNig', 'Thalamus', 'VentPal')

#AntCom
AntCom_AR <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
AntCom_AR <- data.frame(AntCom_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[1] <- AntCom_AR$p.value[2]
Fibers_pvalues$`AR-TD`[1] <- AntCom_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
AntCom_HC <- summary(rfit(formula = as.numeric(AntCom) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
AntCom_HC <- data.frame(AntCom_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[1] <- AntCom_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#Caudate
Caudate_AR <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Caudate_AR <- data.frame(Caudate_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[2] <- Caudate_AR$p.value[2]
Fibers_pvalues$`AR-TD`[2] <- Caudate_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
Caudate_HC <- summary(rfit(formula = as.numeric(Caudate) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Caudate_HC <- data.frame(Caudate_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[2] <- Caudate_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#GPe
GPe_AR <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
GPe_AR <- data.frame(GPe_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[3] <- GPe_AR$p.value[2]
Fibers_pvalues$`AR-TD`[3] <- GPe_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
GPe_HC <- summary(rfit(formula = as.numeric(GPe) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
GPe_HC <- data.frame(GPe_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[3] <- GPe_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#GPi
GPi_AR <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
GPi_AR <- data.frame(GPi_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[4] <- GPi_AR$p.value[2]
Fibers_pvalues$`AR-TD`[4] <- GPi_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
GPi_HC <- summary(rfit(formula = as.numeric(GPi) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
GPi_HC <- data.frame(GPi_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[4] <- GPi_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#IntCap
IntCap_AR <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
IntCap_AR <- data.frame(IntCap_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[5] <- IntCap_AR$p.value[2]
Fibers_pvalues$`AR-TD`[5] <- IntCap_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
IntCap_HC <- summary(rfit(formula = as.numeric(IntCap) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
IntCap_HC <- data.frame(IntCap_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[5] <- IntCap_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#IntThalAdh
IntThalAdh_AR <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
IntThalAdh_AR <- data.frame(IntThalAdh_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[6] <- IntThalAdh_AR$p.value[2]
Fibers_pvalues$`AR-TD`[6] <- IntThalAdh_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
IntThalAdh_HC <- summary(rfit(formula = as.numeric(IntThalAdh) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
IntThalAdh_HC <- data.frame(IntThalAdh_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[6] <- IntThalAdh_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#LocCoer
LocCoer_AR <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
LocCoer_AR <- data.frame(LocCoer_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[7] <- LocCoer_AR$p.value[2]
Fibers_pvalues$`AR-TD`[7] <- LocCoer_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
LocCoer_HC <- summary(rfit(formula = as.numeric(LocCoer) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
LocCoer_HC <- data.frame(LocCoer_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[7] <- LocCoer_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#Putamen
Putamen_AR <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Putamen_AR <- data.frame(Putamen_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[8] <- Putamen_AR$p.value[2]
Fibers_pvalues$`AR-TD`[8] <- Putamen_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
Putamen_HC <- summary(rfit(formula = as.numeric(Putamen) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Putamen_HC <- data.frame(Putamen_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[8] <- Putamen_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#RedNucl
RedNucl_AR <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
RedNucl_AR <- data.frame(RedNucl_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[9] <- RedNucl_AR$p.value[2]
Fibers_pvalues$`AR-TD`[9] <- RedNucl_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
RedNucl_HC <- summary(rfit(formula = as.numeric(RedNucl) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
RedNucl_HC <- data.frame(RedNucl_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[9] <- RedNucl_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#STN
STN_AR <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
STN_AR <- data.frame(STN_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[10] <- STN_AR$p.value[2]
Fibers_pvalues$`AR-TD`[10] <- STN_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
STN_HC <- summary(rfit(formula = as.numeric(STN) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
STN_HC <- data.frame(STN_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[10] <- STN_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#SubLentIntCap
SubLentIntCap_AR <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
SubLentIntCap_AR <- data.frame(SubLentIntCap_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[11] <- SubLentIntCap_AR$p.value[2]
Fibers_pvalues$`AR-TD`[11] <- SubLentIntCap_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
SubLentIntCap_HC <- summary(rfit(formula = as.numeric(SubLentIntCap) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
SubLentIntCap_HC <- data.frame(SubLentIntCap_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[11] <- SubLentIntCap_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#SubNig
SubNig_AR <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
SubNig_AR <- data.frame(SubNig_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[12] <- SubNig_AR$p.value[2]
Fibers_pvalues$`AR-TD`[12] <- SubNig_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
SubNig_HC <- summary(rfit(formula = as.numeric(SubNig) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
SubNig_HC <- data.frame(SubNig_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[12] <- SubNig_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#Thalamus
Thalamus_AR <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Thalamus_AR <- data.frame(Thalamus_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[13] <- Thalamus_AR$p.value[2]
Fibers_pvalues$`AR-TD`[13] <- Thalamus_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
Thalamus_HC <- summary(rfit(formula = as.numeric(Thalamus) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
Thalamus_HC <- data.frame(Thalamus_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[13] <- Thalamus_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

#VentPal
VentPal_AR <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
VentPal_AR <- data.frame(VentPal_AR[["coefficients"]])
Fibers_pvalues$`AR-HC`[14] <- VentPal_AR$p.value[2]
Fibers_pvalues$`AR-TD`[14] <- VentPal_AR$p.value[3]
Count_DG$Status[9] <- "1HC"
Count_DG$Status[10] <- "1HC"
Count_DG$Status[11] <- "1HC"
Count_DG$Status[12] <- "1HC"
VentPal_HC <- summary(rfit(formula = as.numeric(VentPal) ~ Status + PMI + Age + Sex + Volume, data = Count_DG))
VentPal_HC <- data.frame(VentPal_HC[["coefficients"]])
Fibers_pvalues$`HC-TD`[14] <- VentPal_HC$p.value[3]

#Reassign
Count_DG$Status[9] <- "HC"
Count_DG$Status[10] <- "HC"
Count_DG$Status[11] <- "HC"
Count_DG$Status[12] <- "HC"

## Export to xlxs file
write.xlsx(x = FA_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "FA", append = TRUE)
write.xlsx(x = AD_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "AD", append = TRUE)
write.xlsx(x = ADC_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "ADC", append = TRUE)
write.xlsx(x = RD_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "RD", append = TRUE)
write.xlsx(x = CL_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "CL", append = TRUE)
write.xlsx(x = CP_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "CP", append = TRUE)
write.xlsx(x = CS_pvalues, file = "Pvalues_DTI.xlsx", sheetName = "CS", append = TRUE)

write.xlsx(x = Volume_pvalues, file = "Pvalues_Vol.xlsx", sheetName = "Vol")
write.xlsx(x = Fibers_pvalues, file = "Pvalues_Fibers.xlsx", sheetName = "Fibers")

levels(PD_demograph$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")

# Make table with median volume per group and write to xlsx
PD_volumes <- merge(PD_demograph,volumes_overview,by="SessionAx_V")
varlist <- c("Volume", "AntCom","Caudate","GPe","GPi","IntCap","IntThalAdh","LocCoer","Putamen","RedNucl","STN","SubNig","SubLentIntCap","Thalamus")
var_nonnormal <- c("Volume", "AntCom","Caudate","GPe","GPi","IntCap","IntThalAdh","LocCoer","Putamen","RedNucl","STN","SubNig","SubLentIntCap","Thalamus")
tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = PD_volumes)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "UTAP_Volumes.xlsx")

