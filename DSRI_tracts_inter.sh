#!/bin/bash

# Get tracts that connect the basal ganglia, based on the Tensor_Full 
# Create full tractogram to work with (5M tracts)
tckgen DWI_FOD.mif DWI_Full_5M.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image DWI_Mask_Painted.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 5000000

mkdir TRACTS_INTER
# RIGHT Hemisphere
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_Caudate_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_Caudate_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_GPe_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_GPe_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_GPi_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_GPi_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_IntCap_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_IntCap_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_IntThalAdh_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_IntThalAdh_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_LocCoer_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_LocCoer_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_Putamen_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_Putamen_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_RedNucl_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_RedNucl_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_STN_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_STN_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_SubLentIntCap_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_SubLentIntCap_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_SubNig_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_SubNig_mask_R.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_R.mif -include MASK/Mask_Thalamus_mask_R.mif TRACTS_INTER/Mask_AntCom_mask_R_2_Mask_Thalamus_mask_R.tck

# LEFT Hemisphere
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_Caudate_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_Caudate_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_GPe_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_GPe_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_GPi_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_GPi_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_IntCap_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_IntCap_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_IntThalAdh_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_IntThalAdh_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_LocCoer_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_LocCoer_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_Putamen_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_Putamen_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_RedNucl_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_RedNucl_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_STN_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_STN_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_SubLentIntCap_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_SubLentIntCap_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_SubNig_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_SubNig_mask_L.tck
tckedit DWI_Full_5M.tck -include MASK/Mask_AntCom_mask_L.mif -include MASK/Mask_Thalamus_mask_L.mif TRACTS_INTER/Mask_AntCom_mask_L_2_Mask_Thalamus_mask_L.tck
