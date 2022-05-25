#!/bin/bash

# Convert nifti to mif
mrconvert DWI_upsampled.nii.gz DWI_upsampled.mif
mrconvert DWI_Mask_Painted.nii.gz DWI_Mask_Painted.mif

# Create response function
dwi2response tournier DWI_upsampled.mif DWI_response.txt -mask DWI_Mask_Painted.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval 

# Create FOD based on response function previously created
dwi2fod csd DWI_upsampled.mif DWI_response.txt DWI_FOD.mif -mask DWI_Mask_Painted.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval

# Next, generate a tensor image on the whole hemisphere, will be used as the input tensor image for each ROI; restricted using masks of each ROI
dwi2tensor DWI_upsampled.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -mask DWI_Mask_Painted.mif Tensor_Full.mif

# Create tensor images per metric per region of interest (180Gb storage needed)
mkdir TENSOR
cd TENSOR
#FA 
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -fa FA_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -fa FA_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -fa FA_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -fa FA_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -fa FA_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -fa FA_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -fa FA_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -fa FA_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -fa FA_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -fa FA_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -fa FA_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -fa FA_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -fa FA_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -fa FA_VentPal_L.mif
#ADC
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -adc ADC_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -adc ADC_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -adc ADC_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -adc ADC_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -adc ADC_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -adc ADC_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -adc ADC_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -adc ADC_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -adc ADC_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -adc ADC_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -adc ADC_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -adc ADC_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -adc ADC_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -adc ADC_VentPal_L.mif
#AD
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -ad AD_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -ad AD_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -ad AD_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -ad AD_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -ad AD_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -ad AD_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -ad AD_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -ad AD_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -ad AD_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -ad AD_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -ad AD_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -ad AD_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -ad AD_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -ad AD_VentPal_L.mif
#RD
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -rd RD_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -rd RD_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -rd RD_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -rd RD_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -rd RD_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -rd RD_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -rd RD_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -rd RD_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -rd RD_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -rd RD_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -rd RD_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -rd RD_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -rd RD_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -rd RD_VentPal_L.mif
#CL
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -cl CL_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -cl CL_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -cl CL_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -cl CL_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -cl CL_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -cl CL_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -cl CL_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -cl CL_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -cl CL_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -cl CL_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -cl CL_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -cl CL_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -cl CL_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -cl CL_VentPal_L.mif
#CP
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -cp CP_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -cp CP_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -cp CP_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -cp CP_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -cp CP_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -cp CP_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -cp CP_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -cp CP_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -cp CP_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -cp CP_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -cp CP_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -cp CP_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -cp CP_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -cp CP_VentPal_L.mif
#CS
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_L.mif -force -cs CS_AntCom_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_L.mif -force -cs CS_Caudate_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_L.mif -force -cs CS_GPe_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_L.mif -force -cs CS_GPi_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_L.mif -force -cs CS_IntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_L.mif -force -cs CS_IntThalAdh_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_L.mif -force -cs CS_LocCoer_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_L.mif -force -cs CS_Putamen_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_L.mif -force -cs CS_RedNucl_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_L.mif -force -cs CS_STN_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_L.mif -force -cs CS_SubLentIntCap_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_L.mif -force -cs CS_SubNig_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_L.mif -force -cs CS_Thalamus_L.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_L.mif -force -cs CS_VentPal_L.mif

#FA 
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -fa FA_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -fa FA_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -fa FA_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -fa FA_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -fa FA_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -fa FA_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -fa FA_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -fa FA_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -fa FA_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -fa FA_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -fa FA_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -fa FA_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -fa FA_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -fa FA_VentPal_R.mif
#ADC
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -adc ADC_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -adc ADC_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -adc ADC_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -adc ADC_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -adc ADC_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -adc ADC_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -adc ADC_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -adc ADC_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -adc ADC_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -adc ADC_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -adc ADC_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -adc ADC_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -adc ADC_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -adc ADC_VentPal_R.mif
#AD
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -ad AD_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -ad AD_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -ad AD_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -ad AD_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -ad AD_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -ad AD_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -ad AD_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -ad AD_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -ad AD_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -ad AD_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -ad AD_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -ad AD_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -ad AD_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -ad AD_VentPal_R.mif
#RD
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -rd RD_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -rd RD_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -rd RD_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -rd RD_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -rd RD_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -rd RD_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -rd RD_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -rd RD_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -rd RD_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -rd RD_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -rd RD_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -rd RD_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -rd RD_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -rd RD_VentPal_R.mif
#CL
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -cl CL_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -cl CL_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -cl CL_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -cl CL_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -cl CL_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -cl CL_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -cl CL_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -cl CL_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -cl CL_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -cl CL_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -cl CL_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -cl CL_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -cl CL_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -cl CL_VentPal_R.mif
#CP
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -cp CP_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -cp CP_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -cp CP_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -cp CP_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -cp CP_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -cp CP_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -cp CP_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -cp CP_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -cp CP_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -cp CP_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -cp CP_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -cp CP_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -cp CP_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -cp CP_VentPal_R.mif
#CS
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_AntCom_mask_R.mif -force -cs CS_AntCom_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Caudate_mask_R.mif -force -cs CS_Caudate_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPe_mask_R.mif -force -cs CS_GPe_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_GPi_mask_R.mif -force -cs CS_GPi_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntCap_mask_R.mif -force -cs CS_IntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_IntThalAdh_mask_R.mif -force -cs CS_IntThalAdh_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_LocCoer_mask_R.mif -force -cs CS_LocCoer_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Putamen_mask_R.mif -force -cs CS_Putamen_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_RedNucl_mask_R.mif -force -cs CS_RedNucl_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_STN_mask_R.mif -force -cs CS_STN_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubLentIntCap_mask_R.mif -force -cs CS_SubLentIntCap_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_SubNig_mask_R.mif -force -cs CS_SubNig_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_Thalamus_mask_R.mif -force -cs CS_Thalamus_R.mif
tensor2metric ../Tensor_Full.mif -mask ../MASK/Mask_VentPal_mask_R.mif -force -cs CS_VentPal_R.mif
cd ../