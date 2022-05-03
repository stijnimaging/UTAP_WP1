#!/bin/bash

# Get volume measures per mask, per hemisphere

# Calculate volume per Mask
echo "Stats created at $(date) in $(pwd) Values in order; voxels and volume " > Overview_volumes_All.txt
echo "AntCom_mask_L" `fslstats MASK/Mask_AntCom_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "AntCom_mask_R " `fslstats MASK/Mask_AntCom_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "Caudate_mask_L" `fslstats MASK/Mask_Caudate_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "Caudate_mask_R " `fslstats MASK/Mask_Caudate_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "GPe_mask_L" `fslstats MASK/Mask_GPe_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "GPe_mask_R " `fslstats MASK/Mask_GPe_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "GPi_mask_L" `fslstats MASK/Mask_GPi_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "GPi_mask_R " `fslstats MASK/Mask_GPi_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "IntCap_mask_L" `fslstats MASK/Mask_IntCap_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "IntCap_mask_R " `fslstats MASK/Mask_IntCap_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "IntThalAdh_mask_L" `fslstats MASK/Mask_IntThalAdh_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "IntThalAdh_mask_R " `fslstats MASK/Mask_IntThalAdh_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "LocCoer_mask_R " `fslstats MASK/Mask_LocCoer_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "LocCoer_mask_L" `fslstats MASK/Mask_LocCoer_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "Putamen_mask_L" `fslstats MASK/Mask_Putamen_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "Putamen_mask_R " `fslstats MASK/Mask_Putamen_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "RedNucl_mask_L" `fslstats MASK/Mask_RedNucl_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "RedNucl_mask_R " `fslstats MASK/Mask_RedNucl_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "STN_mask_L" `fslstats MASK/Mask_STN_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "STN_mask_R " `fslstats MASK/Mask_STN_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "SubNig_mask_L" `fslstats MASK/Mask_SubNig_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "SubNig_mask_R " `fslstats MASK/Mask_SubNig_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "SubLentIntCap_mask_L" `fslstats MASK/Mask_SubLentIntCap_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "SubLentIntCap_mask_R " `fslstats MASK/Mask_SubLentIntCap_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "Thalamus_mask_L" `fslstats MASK/Mask_Thalamus_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "Thalamus_mask_R " `fslstats MASK/Mask_Thalamus_mask_R.nii.gz -V` >> Overview_volumes_All.txt
echo "VentPal_mask_L " `fslstats MASK/Mask_VentPal_mask_L.nii.gz -V` >> Overview_volumes_All.txt
echo "VentPal_mask_R " `fslstats MASK/Mask_VentPal_mask_R.nii.gz -V` >> Overview_volumes_All.txt

# Calculate volume per Mask in het LEFT hemisphere
echo "Left hemisphere stats created at $(date) in $(pwd) Values in order; voxels and volume " > Overview_volumes_L.txt
echo "AntCom_mask_L" `fslstats MASK/Mask_AntCom_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "Caudate_mask_L" `fslstats MASK/Mask_Caudate_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "GPe_mask_L" `fslstats MASK/Mask_GPe_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "GPi_mask_L" `fslstats MASK/Mask_GPi_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "IntCap_mask_L" `fslstats MASK/Mask_IntCap_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "IntThalAdh_mask_L" `fslstats MASK/Mask_IntThalAdh_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "LocCoer_mask_L" `fslstats MASK/Mask_LocCoer_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "Putamen_mask_L" `fslstats MASK/Mask_Putamen_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "RedNucl_mask_L" `fslstats MASK/Mask_RedNucl_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "STN_mask_L" `fslstats MASK/Mask_STN_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "SubNig_mask_L" `fslstats MASK/Mask_SubNig_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "SubLentIntCap_mask_L" `fslstats MASK/Mask_SubLentIntCap_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "Thalamus_mask_L" `fslstats MASK/Mask_Thalamus_mask_L.nii.gz -V` >> Overview_volumes_L.txt
echo "VentPal_mask_L " `fslstats MASK/Mask_VentPal_mask_L.nii.gz -V` >> Overview_volumes_L.txt

# Calculate volume per Mask in het RIGHT hemisphere
echo "Right hemisphere stats created at $(date) in $(pwd) Values in order; voxels and volume" > Overview_volumes_R.txt
echo "AntCom_mask_R " `fslstats MASK/Mask_AntCom_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "Caudate_mask_R " `fslstats MASK/Mask_Caudate_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "GPe_mask_R " `fslstats MASK/Mask_GPe_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "GPi_mask_R " `fslstats MASK/Mask_GPi_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "IntCap_mask_R " `fslstats MASK/Mask_IntCap_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "IntThalAdh_mask_R " `fslstats MASK/Mask_IntThalAdh_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "LocCoer_mask_R " `fslstats MASK/Mask_LocCoer_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "Putamen_mask_R " `fslstats MASK/Mask_Putamen_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "RedNucl_mask_R " `fslstats MASK/Mask_RedNucl_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "STN_mask_R " `fslstats MASK/Mask_STN_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "SubNig_mask_R " `fslstats MASK/Mask_SubNig_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "SubLentIntCap_mask_R " `fslstats MASK/Mask_SubLentIntCap_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "Thalamus_mask_R " `fslstats MASK/Mask_Thalamus_mask_R.nii.gz -V` >> Overview_volumes_R.txt
echo "VentPal_mask_R " `fslstats MASK/Mask_VentPal_mask_R.nii.gz -V` >> Overview_volumes_R.txt

## T2* weighted values
# Calculate T2* weighted values per Mask both hemispheres
# echo "Stats created at $(date) in $(pwd) values in order; voxels, volume, mean and standard deviation" > Overview_T2_values_All.txt
# echo "AntCom_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_AntCom_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "AntCom_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_AntCom_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Caudate_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Caudate_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Caudate_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Caudate_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "GPe_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPe_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "GPe_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPe_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "GPi_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPi_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "GPi_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPi_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "IntCap_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntCap_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "IntCap_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntCap_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "IntThalAdh_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntThalAdh_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "IntThalAdh_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntThalAdh_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "LocCoer_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_LocCoer_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "LocCoer_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_LocCoer_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Putamen_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Putamen_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Putamen_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Putamen_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "RedNucl_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_RedNucl_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "RedNucl_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_RedNucl_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "STN_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_STN_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "STN_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_STN_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "SubNig_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubNig_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "SubNig_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubNig_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "SubLentIntCap_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubLentIntCap_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "SubLentIntCap_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubLentIntCap_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Thalamus_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Thalamus_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "Thalamus_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Thalamus_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "VentPal_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_VentPal_mask_L.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# echo "VentPal_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_VentPal_mask_R.nii.gz -V -M -S` >> Overview_T2_values_All.txt
# 
# Calculate T2* weighted values per Mask for the LEFT hemisphere
# echo "Left hemisphere stats created at $(date) in $(pwd) values in order; voxels, volume, mean and standard deviation" > Overview_T2_values_L.txt
# echo "AntCom_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_AntCom_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "Caudate_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Caudate_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "GPe_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPe_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "GPi_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPi_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "IntCap_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntCap_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "IntThalAdh_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntThalAdh_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "LocCoer_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_LocCoer_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "Putamen_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Putamen_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "RedNucl_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_RedNucl_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "STN_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_STN_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "SubNig_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubNig_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "SubLentIntCap_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubLentIntCap_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "Thalamus_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Thalamus_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# echo "VentPal_mask_L" `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_VentPal_mask_L.nii.gz -V -M -S` >> Overview_T2_values_L.txt
# 
# Calculate T2* weighted values per Mask for the RIGHT hemisphere
# echo "Right hemisphere stats created at $(date) in $(pwd) values in order; voxels, volume, mean and standard deviation" > Overview_T2_values_R.txt
# echo "AntCom_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_AntCom_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "Caudate_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Caudate_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "GPe_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPe_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "GPi_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_GPi_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "IntCap_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntCap_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "IntThalAdh_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_IntThalAdh_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "LocCoer_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_LocCoer_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "Putamen_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Putamen_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "RedNucl_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_RedNucl_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "STN_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_STN_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "SubNig_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubNig_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "SubLentIntCap_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_SubLentIntCap_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "Thalamus_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_Thalamus_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt
# echo "VentPal_mask_R " `fslstats ../../GRE/S0T2_output/S0T2_exvivo/ExpT2Dec.T2.nii.gz -k MASK/Mask_VentPal_mask_R.nii.gz -V -M -S` >> Overview_T2_values_R.txt

