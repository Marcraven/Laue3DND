function [E,q,all,info,good1,good2,found,ten] = remove_spots_from_E(varargin)
B=varargin{1};
G=varargin{2};
E=varargin{3};
D=varargin{4};
all=varargin{5};
q=varargin{6};
info=varargin{7};
ten=varargin{8};


r=all(1:3);
x=all(4:6);
Dpos1=all(7:9);
Dpos2=all(10:12);
Dtilt1=all(13:15);
Dtilt2=all(16:18);
% r=all(1:3);
% x=all(4:6);
% Dpos1=all(7:8);
% Dpos1(3)=0;
% Dpos2=all(9:11);
% Dtilt1=all(12:14);
% Dtilt2=all(15:17);
[gvectors] =laue_continuous_source(B,G,r);% Get the reflections for all divisions and omegas
[spositions1,spositions2] =generate_diff_spots(B,D,gvectors,x,Dpos1,Dpos2,Dtilt1,Dtilt2);
[~,~,reflections1, reflections2] = compare_G_and_E(B,E,spositions1,spositions2);


listofe1=ismember(E(1).Peaks(:,4),reflections1(:,6));
listofe2=ismember(E(2).Peaks(:,4),reflections2(:,6));
figure(7);
hold off
scatter3(E(1).Peaks(listofe1,1),E(1).Peaks(listofe1,2),E(1).Peaks(listofe1,3));
hold on
scatter3(reflections1(:,2),reflections1(:,3),reflections1(:,4));
hold off
figure(8);
hold off
scatter3(E(2).Peaks(listofe2,1),E(2).Peaks(listofe2,2),E(2).Peaks(listofe2,3));
hold on
scatter3(reflections2(:,2),reflections2(:,3),reflections2(:,4));
hold off
logdist=log([reflections1(:,7);reflections2(:,7)]);
figure(5)
histogram([reflections1(:,7);reflections2(:,7)],'BinWidth',0.25);
figure(6)
histogram(logdist);
gmdist=fitgmdist(logdist,2);
[a,mudata]=min(gmdist.mu);
converged=gmdist.Converged;
%threshold=1.5;%input('Choose a threshold to consider the spots correctly fitted [0 means repeat search]: ');
%med=median([reflections1(:,7);reflections2(:,7)]);
% Rverse UB matrix to obtain planes and compare
clust=cluster(gmdist,logdist);
threshold=exp(max(logdist(clust==mudata)));
good1=reflections1(reflections1(:,7)<threshold,:);
good2=reflections2(reflections2(:,7)<threshold,:);
found=false;
ten=ten+1;
if   median([good1(:,7);good2(:,7)])<=2 && size([good1;good2],1)>=B.omegaN
     found=true;
    q=q+1
    info(q,1)=mean([good1(:,7);good2(:,7)]);
    info(q,2)=median([good1(:,7);good2(:,7)]);
    info(q,3)=size([good1;good2],1);
    info(q,4)=threshold;
%     reflections1(reflections1(:,7)>threshold,:)=[];
%     reflections2(reflections2(:,7)>threshold,:)=[];
    b1=ismember(E(1).remainingPeaks(:,4),good1(:,6),'rows');
    b2=ismember(E(2).remainingPeaks(:,4),good2(:,6),'rows');
%     info(q,4)=size([good1;good2],1);
    removed1=E(1).remainingPeaks(b1,:);
    removed2=E(2).remainingPeaks(b2,:);
    E(1).remainingPeaks(b1,:)=[];
    E(2).remainingPeaks(b2,:)=[];
    plot_fit( G,q,removed1,removed2,good1,good2);
%else
% 
%     GvE1=[];
%     GvE2=[];
end

% toremove=fitted(:,6)0.5;
% remainingPeaks=E.remainingPeaks(toremove,:
end

