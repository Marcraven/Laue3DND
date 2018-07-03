function E = setup_experimental_data(B)
load(strcat(cd,'/Peaks/BackData.mat'));
E(1).Peaks=Peaks(ismember(Peaks(:,3),B.omegaList),1:4);
E(1).Peaks(:,1:2)=(E(1).Peaks(:,1:2)*400/4000)-200;
E(1).Peaks(:,1)=-E(1).Peaks(:,1);
E(1).remainingPeaks=E(1).Peaks; 

load(strcat(cd,'/Peaks/ForwardData.mat'));
E(2).Peaks=Peaks(ismember(Peaks(:,3),B.omegaList),1:4);
E(2).Peaks(:,1:2)=(E(2).Peaks(:,1:2)*400/4000)-200;
E(2).remainingPeaks=E(2).Peaks; 
end