# Create tracts based on masks with SD STREAM algorithm - will be done with the script DSRI_tckgen.sh
# tckgen DWI_FOD.mif TRACTS/Tracts_AntCom_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_AntCom_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_AntCom_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_AntCom_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Caudate_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Caudate_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Caudate_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Caudate_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_GPe_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPe_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_GPe_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPe_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_GPi_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPi_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_GPi_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPi_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_IntCap_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntCap_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_IntCap_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntCap_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_IntThalAdh_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntThalAdh_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_IntThalAdh_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntThalAdh_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_LocCoer_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_LocCoer_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_LocCoer_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_LocCoer_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Putamen_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Putamen_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Putamen_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Putamen_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_RedNucl_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_RedNucl_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_RedNucl_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_RedNucl_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_STN_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_STN_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_STN_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_STN_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_SubNig_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubNig_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_SubNig_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubNig_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_SubLentIntCap_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubLentIntCap_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_SubLentIntCap_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubLentIntCap_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Thalamus_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Thalamus_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_Thalamus_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Thalamus_mask_R.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_VentPal_mask_L.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_VentPal_mask_L.nii.gz -select 100000
# tckgen DWI_FOD.mif TRACTS/Tracts_VentPal_mask_R.tck -algorithm SD_STREAM -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_VentPal_mask_R.nii.gz -select 100000


