#!/bin/bash

# General script for processing 9.4T post-mortem imaging data
# Execute the script in the directory that has the ROFT data
# Start with DWI data (DWI_roft.nii)
# A connection with the imaging server is needed access the files and scripts
#
# UTAP Workpage 1 - development by Stijn Michielse 2021
# Department of Neurosurgery - University Maastricht

# Create temporary split directory 
mkdir DWI && cd DWI

# Split the 4D volume created by the ROFT procedure into separate 3D volumes
fslsplit ../DWI_roft.nii vol

# Pick every second 3D volume (this is the STEAM echo needed for further processing) and merge into one 4D volume
# The five B0 volumes will be placed in the beginning of the stack followed by the 48 diffusion directions making a total of 53 volumes
fslmerge -a DWI_steamEchos.nii.gz vol0001.nii.gz vol0027.nii.gz vol0053.nii.gz vol0079.nii.gz vol0105.nii.gz vol0003.nii.gz vol0005.nii.gz vol0007.nii.gz vol0009.nii.gz vol0011.nii.gz vol0013.nii.gz vol0015.nii.gz vol0017.nii.gz vol0019.nii.gz vol0021.nii.gz vol0023.nii.gz vol0025.nii.gz vol0029.nii.gz vol0031.nii.gz vol0033.nii.gz vol0035.nii.gz vol0037.nii.gz vol0039.nii.gz vol0041.nii.gz vol0043.nii.gz vol0045.nii.gz vol0047.nii.gz vol0049.nii.gz vol0051.nii.gz vol0055.nii.gz vol0057.nii.gz vol0059.nii.gz vol0061.nii.gz vol0063.nii.gz vol0065.nii.gz vol0067.nii.gz vol0069.nii.gz vol0071.nii.gz vol0073.nii.gz vol0075.nii.gz vol0077.nii.gz vol0081.nii.gz vol0083.nii.gz vol0085.nii.gz vol0087.nii.gz vol0089.nii.gz vol0091.nii.gz vol0093.nii.gz vol0095.nii.gz vol0097.nii.gz vol0099.nii.gz vol0101.nii.gz vol0103.nii.gz

# Unzip the merged file
echo "Logfile for processing data in $(pwd)" > DWI_info.txt
echo "Step A: steamEchos selected" >> DWI_info.txt
gunzip DWI_steamEchos.nii.gz

# Remove temporary split files
rm -R vol*

# Next step is to reorient the dataset in a logical way
# First the nifti data header is changed to make it logical for load_nii (in MatLab) to read
# The MatLab function "E_DTI_flip_permute_nii_file_exe(files{i},parameters,f_out{i});" will take care of this
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/ExploreDTI_Pcode_486')); parameters.suff='_FP'; parameters.permute=[1,2,3]; parameters.flip=[0,0,0]; parameters.force_voxel_size=[]; E_DTI_flip_permute_nii_file_exe('DWI_steamEchos.nii',parameters,'DWI_steamEchos_FP.nii'); clear all; close all; exit"

# Next reorient the files with a custom build script "Process_rofted_data_shell.m"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/')); Process_rofted_data_shell; clear all; close all; exit"
echo "Step B: DWI volumes reoriented correctly at $(date)" >> DWI_info.txt
fslhd DWI_roft_reor.nii >> DWI_info.txt

# Perform a visual check on the data to see for the orientation with fsleyes DWI_roft_reor.nii
#
# IT IS ESSENTIAL TO CHECK THE LEFT-RIGHT ORIENTATION
#
# With the data properly oriented the following steps in the pre-processing can take place
# Requires MRTrix and FSL to be installed
# Step 1: Denoise
# DWI data denoising and noise map estimation by exploiting data redundancy in the PCA domain using the prior knowledge that the eigenspectrum of
# random covariance matrices is described by the universal Marchenko Pastur distribution.
dwidenoise DWI_roft_reor.nii DWI_den.nii
echo "Step 1: DWI volumes denoise finished at $(date)" >> DWI_info.txt

# Step 2: Do eddy current correction, based on the first B0 volume
# This utilizes the 'old' eddy correct function
eddy_correct DWI_den.nii DWI_EC.nii.gz 0
echo "Step 2: Eddy Current correction finished at $(date)" >> DWI_info.txt

