#!/bin/bash


# Erode the brain masks
# mkdir ERODE
# 
fslmaths MASK/Mask_AntCom_mask_R_Painted.nii.gz -ero ERODE/Mask_AntCom_mask_R_Painted.nii.gz
fslmaths MASK/Mask_AntCom_mask_L_Painted.nii.gz -ero ERODE/Mask_AntCom_mask_L_Painted.nii.gz
fslmaths MASK/Mask_Caudate_mask_L_Painted.nii.gz -ero ERODE/Mask_Caudate_mask_L_Painted.nii.gz
fslmaths MASK/Mask_Caudate_mask_R_Painted.nii.gz -ero ERODE/Mask_Caudate_mask_R_Painted.nii.gz
fslmaths MASK/Mask_GPe_mask_L_Painted.nii.gz -ero ERODE/Mask_GPe_mask_L_Painted.nii.gz
fslmaths MASK/Mask_GPe_mask_R_Painted.nii.gz -ero ERODE/Mask_GPe_mask_R_Painted.nii.gz
fslmaths MASK/Mask_GPi_mask_L_Painted.nii.gz -ero ERODE/Mask_GPi_mask_L_Painted.nii.gz
fslmaths MASK/Mask_GPi_mask_R_Painted.nii.gz -ero ERODE/Mask_GPi_mask_R_Painted.nii.gz
fslmaths MASK/Mask_IntCap_mask_L_Painted.nii.gz -ero ERODE/Mask_IntCap_mask_L_Painted.nii.gz
fslmaths MASK/Mask_IntCap_mask_R_Painted.nii.gz -ero ERODE/Mask_IntCap_mask_R_Painted.nii.gz
fslmaths MASK/Mask_IntThalAdh_mask_L_Painted.nii.gz -ero ERODE/Mask_IntThalAdh_mask_L_Painted.nii.gz
fslmaths MASK/Mask_IntThalAdh_mask_R_Painted.nii.gz -ero ERODE/Mask_IntThalAdh_mask_R_Painted.nii.gz
fslmaths MASK/Mask_LocCoer_mask_L_Painted.nii.gz -ero ERODE/Mask_LocCoer_mask_L_Painted.nii.gz
fslmaths MASK/Mask_LocCoer_mask_R_Painted.nii.gz -ero ERODE/Mask_LocCoer_mask_R_Painted.nii.gz
fslmaths MASK/Mask_Putamen_mask_L_Painted.nii.gz -ero ERODE/Mask_Putamen_mask_L_Painted.nii.gz
fslmaths MASK/Mask_Putamen_mask_R_Painted.nii.gz -ero ERODE/Mask_Putamen_mask_R_Painted.nii.gz
fslmaths MASK/Mask_RedNucl_mask_L_Painted.nii.gz -ero ERODE/Mask_RedNucl_mask_L_Painted.nii.gz
fslmaths MASK/Mask_RedNucl_mask_R_Painted.nii.gz -ero ERODE/Mask_RedNucl_mask_R_Painted.nii.gz

fslmaths MASK/Mask_STN_mask_L_Painted.nii.gz -ero ERODE/Mask_STN_mask_L_Painted.nii.gz
fslmaths MASK/Mask_STN_mask_R_Painted.nii.gz -ero ERODE/Mask_STN_mask_R_Painted.nii.gz
fslmaths MASK/Mask_SubLentIntCap_mask_L_Painted.nii.gz -ero ERODE/Mask_SubLentIntCap_mask_L_Painted.nii.gz
fslmaths MASK/Mask_SubLentIntCap_mask_R_Painted.nii.gz -ero ERODE/Mask_SubLentIntCap_mask_R_Painted.nii.gz
fslmaths MASK/Mask_SubNig_mask_L_Painted.nii.gz -ero ERODE/Mask_SubNig_mask_L_Painted.nii.gz
fslmaths MASK/Mask_SubNig_mask_R_Painted.nii.gz -ero ERODE/Mask_SubNig_mask_R_Painted.nii.gz
fslmaths MASK/Mask_Thalamus_mask_L_Painted.nii.gz -ero ERODE/Mask_Thalamus_mask_L_Painted.nii.gz
fslmaths MASK/Mask_Thalamus_mask_R_Painted.nii.gz -ero ERODE/Mask_Thalamus_mask_R_Painted.nii.gz

