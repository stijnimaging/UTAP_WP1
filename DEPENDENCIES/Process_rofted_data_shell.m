%% Script for orienting ROFT data after changing the header
%
% First Flip/Permute the nifti stack with ExploreDTI; do not change
% anything to the data itself, only change the header automatically.
%
% Needed: the load_nii and save_nii functions embedded in ExploreDTI
% Change the name accordingly to match the input
%
% Last part is for visualisation, if needed to check.
clc
clear all
disp('Loading nifti file...');
img=load_nii('DWI_steamEchos_FP.nii');
dim=size(img.img);
img_org=img;
for t=1:dim(4); % Temporal dimension (volumes)
    disp(['Now processing volume: ' num2str(t)])
    for z=1:dim(1);% go slice by slice
           for y=1:dim(2);
               for x=1:dim(3);
                   zslice(x,y)=img.img(z,y,x,t);
               end
           end
    zslice=rot90(zslice); % Rotate the z-slice 90 degrees to match 
    img2(:,:,z)=fliplr(zslice);       % create new slice
    clear zslice
    end
    % Reorder Z-slices to flip inferior and superior in the stack (IF NEEDED)
    for z=1:dim(1);
        new_z=dim(1)-z+1;
        img1(:,:,z)=img2(:,:,new_z);
    end
    img2=img1;
img3(:,:,:,t)=img2;
clear img2
end
%img2=img3(:,:,:,1); imagesc(img2(:,:,70)');

% For brain shell dimensions:
img.hdr.dime.dim(2)=144; % X
img.hdr.dime.dim(3)=170; % Y
img.hdr.dime.dim(4)=148; % Z

% For brain jar dimensions
%img.hdr.dime.dim(2)=144; % X
%img.hdr.dime.dim(3)=180; % Y
%img.hdr.dime.dim(4)=134; % Z
img.hdr.dime.pixdim(1)=1;
img.hdr.dime.pixdim(2)=1;
img.hdr.dime.pixdim(3)=1;
img.hdr.dime.pixdim(4)=1;
img.img=img3;
disp('Saving nifti file...');
save_nii(img,'DWI_roft_reor.nii');

%% Check orientation visually; EXTRA
% t=1; % Select volume 1
% for z=1:img.hdr.dime.dim(4);
%     for y=1:img.hdr.dime.dim(3);
%         for x=1:img.hdr.dime.dim(2);
%             zslice(x,y)=img.img(x,y,z,t);
%         end
%     end
%     imagesc(flip(zslice')); % 144 x 180 voxels
%     newmap = contrast(zslice);
%     colormap(newmap)
%     pause(0.05)
% end
% disp(['Done processing volume!'])
