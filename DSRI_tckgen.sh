#!/bin/bash

mkdir TRACTS
# Create fiber tracts per region
tckgen DWI_FOD.mif TRACTS/Mask_AntCom_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_AntCom_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_AntCom_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_AntCom_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Caudate_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Caudate_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Caudate_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Caudate_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_GPe_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPe_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_GPe_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPe_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_GPi_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPi_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_GPi_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_GPi_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_IntCap_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntCap_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_IntCap_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntCap_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_IntThalAdh_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntThalAdh_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_IntThalAdh_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_IntThalAdh_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_LocCoer_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_LocCoer_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_LocCoer_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_LocCoer_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Putamen_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Putamen_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Putamen_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Putamen_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_RedNucl_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_RedNucl_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_RedNucl_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_RedNucl_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_STN_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_STN_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_STN_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_STN_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_SubLentIntCap_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubLentIntCap_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_SubLentIntCap_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubLentIntCap_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_SubNig_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubNig_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_SubNig_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_SubNig_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Thalamus_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Thalamus_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_Thalamus_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_Thalamus_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_VentPal_mask_L.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_VentPal_mask_L.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000
tckgen DWI_FOD.mif TRACTS/Mask_VentPal_mask_R.tck -algorithm SD_stream -mask DWI_Mask_Painted.mif -seed_image MASK/Mask_VentPal_mask_R.mif -fslgrad 48D_xzy_negZ.bvec 48D_zeros.bval -select 100000

