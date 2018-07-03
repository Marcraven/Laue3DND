%% Clear all and close all
clear all
close all
tic

%% Beamline parameters B is beamline parameter
B=setup_beamline(0:40:240);
%% Detector parameters D is detector parameter
D=setup_detector;
%% Import dataset from fable, experimentSpots E
E=setup_experimental_data(B);

%% Grain parameters G is grain an crystal parameters
G=setup_grains(B,0);
%% Obtain the G vectors for pre-scan
tic
divis=size(G.r,1);%(2^(G.Divisions))^3;
for i=1:divis
    [L] =laue_continuous_source(B,G,G.r(i,:));% Get the reflections for all divisions and omegas
    [spositions1{i},spositions2{i}] =generate_diff_spots(B,D,L,G.x,D(1).pos,D(2).pos,D(1).tilt,D(2).tilt);
end
clear L
'Time of the pre-scan pattern generation'
toc
%% Scan the space, optimize, remove and iterate
GrainsAreLeftToBeFound=true;
q=0;
% ncand=1;
th=1;
grainsinfo=[];
FinalSpotsAndReflections{1}=[];
FinalSpotsAndReflections{2}=[];
perc(1)=100;
found=0;
% while keepsearch=='Y'
firstime=true;
tic
while GrainsAreLeftToBeFound
    cost=[];
    for i=1:divis
        [cost(i),~] = compare_G_and_E(B,E,spositions1{i},spositions2{i});
    end
    'Time of the comparison with all divisions'
    toc
    cost=cost';
    cost(:,2)=(1:1:divis)';
    cost=sortrows(cost,1);
    NoNeedToSearchAgain=true;
    ten=0;
    while NoNeedToSearchAgain
        tic
        [E,q,temp,grainsinfo,GvE1,GvE2,cost,found,ten]=optimize_candidate( B,G,E,D,cost,q,grainsinfo,ten);
        'Time of the optimization of candidate'
        toc
        
        if found %If a grain fits less than 1% of the peaks, the iterations are over
            'Grain found'
            '% of peaks left to fit:'
            perc(q+1)=(size(E(1).remainingPeaks,1)+size(E(2).remainingPeaks,1))/(size(E(1).Peaks,1)+size(E(2).Peaks,1))*100
            NoNeedToSearchAgain=true;
            all(q,:)=temp;
            FinalSpotsAndReflections{1}=[FinalSpotsAndReflections{1};[GvE1,repmat(q,size(GvE1,1),1)]];
            FinalSpotsAndReflections{2}=[FinalSpotsAndReflections{2};[GvE2,repmat(q,size(GvE2,1),1)]];
            firstime=true;
        end
        if ten>10 && ~found
            NoNeedToSearchAgain=false;
            if firstime
                firstime=false;
                GrainsAreLeftToBeFound=true;
            else
                GrainsAreLeftToBeFound=false;
            end
        end
    end
end

clearvars -except B D E G FinalSpotsAndReflections all grainsinfo
foldname=['Isolated Grains ' date];
mkdir(foldname)
totaltimeinseconds=toc
save(strcat(foldname,'\',sprintf('%s.mat',datetime('now','Format','HHmmss'))))
