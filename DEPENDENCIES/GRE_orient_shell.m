%% Script to reorient one GRE volume
%
% First use fslsplit to split the 4D volume in separate 3D volumes
% This reduces the file size. 
% The input nifti files need to be unzipped
%
% Next Flip/Permute the nifti stack with ExploreDTI; do not change
% anything to the data itself, only change the header automatically.
%
% Change the name accordingly
% Last part is for visualisation, if needed to check.
clc
% clear all
% name_gre='GRE0000_FP.nii';
img=load_nii(name_gre);
% Save loaded nifti img s
img_org=img;
dim=size(img.img);

 
for z=1:dim(1); % go slice by slice
           for y=1:dim(2);
               for x=1:dim(3);
                   zslice(x,y)=img.img(z,y,x);
               end
           end
    %imagesc(zslice'); % 866 x 576 voxels
    zslice=flipud(zslice);
    zslice=fliplr(zslice);
    img2(:,:,z)=(zslice');       % create new slice
    clear  zslice
    disp(['Done processing slice number: ' num2str(z)]);
end

% Reorder Z-slices to flip inferior and superior in the stack (IF NEEDED)
for z=1:dim(1);
    new_z=dim(1)-z+1;
    img1(:,:,z)=img2(:,:,new_z);
end
img2=img1;

% Dimensions for Brain jar:
img.hdr.dime.dim(2)=640; % X
img.hdr.dime.dim(3)=680; % Y
img.hdr.dime.dim(4)=566; % Z

% Dimensions for Brain shell:
%img.hdr.dime.dim(2)=576; % X
%img.hdr.dime.dim(3)=688; % Y
%img.hdr.dime.dim(4)=490; % Z

img.hdr.dime.pixdim(1)=1;
img.hdr.dime.pixdim(2)=0.25;
img.hdr.dime.pixdim(3)=0.25;
img.hdr.dime.pixdim(4)=0.25;
img.hdr.dime.pixdim(5)=1;
img.img=img2;

save_nii(img,[name_gre(1:end-4) '_oriented.nii']);
disp(['Nifti file ' name_gre(1:end-4) '_oriented.nii is saved!']);
%% Check orientation visually
% 
% for z=1:img.hdr.dime.dim(4);
%     for y=1:img.hdr.dime.dim(3);
%         for x=1:img.hdr.dime.dim(2);
%             zslice(x,y)=img.img(x,y,z);
%         end
%     end
%     imagesc(flip(zslice')); % 144 x 180 voxels
%     newmap = contrast(zslice);
%     colormap(newmap)
%     pause(0.05)
% end
