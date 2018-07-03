function [ tif ] = read_tif( datadir,  final, initial)
if nargin < 3;
    initial=1;
end

files = dir(fullfile(strcat(datadir,'*.tif')));
for i=initial:final
   names{i-initial+1}=files(i).name;
end
tif=[];
tif=int16(tif);
parfor i=1:final-initial+1;
    % {} = cell array
tif(:,:,i) = imread(sprintf(strcat(datadir,'/%s'),names{i}));


end




end

