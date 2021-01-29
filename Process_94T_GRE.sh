#!/bin/bash

# General script for processing 9.4T post-mortem imaging data
# Execute the script in the directory that has the ROFT data
# Start with GRE data (GRE_roft.nii)
# A connection with the imaging server is needed access the files and scripts
#
# UTAP Workpage 1 - development by Stijn Michielse 2021
# Department of Neurosurgery - University Maastricht

# Create temporary split directory 
mkdir GRE && cd GRE
echo "Logfile for processing data in $(pwd)" > GRE_info.txt

# Split the 4D volume created by the ROFT procedure into separate 3D volumes
fslsplit ../GRE_roft.nii GRE

gunzip GRE0000.nii.gz
gunzip GRE0001.nii.gz
gunzip GRE0002.nii.gz
gunzip GRE0003.nii.gz
echo "Step A: GRE datafile splitted at $(date)" >> GRE_info.txt


# Next step is to reorient the dataset in a logical way
# First the nifti data header is changed to make it logical for load_nii (in MatLab) to read
# The MatLab function "E_DTI_flip_permute_nii_file_exe(files{i},parameters,f_out{i});" will take care of this
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/ExploreDTI_Pcode_486')); parameters.suff='_FP'; parameters.permute=[1,2,3]; parameters.flip=[0,0,0]; parameters.force_voxel_size=[]; E_DTI_flip_permute_nii_file_exe('GRE0000.nii',parameters,'GRE0000_FP.nii'); clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/ExploreDTI_Pcode_486')); parameters.suff='_FP'; parameters.permute=[1,2,3]; parameters.flip=[0,0,0]; parameters.force_voxel_size=[]; E_DTI_flip_permute_nii_file_exe('GRE0001.nii',parameters,'GRE0001_FP.nii'); clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/ExploreDTI_Pcode_486')); parameters.suff='_FP'; parameters.permute=[1,2,3]; parameters.flip=[0,0,0]; parameters.force_voxel_size=[]; E_DTI_flip_permute_nii_file_exe('GRE0002.nii',parameters,'GRE0002_FP.nii'); clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/ExploreDTI_Pcode_486')); parameters.suff='_FP'; parameters.permute=[1,2,3]; parameters.flip=[0,0,0]; parameters.force_voxel_size=[]; E_DTI_flip_permute_nii_file_exe('GRE0003.nii',parameters,'GRE0003_FP.nii'); clear all; close all; exit"

# Next reorient the files with a custom build script "GRE_orient_shell.m"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/')); name_gre='GRE0000_FP.nii'; GRE_orient_shell; clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/')); name_gre='GRE0001_FP.nii'; GRE_orient_shell; clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/')); name_gre='GRE0002_FP.nii'; GRE_orient_shell; clear all; close all; exit"
matlab -nodesktop -nodisplay -nosplash -r "addpath(genpath('/Volumes/imaging_div3/UTAP_WP1/MRI_Scripts/')); name_gre='GRE0003_FP.nii'; GRE_orient_shell; clear all; close all; exit"

# Because fslmerge cannot load the _oriented files created in MatLab, first convert to FSL standard
fslreorient2std GRE0000_FP_oriented.nii GRE0000_FP_oriented_std.nii.gz
fslreorient2std GRE0001_FP_oriented.nii GRE0001_FP_oriented_std.nii.gz
fslreorient2std GRE0002_FP_oriented.nii GRE0002_FP_oriented_std.nii.gz
fslreorient2std GRE0003_FP_oriented.nii GRE0003_FP_oriented_std.nii.gz

fslmerge -a GRE_roft_reor.nii.gz GRE0000_FP_oriented_std.nii.gz GRE0001_FP_oriented_std.nii.gz GRE0002_FP_oriented_std.nii.gz GRE0003_FP_oriented_std.nii.gz
echo "Step B: GRE volumes reoriented correctly at $(date)" >> GRE_info.txt
fslhd GRE_roft_reor.nii.gz >> GRE_info.txt

# Perform a visual check on the data to see for the orientation with fsleyes GRE_roft_reor.nii
#
# IT IS ESSENTIAL TO CHECK THE LEFT-RIGHT ORIENTATION
#
# With the data properly oriented the following steps in the pre-processing can take place
# Requires MRTrix and FSL to be installed
# Step 1: Denoise
# GRE data denoising and noise map estimation by exploiting data redundancy in the PCA domain using the prior knowledge that the eigenspectrum of
# random covariance matrices is described by the universal Marchenko Pastur distribution.
dwidenoise GRE_roft_reor.nii.gz GRE_den.nii
echo "Step 1: GRE volumes denoise finished at $(date)" >> GRE_info.txt

# Step 2: Run segmentation using FAST (this takes a lot of time)
fast -t 2 -g -o FAST/E6 GRE0000_FP_oriented_std.nii
fast -t 2 -g -o FAST/E20 GRE0001_FP_oriented_std.nii
fast -t 2 -g -o FAST/E12 GRE0002_FP_oriented_std.nii
fast -t 2 -g -o FAST/E28 GRE0003_FP_oriented_std.nii
echo "Step 2: Segmentation in grey and white matter completed at $(date)" >> GRE_info.txt

# Step 3: Create mask using the FAST output (only brain tissue and silicone)
fslmaths FAST/E20_pve_2.nii.gz -thr 0.00000000000001 -bin FAST/GRE_E20_mask

# Step 4: Do the coregistration of the mask to DWI space
flirt -in FAST/GRE_E20_pve_2.nii.gz -ref ../DWI/DWI_B0.nii.gz -out ../DWI/GRE2DWI.nii.gz -omat FAST/GRE2DWI.mat
flirt -in FAST/GRE_E20_mask.nii.gz -ref ../DWI/DWI_B0.nii.gz -out ../DWI/GRE2DWI_mask.nii.gz -omat FAST/GRE2DWI.mat

# Perform manual cleanup of the brain mask
