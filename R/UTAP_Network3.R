#
# Data processing and Statistics for UTAP WP1
#
# Create overview per DTI measure on how the regions are connected; 78 times and provide number of tracts
# If no connections are present the script will generate a zero on that line
#
# Department of Neurosurgery, Stijn Michielse, 2022
#
# Requirements

setwd("/Volumes/research/UTAP_WP1/MRI_DATA/VALUES/TRACTS_INTER/")
rm(list = ls())

# Load demographics
load("../PD_demograph.rda")

# Set volume measure correctly in mL
PD_demograph$Volume <- PD_demograph$Volume/1000000000
# Multiply AX, ADC and RD by 1000
PD_demograph$AD_Mean <- PD_demograph$AD_Mean*1000
PD_demograph$ADC_Mean <- PD_demograph$ADC_Mean*1000
PD_demograph$RD_Mean <- PD_demograph$RD_Mean*1000

# Change status as factor
PD_demograph$Status <- as.factor(PD_demograph$Status)
levels(PD_demograph$Status) <- c("Akinetic-Rigid", "Healthy Control", "Tremor-Dominant")


# Load dataframes with session data per line
list_sessions <- c("A1a","A2","A3a","A4a","A5","A6")
list_regions <-  c("AntCom", "Caudate", "GPe", "GPi", "IntCap", "IntThalAdh", "LocCoer", "Putamen", "RedNucl", "STN", "SubLentIntCap", "SubNig", "Thalamus", "VentPal")

for (target in list_sessions) {
  print(paste0("Session",target))
  load(file=paste0(paste0("Session",target),"_Right.rda"))
  load(file=paste0(paste0("Session",target),"_Left.rda"))
}

# Get overview of existing connections
list_connections <- data.frame(row.names(SessionA1a_Left))
overview_connected <- data.frame()
overview_fa <- data.frame()
overview_ad <- data.frame()
overview_adc <- data.frame()
overview_rd <- data.frame()
overview_cl <- data.frame()
overview_cp <- data.frame()
overview_cs <- data.frame()

