function B=setup_beamline(omList)
%% Beamline parameters 
%x is the beam direction towards the sample, y is left towards the sample,
%z is down. 0,0,0 is the rotation axis position if there is no misalignment
B.omegaList=omList;
B.omegaN=size(B.omegaList,2);%list of omegas sampled
B.lambdamin=0.6; %minimum incident wavelength
B.lambdamax=6; % maximum incident wavelength
B.O=zeros(3,3,B.omegaN); %Initialize O
for i=1:B.omegaN
    B.O(:,:,i)=[cosd(B.omegaList(i)) -sind(B.omegaList(i)) 0; sind(B.omegaList(i)) cosd(B.omegaList(i)) 0; 0 0 1]; % Generate rotation matrix for all omegas
end