# Get metrics FA, ADC, Axial/Radial diffusivity, case linear/planar/spherical
tensor2metric DWI_FOD.mif -fa DWI_FA.mif
tensor2metric DWI_FOD.mif -adc DWI_adc.mif
tensor2metric DWI_FOD.mif -ad DWI_ad.mif
tensor2metric DWI_FOD.mif -rd DWI_rd.mif
tensor2metric DWI_FOD.mif -cl DWI_cl.mif
tensor2metric DWI_FOD.mif -cp DWI_cp.mif
tensor2metric DWI_FOD.mif -cs DWI_cs.mif

# Calculate DTI metrics based on the generated tracts
# Compute the fractional anisotropy (FA) of the diffusion tensor. 
mkdir VALUES
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_FA.mif VALUES/FA_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_FA.mif VALUES/FA_Tracts_VentPal_mask_R.txt

# Compute the mean apparent diffusion coefficient (ADC) of the diffusion tensor. (sometimes also referred to as the mean diffusivity (MD))
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_adc.mif TRACTS/adc_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_adc.mif TRACTS/adc_Tracts_VentPal_mask_R.txt

# Compute the axial diffusivity (AD) of the diffusion tensor. (equivalent to the principal eigenvalue)
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_ad.mif TRACTS/ad_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_ad.mif TRACTS/ad_Tracts_VentPal_mask_R.txt

# Compute the radial diffusivity (RD) of the diffusion tensor. (equivalent to the mean of the two non-principal eigenvalues)
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_rd.mif TRACTS/rd_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_rd.mif TRACTS/rd_Tracts_VentPal_mask_R.txt

# Compute the linearity metric of the diffusion tensor. (one of the three Westin shape metrics)
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_cl.mif TRACTS/cl_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_cl.mif TRACTS/cl_Tracts_VentPal_mask_R.txt

# Compute the planarity metric of the diffusion tensor. (one of the three Westin shape metrics)
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_IntThalAdh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThalAdh_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_IntThalAdh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_cp.mif TRACTS/cp_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_cp.mif TRACTS/cp_Tracts_VentPal_mask_R.txt

# Compute the sphericity metric of the diffusion tensor. (one of the three Westin shape metrics)
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_AntCom_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_AntCom_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_AntCom_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_Caudate_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Caudate_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_Caudate_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_GPe_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPe_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_GPe_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_GPi_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_GPi_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_GPi_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_IntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntCap_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_IntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThaladh_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_IntThaladh_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_IntThaladh_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_IntThaladh_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_LocCoer_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_LocCoer_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_LocCoer_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_Putamen_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Putamen_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_Putamen_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_RedNucl_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_RedNucl_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_RedNucl_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_SubLentIntCap_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubLentIntCap_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_SubLentIntCap_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_STN_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_STN_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_STN_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_SubNig_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_SubNig_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_SubNig_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_Thalamus_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_Thalamus_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_Thalamus_mask_R.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_L.tck DWI_cs.mif TRACTS/cs_Tracts_VentPal_mask_L.txt
tcksample -stat_tck mean TRACTS/Tracts_VentPal_mask_R.tck DWI_cs.mif TRACTS/cs_Tracts_VentPal_mask_R.txt