for (i in 1:78) {
  #target <- print(list_connections[i,])
  if ((SessionA1a_Left$fibers[i] > 0) & (SessionA1a_Right$fibers[i] > 0) & (SessionA2_Left$fibers[i] > 0) & (SessionA2_Right$fibers[i] > 0) & (SessionA3a_Left$fibers[i] > 0) & (SessionA3a_Right$fibers[i] > 0) & (SessionA4a_Left$fibers[i] > 0) & (SessionA4a_Right$fibers[i] > 0) & (SessionA5_Left$fibers[i] > 0) & (SessionA5_Right$fibers[i] > 0) & (SessionA6_Left$fibers[i] > 0) & (SessionA6_Right$fibers[i] > 0)) {
    # condition is met
    print(paste0("Found connected regions in all samples for; ",list_connections[i,]))
    
    # Fibers
    overview_connected[nrow(overview_connected) + 1,1]  <- list_connections[i,] 
    overview_connected[nrow(overview_connected),2:13] <- c(SessionA1a_Left$fibers[i], SessionA1a_Right$fibers[i], SessionA2_Left$fibers[i], + 
                                                             SessionA2_Right$fibers[i], SessionA3a_Left$fibers[i], SessionA3a_Right$fibers[i], +
                                                             SessionA4a_Left$fibers[i], SessionA4a_Right$fibers[i], SessionA5_Left$fibers[i], + 
                                                             SessionA5_Right$fibers[i], SessionA6_Left$fibers[i], SessionA6_Right$fibers[i])
    # FA
    overview_fa[nrow(overview_fa) + 1,1]  <- list_connections[i,] 
    overview_fa[nrow(overview_fa),2:13] <- c(SessionA1a_Left$FA_mean[i], SessionA1a_Right$FA_mean[i], SessionA2_Left$FA_mean[i], + 
                                                             SessionA2_Right$FA_mean[i], SessionA3a_Left$FA_mean[i], SessionA3a_Right$FA_mean[i], +
                                                             SessionA4a_Left$FA_mean[i], SessionA4a_Right$FA_mean[i], SessionA5_Left$FA_mean[i], + 
                                                             SessionA5_Right$FA_mean[i], SessionA6_Left$FA_mean[i], SessionA6_Right$FA_mean[i])
    
    # AD
    overview_ad[nrow(overview_ad) + 1,1]  <- list_connections[i,] 
    overview_ad[nrow(overview_ad),2:13] <- c(SessionA1a_Left$AD_mean[i], SessionA1a_Right$AD_mean[i], SessionA2_Left$AD_mean[i], + 
                                               SessionA2_Right$AD_mean[i], SessionA3a_Left$AD_mean[i], SessionA3a_Right$AD_mean[i], +
                                               SessionA4a_Left$AD_mean[i], SessionA4a_Right$AD_mean[i], SessionA5_Left$AD_mean[i], + 
                                               SessionA5_Right$AD_mean[i], SessionA6_Left$AD_mean[i], SessionA6_Right$AD_mean[i])
    
    # ADC
    overview_adc[nrow(overview_adc) + 1,1]  <- list_connections[i,] 
    overview_adc[nrow(overview_adc),2:13] <- c(SessionA1a_Left$ADC_mean[i], SessionA1a_Right$ADC_mean[i], SessionA2_Left$ADC_mean[i], + 
                                                 SessionA2_Right$ADC_mean[i], SessionA3a_Left$ADC_mean[i], SessionA3a_Right$ADC_mean[i], +
                                                 SessionA4a_Left$ADC_mean[i], SessionA4a_Right$ADC_mean[i], SessionA5_Left$ADC_mean[i], + 
                                                 SessionA5_Right$ADC_mean[i], SessionA6_Left$ADC_mean[i], SessionA6_Right$ADC_mean[i])
    
    # RD
    overview_rd[nrow(overview_rd) + 1,1]  <- list_connections[i,] 
    overview_rd[nrow(overview_rd),2:13] <- c(SessionA1a_Left$RD_mean[i], SessionA1a_Right$RD_mean[i], SessionA2_Left$RD_mean[i], + 
                                               SessionA2_Right$RD_mean[i], SessionA3a_Left$RD_mean[i], SessionA3a_Right$RD_mean[i], +
                                               SessionA4a_Left$RD_mean[i], SessionA4a_Right$RD_mean[i], SessionA5_Left$RD_mean[i], + 
                                               SessionA5_Right$RD_mean[i], SessionA6_Left$RD_mean[i], SessionA6_Right$RD_mean[i])
    
    # CL
    overview_cl[nrow(overview_cl) + 1,1]  <- list_connections[i,] 
    overview_cl[nrow(overview_cl),2:13] <- c(SessionA1a_Left$CL_mean[i], SessionA1a_Right$CL_mean[i], SessionA2_Left$CL_mean[i], + 
                                               SessionA2_Right$CL_mean[i], SessionA3a_Left$CL_mean[i], SessionA3a_Right$CL_mean[i], +
                                               SessionA4a_Left$CL_mean[i], SessionA4a_Right$CL_mean[i], SessionA5_Left$CL_mean[i], + 
                                               SessionA5_Right$CL_mean[i], SessionA6_Left$CL_mean[i], SessionA6_Right$CL_mean[i])
    
    # CP
    overview_cp[nrow(overview_cp) + 1,1]  <- list_connections[i,] 
    overview_cp[nrow(overview_cp),2:13] <- c(SessionA1a_Left$CP_mean[i], SessionA1a_Right$CP_mean[i], SessionA2_Left$CP_mean[i], + 
                                               SessionA2_Right$CP_mean[i], SessionA3a_Left$CP_mean[i], SessionA3a_Right$CP_mean[i], +
                                               SessionA4a_Left$CP_mean[i], SessionA4a_Right$CP_mean[i], SessionA5_Left$CP_mean[i], + 
                                               SessionA5_Right$CP_mean[i], SessionA6_Left$CP_mean[i], SessionA6_Right$CP_mean[i])
    
    # CS
    overview_cs[nrow(overview_cs) + 1,1]  <- list_connections[i,] 
    overview_cs[nrow(overview_cs),2:13] <- c(SessionA1a_Left$CS_mean[i], SessionA1a_Right$CS_mean[i], SessionA2_Left$CS_mean[i], + 
                                               SessionA2_Right$CS_mean[i], SessionA3a_Left$CS_mean[i], SessionA3a_Right$CS_mean[i], +
                                               SessionA4a_Left$CS_mean[i], SessionA4a_Right$CS_mean[i], SessionA5_Left$CS_mean[i], + 
                                               SessionA5_Right$CS_mean[i], SessionA6_Left$CS_mean[i], SessionA6_Right$CS_mean[i])
  }
}

list_connected <- data.frame(overview_connected$V1)

