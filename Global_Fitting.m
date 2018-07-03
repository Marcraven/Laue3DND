%% Clear all and close all
clear all
close all
%% Read data from FindGrains
load('C:\Users\raventos_m\Dropbox\Neutron Grain Mapping\20180124_Fe_Sample\Isolated Grains 22-Jun-2018\045140.mat');
%% Beamline parameters B is beamline parameter
B=setup_beamline(0:1:240);
%% Detector parameters D is detector parameter
D=setup_detector;
%% Import dataset from fable, experimentSpots E
E=setup_experimental_data(B);
%% Grain parameters G is grain an crystal parameters
G=setup_grains(B);
%% Find a solution
q=size(all,1);
if size(all,2)<18 %insert a 0 if the position of detector 1 was deleted previously
    all= [all(:,1:8),zeros(size(all,1),1),all(:,9:17)];
end
[rodri,xposi,sposi,Detec,fval,finalfit1,finalfit2] = global_optimization(B,G,E,D,q,all);%,sposi);
all3=[rodri,xposi,repmat(Detec,size(rodri,1),1)];
%%
% %%
% for i=1:ngrains
%     %Take only spots from ith grain
%     grainspots1{i}=finalfit1(finalfit1(:,8)==i,:);
%     grainspots2{i}=finalfit2(finalfit2(:,8)==i,:);
%     info(i,1)=mean([grainspots1{i}(:,7);grainspots2{i}(:,7)]);
%     info(i,2)=median([grainspots1{i}(:,7);grainspots2{i}(:,7)]);
%     info(i,3)=sum(size(grainspots1{i},1),size(grainspots2{i},1));
%     info(i,4)=info(i,3)/(size(E(1).Peaks,1)+size(E(2).Peaks,1));
% end
% %%
% grainsinfo=array2table(info,'VariableNames',{'Mean_dist','Median_dist','N_Assign_Correct','Percentage'})
 Table1=array2table(finalfit1,'VariableNames',{'z','x','y','Omega','hkl','AssignedPeak','AssignmentDistance','grain'});
 Table2=array2table(finalfit2,'VariableNames',{'z','x','y','Omega','hkl','AssignedPeak','AssignmentDistance','grain'});

%%
foldname=['Isolated Grains ' date];
mkdir(foldname)
save('C:\Users\raventos_m\Dropbox\Neutron Grain Mapping\20180124_Fe_Sample\Isolated Grains 22-Jun-2018\Solution045140.mat','rodri','xposi','sposi','Detec','finalfit1','finalfit2');
% rodri are the rodrigues vectors of all grains
% xposi are the positions of the grains on the sample
% Detec are the deviation of D1, the deviation of D2, the tilt of D1, and the tilt of D2
%% Keep only fitted spots

% []=merge_and_clean(B,G,E,D,q,rodri,xposi,Detec)
