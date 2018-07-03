clear all
close all
tic
%% Load Grains

folder='C:\Users\raventos_m\Dropbox\Neutron Grain Mapping\20180124_Fe_Sample\Isolated Grains 25-Jun-2018\';
name='210033.mat';
load(strcat(folder,name));
%% Beamline parameters B is beamline parameter
B=setup_beamline(0:1:240);
%% Detector parameters D is detector parameter
D=setup_detector;
D(1).tilt=mean(all(:,13:15));
D(1).pos=mean(all(:,7:9));
D(2).tilt=mean(all(:,16:18));
D(2).pos=mean(all(:,10:12));
D(1).lpostol=D(1).pos-0.01;
D(1).upostol=D(1).pos+0.01;
D(2).lpostol=D(2).pos-0.01;
D(2).upostol=D(2).pos+0.01;
D(1).tilttol=repmat(deg2rad(0.01),1,3);
D(2).tilttol=repmat(deg2rad(0.01),1,3);
%% Import dataset from fable, experimentSpots E
E=setup_experimental_data(B);
%% Grain parameters G is grain an crystal parameters
G=setup_grains(B,0);
%% Check every grain with all peaks
Final1=[];
Final2=[];
q=0;
info=[];
ten=0;

for i=1:size(all,1)
    [allval(i,:),fval] =grain_validation_minimization( B,G,E,D,all(i,:)) ;
    [E,q,temp,info,GvE1,GvE2,found(i)]=remove_spots_from_E(B,G,E,D,allval(i,:),q,info,ten);
    E(1).remainingPeaks=E(1).Peaks;
    E(2).remainingPeaks=E(2).Peaks;
    Final1=[Final1;[GvE1,repmat(q,size(GvE1,1),1)]];
    Final2=[Final2;[GvE2,repmat(q,size(GvE2,1),1)]];
end
temp=[];
%% Check repeated grains
for i=1:size(all,1)
    allval(i,1:3)=U2r(r2U(allval(i,1:3)));
end
check_r(:,1:3)=round(allval(:,1:3),2);
check_x(:,1:3)=round(allval(:,4:6)*2,0)/2;
[C,ia,ic]=unique([check_r,check_x],'rows');
allval_new=allval(ia,:);
Final1_new=Final1(ismember(Final1(:,8),ia),:);
Final2_new=Final2(ismember(Final2(:,8),ia),:);
%% Check which peaks are assigned better to another grain
FSAR{1}=[];
FSAR{2}=[];
PeaksAssigned1=unique(Final1(:,6));
PeaksAssigned2=unique(Final2(:,6));
for i=1:size(PeaksAssigned1,1)
    temp=Final1(Final1(:,6)==PeaksAssigned1(i),:);
    [a,b]=min(temp(:,7));
    FSAR{1}=[FSAR{1};temp(b,:)];
    clear temp a b
end
for i=1:size(PeaksAssigned2,1)
    temp=Final2(Final2(:,6)==PeaksAssigned2(i),:);
    [a,b]=min(temp(:,7));
    FSAR{2}=[FSAR{2};temp(b,:)];
    clear temp a b
end
%%
for i=1:size(allval,1)
    NSpots(i)=sum(size(FSAR{1}(:,8)==ia(i),1),size(FSAR{2}(:,8)==ia(i),1));
end

% figure
% histogram(FSAR{1}(:,8));
% figure
% [a1,b1,c1]=unique(G.F2(FSAR{1}(:,5)));
% FSAR{1}=[FSAR{1},c1];
% scatter3(FSAR{1}(:,8),FSAR{1}(:,7),FSAR{1}(:,9))
% xlabel('Grain');
% ylabel('Assignment distance [mm]')
% zlabel('Form Factor')
% title('Forward Diffraction')
% figure
% histogram(FSAR{2}(:,8));
% figure
% [a2,b2,c2]=unique(G.F2(FSAR{2}(:,5)));
% FSAR{2}=[FSAR{2},c2];
% scatter3(FSAR{2}(:,8),FSAR{2}(:,7),FSAR{2}(:,9))
% xlabel('Grain');
% ylabel('Assignment distance [mm]')
% zlabel('Form Factor')
% title('Backward Diffraction')
allold=all;
all=[];
all=allval;




%% Save
% FinalSpotsAndReflections=FSAR;
% grainsinfo=array2table(info,'VariableNames',{'Mean_dist','Median_dist','N_Assign_Correct','Threshold'})
% datevalidated=datetime('now','Format','HHmmss');
% save(strcat(folder,'validated',name),'B', 'D', 'E', 'G', 'FinalSpotsAndReflections' ,'all', 'grainsinfo','datevalidated');