# Step 3: Create brain mask (check if the mask has only brain tissue)
# The Bval and Bvec files are needed!
# Procedure using the GRE sequence and FAST segmentation needs to be implemented.
dwi2mask DWI_EC.nii.gz DWI_mask.nii -fslgrad  ../../../48D_xzy_negXZ.bvec ../../../48D_zeros.bval 
echo "Step 3: Brain mask created at $(date)" >> DWI_info.txt

# Step 4: Response function estimation
dwi2response tournier DWI_EC.nii.gz DWI_response.txt  -fslgrad ../../../48D_xzy_negXZ.bvec ../../../48D_zeros.bval
echo "Step 4: Response function estimation completed at $(date)" >> DWI_info.txt
# Check the response function via "shview DWI_response.txt"

# Step 5: Estimate the fiber distribution using Constrained Spherical Deconvolution (CSD)
dwi2fod csd DWI_EC.nii.gz DWI_response.txt DWI_FOD.mif -mask DWI_mask.nii  -fslgrad ../../../48D_xzy_negXZ.bvec ../../../48D_zeros.bval
echo "Step 5: Fiber distribution estimation using CSD completed at $(date)" >> DWI_info.txt
# Check the CSD with "mrview DWI_EC.nii.gz -odf.load_sh DWI_FOD.mif

# Step 6: Create fiber tracts with SD_STREAM algorithm. This is aligned with CSD
tckgen DWI_FOD.mif Full_100k.tck -algorithm SD_STREAM -mask DWI_mask.nii -seed_image DWI_mask.nii -select 100000
echo "Step 6: Fiber tracts generated with CSD was completed at $(date)" >> DWI_info.txt
# Check the tracts with "mrview DWI_EC.nii.gz -tractography.load Full_100k.tck"

# Or use the Tensor_Det algorithm
tckgen DWI_EC.nii.gz Full_100k_DWI.tck -algorithm Tensor_Det -mask DWI_mask.nii -seed_image DWI_mask.nii -select 100000 -force -fslgrad ../../../48D_xzy_negXZ.bvec ../../../48D_zeros.bval


##### STOP AFTER THIS LINE - LEFT/RIGHT HEMISPHERE MASKS ARE REQUIRED!!!

# Step 7: Perform whole hemisphere analysis to get DTI measures per hemisphere (HC vs. TD vs. AR subtypes)
# NEEDED: a mask per hemisphere!
tckgen DWI_FOD.mif LH_100k.tck -algorithm SD_STREAM -mask DWI_mask_L.nii -seed DWI_mask.nii -select 100000
tckgen DWI_FOD.mif RH_100k.tck -algorithm SD_STREAM -mask DWI_mask_R.nii -seed DWI_mask.nii -select 100000

# Step 7A: Get metrics FA and vectors
tensor2metric DWI_FOD.mif -fa DWI_FA.mif
tensor2metric DWI_FOD.mif -adc DWI_adc.mif
tensor2metric DWI_FOD.mif -ad DWI_ad.mif
tensor2metric DWI_FOD.mif -rd DWI_rd.mif
tensor2metric DWI_FOD.mif -cl DWI_cl.mif
tensor2metric DWI_FOD.mif -cp DWI_cp.mif
tensor2metric DWI_FOD.mif -cs DWI_cs.mif

# Step 7B: Get values of an associated image along tracts
# Left hemisphere, depends on output from tckgen (in which a LH mask is needed)
tcksample -stat_tck mean LH_100k.tck DWI_FA.mif LH_FA.txt 

# Step 8: Perform region of interest analysis on basal ganglia and brainstem structures
# NEEDED: a mask per hemisphere for each ROI
# List of ROI's:
# - red nucleus (RN)
# - ventral pallidum (VP)
# - anterior commissure (AC)
# - ansa lenticularis (AL)
# - internal capsule (IC)
# - sublenticular internal capsule (sIC)
# - interthalamic adhesion (ITA)
# - medial lemniscus (ML)
# - Sub Thalamic Nucleus (STN)
# - Substantia Nigra (SN)
# - Globus Pallidus (GP) 

