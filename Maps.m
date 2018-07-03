%% Clear all and close all
clear all
close all
tic
%% Beamline parameters B is beamline parameter
B=setup_beamline(0:1:240);
%% Detector parameters D is detector parameter
D=setup_detector;
%% Import dataset from fable, experimentSpots E
E=setup_experimental_data(B);
%% Grain parameters G is grain an crystal parameters
G=setup_grains(B);

%% Load multiple images being aware of the RAM limitations

LastImage=241;
FirstImage=1;
tic
%File1=read_tif('/Volumes/ws_niag/90_projects/93_data/P20170170/HZBFebruary2017/FALCON/few/Back/Cleaned/',LastImage,FirstImage);
File1=read_tif('I:/90_projects/93_data/P20170170/HZBFebruary2017/FALCON/few/Back/Cleaned/',LastImage,FirstImage);

%File1=read_tif('I:/90_projects/93_data/P20170170/HZBFebruary2017/FALCON/few/Transmission/RawTran/Unique/Clean/',LastImage,1);
'Time of file reading'

%File1=read_tif('C:/Users/raventos_m/Desktop/Clean/',LastImage,1);
%File1=read_tif('/Volumes/ws_niag/90_projects/93_data/P20170170/HZBFebruary2017/FALCON/cut1/Backdiffraction_Cleaned',LastImage,1);
toc
% caxis([min max]);
%% Segmentation
% subplot(3,3,1);

minInt=500;
minPix=9;
Peaks=[];
q=1;
for i=1:size(File1,3)
    originalImage=File1(:,:,i);
    if max(max(originalImage))~=0
    binaryImage=originalImage>minInt;
%    binaryImage = watershed_mine(binaryImage,minInt,minPix);

    imshow(binaryImage)
    labeledImage =bwlabel(binaryImage, 8);
    blobMeasurements = regionprops(labeledImage, originalImage, 'Area','MeanIntensity','BoundingBox','Centroid');
    boundaries = bwboundaries(binaryImage);
    numberOfBlobs=size(blobMeasurements,1);
    blobECD = zeros(1, numberOfBlobs);
    j=1;
   
        for k = 1 : numberOfBlobs
            if blobMeasurements(k).Area >minPix && blobMeasurements(k).MeanIntensity> minInt && sqrt((blobMeasurements(k).Centroid(1)-2000)^2+(blobMeasurements(k).Centroid(2)-2000)^2)>200
                newblob(j)=blobMeasurements(k);
                j=j+1;
            end
        end
        blobMeasurements=[];
        blobMeasurements=newblob;
        numberOfBlobs=size(blobMeasurements,2);
        for k = 1 : numberOfBlobs           % Loop through all blobs.
            thisBlobsBoundingBox = blobMeasurements(k).BoundingBox;  % Get list of pixels in current blob.
            blobs{q} = imcrop(originalImage, thisBlobsBoundingBox);
            q=q+1;
        end
        allBlobCentroids = [blobMeasurements.Centroid];
        temp=[];
        temp(:,1) = allBlobCentroids(1:2:end-1)';
        temp(:,2) = allBlobCentroids(2:2:end)';
        temp(:,3) = repmat(B.omegaList(i),size(temp,1),1);
        Peaks=[Peaks;temp];
        
%         imshow(originalImage)
%         caxis([0 500])
%            hold on
%            scatter(temp(:,1),temp(:,2),'LineWidth',2)
%            hold off
%             pause(0.1)
        %clear -except blobMeasurements allBlobCentroids temp thisBlobsBoundingBox numberOfBlobs originalImage labeledImage binaryImage
    end
    clearvars -except Peaks blobs i File1  minInt minPix q B
end
Peaks(:,4)=[1:1:size(Peaks,1)]';
clearvars -except Peaks blobs
toc
%%
% LastImage=241;
% File2=read_tif('I:/90_projects/93_data/P20170170/HZBFebruary2017/FALCON/few/Transmission/RawTran/Unique/Clean/',LastImage,1);
%
% for i=1:size(File2,3)
%     originalImage=File2(:,:,i);
% %     imshow(originalImage);
% %     % subplot(3,3,2);
% %     histogram(originalImage);
%     % subplot(3,3,3);
%     minInt=800;
%     %binaryImage=originalImage>minInt;
%     binaryImage = watershed(binaryImage,minInt,minPix);
%     labeledImage = bwlabel(binaryImage, 8);
%     blobMeasurements = regionprops(labeledImage, originalImage, 'all');
%
%     boundaries = bwboundaries(binaryImage);
%     numberOfBlobs=size(blobMeasurements,1);
%     blobECD = zeros(1, numberOfBlobs);
% %     figure;	% Create a new figure window.
%     % Maximize the figure window.
% %     set(gcf, 'Units','Normalized','OuterPosition',[0 0 1 1]);
% %     caxis([0 800]);
%     i=1;
%     for k = 1 : numberOfBlobs
%         if blobMeasurements(k).Area >10
%             newblob(i)=blobMeasurements(k);
%             i=i+1;
%         end
%     end
%     blobMeasurements=[];
%     blobMeasurements=newblob;
%     numberOfBlobs=size(blobMeasurements,2);
%     for k = 1 : numberOfBlobs           % Loop through all blobs.
%         thisBlobsBoundingBox = blobMeasurements(k).BoundingBox;  % Get list of pixels in current blob.
%         blobMeasurements(k).subImage = imcrop(originalImage, thisBlobsBoundingBox);
%     end
%     ForwardDiff{i,1}=blobMeasurements;
%     clear originalImage thresholdValues binaryImage labeledImage blobMeasurements boundaries numberofBlobs blobECD newBlob thisBlobsBoundingBox
% 
% end
% 