# Transpose dataframe and add names to the variables 
overview_connected = setNames(data.frame(t(overview_connected[,-1])), overview_connected[,1])
overview_connected$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_fa = setNames(data.frame(t(overview_fa[,-1])), overview_fa[,1])
overview_fa$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_ad = setNames(data.frame(t(overview_ad[,-1])), overview_ad[,1])
overview_ad$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_adc = setNames(data.frame(t(overview_adc[,-1])), overview_adc[,1])
overview_adc$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_rd = setNames(data.frame(t(overview_rd[,-1])), overview_rd[,1])
overview_rd$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_cl = setNames(data.frame(t(overview_cl[,-1])), overview_cl[,1])
overview_cl$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_cp = setNames(data.frame(t(overview_cp[,-1])), overview_cp[,1])
overview_cp$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")

overview_cs = setNames(data.frame(t(overview_cs[,-1])), overview_cs[,1])
overview_cs$SessionAx_V <- c("SessionA2_Left","SessionA4a_Left","SessionA1a_Right","SessionA6_Left","SessionA1a_Left","SessionA3a_Left","SessionA4a_Right","SessionA5_Right","SessionA2_Right","SessionA5_Left","SessionA3a_Right","SessionA6_Right")



#
##
###
#### Test to see if number of fibers differ between groups
###
##
#
Fibers_DG <- merge(PD_demograph,overview_connected,by="SessionAx_V")
Fibers_DG <- Fibers_DG[order(Fibers_DG$Status),]
Fibers_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(Fibers_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
Fibers_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
Fibers_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
Fibers_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
Fibers_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
Fibers_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
Fibers_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
Fibers_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
Fibers_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
Fibers_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
Fibers_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
Fibers_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
Fibers_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
Fibers_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
Fibers_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
Fibers_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
Fibers_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
Fibers_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
Fibers_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
Fibers_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
Fibers_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
Fibers_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
Fibers_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
Fibers_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
Fibers_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
Fibers_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
Fibers_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
Fibers_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
Fibers_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
Fibers_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
Fibers_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
Fibers_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
Fibers_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + Volume, data = Fibers_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
Fibers_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
Fibers_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
Fibers_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
Fibers_DG$Status <- as.character(Fibers_DG$Status)
Fibers_DG$Status[5] <- "1HC"
Fibers_DG$Status[6] <- "1HC"
Fibers_DG$Status[7] <- "1HC"
Fibers_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = Fibers_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
Fibers_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
Fibers_DG$Status[5] <- "HC"
Fibers_DG$Status[6] <- "HC"
Fibers_DG$Status[7] <- "HC"
Fibers_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = Fibers_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "Fibers_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = Fibers_sig, file = "Fibers_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if FA values differ between groups
###
##
#
FA_DG <- merge(PD_demograph,overview_fa,by="SessionAx_V")
FA_DG <- FA_DG[order(FA_DG$Status),]
FA_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(FA_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
FA_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
FA_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
FA_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
FA_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
FA_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
FA_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
FA_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
FA_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
FA_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
FA_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
FA_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
FA_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
FA_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
FA_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
FA_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
FA_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
FA_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
FA_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
FA_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
FA_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
FA_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
FA_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
FA_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
FA_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
FA_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
FA_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
FA_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
FA_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
FA_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
FA_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
FA_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
FA_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
FA_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
FA_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
FA_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
FA_DG$Status <- as.character(FA_DG$Status)
FA_DG$Status[5] <- "1HC"
FA_DG$Status[6] <- "1HC"
FA_DG$Status[7] <- "1HC"
FA_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + FA_Mean, data = FA_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
FA_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
FA_DG$Status[5] <- "HC"
FA_DG$Status[6] <- "HC"
FA_DG$Status[7] <- "HC"
FA_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = FA_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "FA_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = FA_sig, file = "FA_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if AD values differ between groups
###
##
#
AD_DG <- merge(PD_demograph,overview_ad,by="SessionAx_V")
AD_DG <- AD_DG[order(AD_DG$Status),]
AD_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(AD_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
AD_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
AD_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
AD_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
AD_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
AD_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
AD_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
AD_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
AD_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
AD_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
AD_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
AD_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
AD_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
AD_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
AD_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
AD_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
AD_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
AD_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
AD_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
AD_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
AD_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
AD_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
AD_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
AD_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
AD_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
AD_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
AD_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
AD_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
AD_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
AD_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
AD_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
AD_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
AD_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
AD_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
AD_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
AD_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
AD_DG$Status <- as.character(AD_DG$Status)
AD_DG$Status[5] <- "1HC"
AD_DG$Status[6] <- "1HC"
AD_DG$Status[7] <- "1HC"
AD_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + AD_Mean, data = AD_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
AD_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
AD_DG$Status[5] <- "HC"
AD_DG$Status[6] <- "HC"
AD_DG$Status[7] <- "HC"
AD_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
# Multiply by factor 1000 
AD_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L <- AD_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L*1000
AD_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L <- AD_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L*1000
AD_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L <- AD_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L*1000
AD_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L <- AD_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L*1000
AD_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L <- AD_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L*1000
AD_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L <- AD_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L*1000
AD_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L <- AD_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L*1000
AD_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L <- AD_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L*1000
AD_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L <- AD_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L*1000

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = AD_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "AD_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = AD_sig, file = "AD_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if ADC values differ between groups
###
##
#
ADC_DG <- merge(PD_demograph,overview_adc,by="SessionAx_V")
ADC_DG <- ADC_DG[order(ADC_DG$Status),]
ADC_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(ADC_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
ADC_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
ADC_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
ADC_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
ADC_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
ADC_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
ADC_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
ADC_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
ADC_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
ADC_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
ADC_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
ADC_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
ADC_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
ADC_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
ADC_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
ADC_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
ADC_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
ADC_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
ADC_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
ADC_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
ADC_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
ADC_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
ADC_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
ADC_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
ADC_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
ADC_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
ADC_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
ADC_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
ADC_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
ADC_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
ADC_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
ADC_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
ADC_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
ADC_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
ADC_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
ADC_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
ADC_DG$Status <- as.character(ADC_DG$Status)
ADC_DG$Status[5] <- "1HC"
ADC_DG$Status[6] <- "1HC"
ADC_DG$Status[7] <- "1HC"
ADC_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + ADC_Mean, data = ADC_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
ADC_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
ADC_DG$Status[5] <- "HC"
ADC_DG$Status[6] <- "HC"
ADC_DG$Status[7] <- "HC"
ADC_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
# Multiply by factor 1000 
ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L <- ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L*1000
ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L <- ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L*1000
ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L <- ADC_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L*1000
ADC_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L <- ADC_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L*1000
ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L <- ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L*1000
ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L <- ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L*1000
ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L <- ADC_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L*1000
ADC_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L <- ADC_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L*1000
ADC_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L <- ADC_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L*1000

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = ADC_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "ADC_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = ADC_sig, file = "ADC_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if RD values differ between groups
###
##
#
RD_DG <- merge(PD_demograph,overview_rd,by="SessionAx_V")
RD_DG <- RD_DG[order(RD_DG$Status),]
RD_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(RD_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
RD_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
RD_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
RD_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
RD_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
RD_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
RD_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
RD_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
RD_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
RD_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
RD_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
RD_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
RD_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
RD_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
RD_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
RD_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
RD_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
RD_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
RD_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
RD_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
RD_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
RD_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
RD_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
RD_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
RD_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
RD_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
RD_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
RD_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
RD_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
RD_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
RD_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
RD_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
RD_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
RD_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
RD_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
RD_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
RD_DG$Status <- as.character(RD_DG$Status)
RD_DG$Status[5] <- "1HC"
RD_DG$Status[6] <- "1HC"
RD_DG$Status[7] <- "1HC"
RD_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + RD_Mean, data = RD_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
RD_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
RD_DG$Status[5] <- "HC"
RD_DG$Status[6] <- "HC"
RD_DG$Status[7] <- "HC"
RD_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
# Multiply by factor 1000 
RD_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L <- RD_DG$FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L*1000
RD_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L <- RD_DG$FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L*1000
RD_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L <- RD_DG$FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L*1000
RD_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L <- RD_DG$FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L*1000
RD_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L <- RD_DG$FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L*1000
RD_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L <- RD_DG$FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L*1000
RD_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L <- RD_DG$FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L*1000
RD_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L <- RD_DG$FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L*1000
RD_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L <- RD_DG$FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L*1000

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = RD_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "RD_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = RD_sig, file = "RD_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if CL values differ between groups
###
##
#
CL_DG <- merge(PD_demograph,overview_cl,by="SessionAx_V")
CL_DG <- CL_DG[order(CL_DG$Status),]
CL_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(CL_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
CL_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
CL_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
CL_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
CL_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
CL_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
CL_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
CL_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
CL_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
CL_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
CL_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
CL_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
CL_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
CL_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
CL_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
CL_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
CL_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
CL_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
CL_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
CL_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
CL_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
CL_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
CL_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
CL_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
CL_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
CL_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
CL_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
CL_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
CL_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
CL_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
CL_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
CL_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
CL_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
CL_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
CL_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
CL_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
CL_DG$Status <- as.character(CL_DG$Status)
CL_DG$Status[5] <- "1HC"
CL_DG$Status[6] <- "1HC"
CL_DG$Status[7] <- "1HC"
CL_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CL_Mean, data = CL_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
CL_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
CL_DG$Status[5] <- "HC"
CL_DG$Status[6] <- "HC"
CL_DG$Status[7] <- "HC"
CL_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = CL_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "CL_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = CL_sig, file = "CL_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if CP values differ between groups
###
##
#
CP_DG <- merge(PD_demograph,overview_cp,by="SessionAx_V")
CP_DG <- CP_DG[order(CP_DG$Status),]
CP_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(CP_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
CP_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
CP_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
CP_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
CP_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
CP_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
CP_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
CP_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
CP_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
CP_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
CP_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
CP_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
CP_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
CP_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
CP_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
CP_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
CP_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
CP_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
CP_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
CP_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
CP_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
CP_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
CP_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
CP_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
CP_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
CP_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
CP_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
CP_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
CP_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
CP_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
CP_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
CP_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
CP_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
CP_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
CP_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
CP_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
CP_DG$Status <- as.character(CP_DG$Status)
CP_DG$Status[5] <- "1HC"
CP_DG$Status[6] <- "1HC"
CP_DG$Status[7] <- "1HC"
CP_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CP_Mean, data = CP_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
CP_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
CP_DG$Status[5] <- "HC"
CP_DG$Status[6] <- "HC"
CP_DG$Status[7] <- "HC"
CP_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = CP_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "CP_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = CP_sig, file = "CP_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

#
##
###
#### Test to see if CS values differ between groups
###
##
#
CS_DG <- merge(PD_demograph,overview_cs,by="SessionAx_V")
CS_DG <- CS_DG[order(CS_DG$Status),]
CS_sig <- data.frame(matrix(ncol = 4, nrow = 9))
colnames(CS_sig) <- c('Connection','AR-HC', 'AR-TD', 'HC-TD')


# 1. FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L
Cau_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_IntCap_AR <- data.frame(Cau_IntCap_AR[["coefficients"]])
CS_sig$`AR-HC`[1] <- Cau_IntCap_AR$p.value[2]
CS_sig$`AR-TD`[1] <- Cau_IntCap_AR$p.value[3]
CS_sig$`Connection`[1] <- "FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
Cau_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_IntCap_HC <- data.frame(Cau_IntCap_HC[["coefficients"]])
CS_sig$`HC-TD`[1] <- Cau_IntCap_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 2. FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L
Cau_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_SubLent_AR <- data.frame(Cau_SubLent_AR[["coefficients"]])
CS_sig$`AR-HC`[2] <- Cau_SubLent_AR$p.value[2]
CS_sig$`AR-TD`[2] <- Cau_SubLent_AR$p.value[3]
CS_sig$`Connection`[2] <- "FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
Cau_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_SubLent_HC <- data.frame(Cau_SubLent_HC[["coefficients"]])
CS_sig$`HC-TD`[2] <- Cau_SubLent_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 3. FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L
Cau_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_Thal_AR <- data.frame(Cau_Thal_AR[["coefficients"]])
CS_sig$`AR-HC`[3] <- Cau_Thal_AR$p.value[2]
CS_sig$`AR-TD`[3] <- Cau_Thal_AR$p.value[3]
CS_sig$`Connection`[3] <- "FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
Cau_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Cau_Thal_HC <- data.frame(Cau_Thal_HC[["coefficients"]])
CS_sig$`HC-TD`[3] <- Cau_Thal_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 4. FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L
GPe_IntCap_AR <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPe_IntCap_AR <- data.frame(GPe_IntCap_AR[["coefficients"]])
CS_sig$`AR-HC`[4] <- GPe_IntCap_AR$p.value[2]
CS_sig$`AR-TD`[4] <- GPe_IntCap_AR$p.value[3]
CS_sig$`Connection`[4] <- "FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
GPe_IntCap_HC <- summary(rfit(formula = as.numeric(FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
GPe_IntCap_HC <- data.frame(GPe_IntCap_HC[["coefficients"]])
CS_sig$`HC-TD`[4] <- GPe_IntCap_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 5. FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L
IntCap_Put_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_Put_AR <- data.frame(IntCap_Put_AR[["coefficients"]])
CS_sig$`AR-HC`[5] <- IntCap_Put_AR$p.value[2]
CS_sig$`AR-TD`[5] <- IntCap_Put_AR$p.value[3]
CS_sig$`Connection`[5] <- "FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
IntCap_Put_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_Put_HC <- data.frame(IntCap_Put_HC[["coefficients"]])
CS_sig$`HC-TD`[5] <- IntCap_Put_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 6. FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L
IntCap_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_SubLent_AR <- data.frame(IntCap_SubLent_AR[["coefficients"]])
CS_sig$`AR-HC`[6] <- IntCap_SubLent_AR$p.value[2]
CS_sig$`AR-TD`[6] <- IntCap_SubLent_AR$p.value[3]
CS_sig$`Connection`[6] <- "FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
IntCap_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_SubLent_HC <- data.frame(IntCap_SubLent_HC[["coefficients"]])
CS_sig$`HC-TD`[6] <- IntCap_SubLent_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 7. FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L
IntCap_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_Thal_AR <- data.frame(IntCap_Thal_AR[["coefficients"]])
CS_sig$`AR-HC`[7] <- IntCap_Thal_AR$p.value[2]
CS_sig$`AR-TD`[7] <- IntCap_Thal_AR$p.value[3]
CS_sig$`Connection`[7] <- "FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
IntCap_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
IntCap_Thal_HC <- data.frame(IntCap_Thal_HC[["coefficients"]])
CS_sig$`HC-TD`[7] <- IntCap_Thal_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 8. FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L
Putamen_SubLent_AR <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Putamen_SubLent_AR <- data.frame(Putamen_SubLent_AR[["coefficients"]])
CS_sig$`AR-HC`[8] <- Putamen_SubLent_AR$p.value[2]
CS_sig$`AR-TD`[8] <- Putamen_SubLent_AR$p.value[3]
CS_sig$`Connection`[8] <- "FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
Putamen_SubLent_HC <- summary(rfit(formula = as.numeric(FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
Putamen_SubLent_HC <- data.frame(Putamen_SubLent_HC[["coefficients"]])
CS_sig$`HC-TD`[8] <- Putamen_SubLent_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# 9. FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L
SubLent_Thal_AR <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubLent_Thal_AR <- data.frame(SubLent_Thal_AR[["coefficients"]])
CS_sig$`AR-HC`[9] <- SubLent_Thal_AR$p.value[2]
CS_sig$`AR-TD`[9] <- SubLent_Thal_AR$p.value[3]
CS_sig$`Connection`[9] <- "FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L"
CS_DG$Status <- as.character(CS_DG$Status)
CS_DG$Status[5] <- "1HC"
CS_DG$Status[6] <- "1HC"
CS_DG$Status[7] <- "1HC"
CS_DG$Status[8] <- "1HC"
SubLent_Thal_HC <- summary(rfit(formula = as.numeric(FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L) ~ Status + PMI + Age + Sex + CS_Mean, data = CS_DG))
SubLent_Thal_HC <- data.frame(SubLent_Thal_HC[["coefficients"]])
CS_sig$`HC-TD`[9] <- SubLent_Thal_HC$p.value[3]

#Reassign
CS_DG$Status[5] <- "HC"
CS_DG$Status[6] <- "HC"
CS_DG$Status[7] <- "HC"
CS_DG$Status[8] <- "HC"

# Get median values per group
# Make up table and write to xlsx
varlist <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")
var_nonnormal <- c("FA_Mask_Caudate_mask_L_2_Mask_IntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_Caudate_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_GPe_mask_L_2_Mask_IntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Putamen_mask_L","FA_Mask_IntCap_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_IntCap_mask_L_2_Mask_Thalamus_mask_L","FA_Mask_Putamen_mask_L_2_Mask_SubLentIntCap_mask_L","FA_Mask_SubLentIntCap_mask_L_2_Mask_Thalamus_mask_L")

tab1 <- CreateTableOne(vars = varlist, strata = "Status", data = CS_DG)
table_one <- print(tab1, nonnormal=var_nonnormal)
write.xlsx(x = table_one, file = "CS_DG_network.xlsx", sheetName = "Medians")
write.xlsx(x = CS_sig, file = "CS_DG_network.xlsx", sheetName = "Pvalues", append = TRUE)