mrconvert ERODE/Mask_AntCom_mask_R_Painted.nii.gz ERODE/Mask_AntCom_mask_R_Painted.mif
mrconvert ERODE/Mask_AntCom_mask_L_Painted.nii.gz ERODE/Mask_AntCom_mask_L_Painted.mif
mrconvert ERODE/Mask_Caudate_mask_L_Painted.nii.gz ERODE/Mask_Caudate_mask_L_Painted.mif
mrconvert ERODE/Mask_Caudate_mask_R_Painted.nii.gz ERODE/Mask_Caudate_mask_R_Painted.mif
mrconvert ERODE/Mask_GPe_mask_L_Painted.nii.gz ERODE/Mask_GPe_mask_L_Painted.mif
mrconvert ERODE/Mask_GPe_mask_R_Painted.nii.gz ERODE/Mask_GPe_mask_R_Painted.mif
mrconvert ERODE/Mask_GPi_mask_L_Painted.nii.gz ERODE/Mask_GPi_mask_L_Painted.mif
mrconvert ERODE/Mask_GPi_mask_R_Painted.nii.gz ERODE/Mask_GPi_mask_R_Painted.mif
mrconvert ERODE/Mask_IntCap_mask_L_Painted.nii.gz ERODE/Mask_IntCap_mask_L_Painted.mif
mrconvert ERODE/Mask_IntCap_mask_R_Painted.nii.gz ERODE/Mask_IntCap_mask_R_Painted.mif
mrconvert ERODE/Mask_IntThalAdh_mask_L_Painted.nii.gz ERODE/Mask_IntThalAdh_mask_L_Painted.mif
mrconvert ERODE/Mask_IntThalAdh_mask_R_Painted.nii.gz ERODE/Mask_IntThalAdh_mask_R_Painted.mif
mrconvert ERODE/Mask_LocCoer_mask_L_Painted.nii.gz ERODE/Mask_LocCoer_mask_L_Painted.mif
mrconvert ERODE/Mask_LocCoer_mask_R_Painted.nii.gz ERODE/Mask_LocCoer_mask_R_Painted.mif
mrconvert ERODE/Mask_Putamen_mask_L_Painted.nii.gz ERODE/Mask_Putamen_mask_L_Painted.mif
mrconvert ERODE/Mask_Putamen_mask_R_Painted.nii.gz ERODE/Mask_Putamen_mask_R_Painted.mif
mrconvert ERODE/Mask_RedNucl_mask_L_Painted.nii.gz ERODE/Mask_RedNucl_mask_L_Painted.mif
mrconvert ERODE/Mask_RedNucl_mask_R_Painted.nii.gz ERODE/Mask_RedNucl_mask_R_Painted.mif
mrconvert ERODE/Mask_STN_mask_L_Painted.nii.gz ERODE/Mask_STN_mask_L_Painted.mif
mrconvert ERODE/Mask_STN_mask_R_Painted.nii.gz ERODE/Mask_STN_mask_R_Painted.mif
mrconvert ERODE/Mask_SubLentIntCap_mask_L_Painted.nii.gz ERODE/Mask_SubLentIntCap_mask_L_Painted.mif
mrconvert ERODE/Mask_SubLentIntCap_mask_R_Painted.nii.gz ERODE/Mask_SubLentIntCap_mask_R_Painted.mif
mrconvert ERODE/Mask_SubNig_mask_L_Painted.nii.gz ERODE/Mask_SubNig_mask_L_Painted.mif
mrconvert ERODE/Mask_SubNig_mask_R_Painted.nii.gz ERODE/Mask_SubNig_mask_R_Painted.mif
mrconvert ERODE/Mask_Thalamus_mask_L_Painted.nii.gz ERODE/Mask_Thalamus_mask_L_Painted.mif
mrconvert ERODE/Mask_Thalamus_mask_R_Painted.nii.gz ERODE/Mask_Thalamus_mask_R_Painted.mif
