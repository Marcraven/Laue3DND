function [precise,reflections1,reflections2] = compare_all(B,E,p1,p2)

% reflections=zeros(size(G.reflections,1),14);
e1=E(1).Peaks;
e2=E(2).Peaks;
% e1(:,4)=[1:1:size(E(1).remainingPeaks)]';
% e2(:,4)=[1:1:size(E(2).remainingPeaks)]';
reflections1=[];
reflections2=[];
% experimentaltemp1=[];
% experimentaltemp2=[];
precise1=[];
precise2=[];
rough1=[];
rough2=[];
for i=1:B.omegaN
    eo1=e1(e1(:,3)==B.omegaList(i),:);
    eo2=e2(e2(:,3)==B.omegaList(i),:);
    which1=p1(p1(:,4)==B.omegaList(i),:);
    which2=p2(p2(:,4)==B.omegaList(i),:);
    if ~isempty(eo1) && ~isempty(which1) 
        [which1(:,6),which1(:,7)]=knnsearch(eo1(:,1:2),which1(:,2:3));
        which1(:,9)=eo1(which1(:,6),4);
        sorted1=sortrows(which1,7);
        [a1,b1,c1]=unique(sorted1(:,6),'rows');
        sorted1=sorted1(b1,:);
        reflections1=[reflections1;sorted1];
        precise1=[precise1,(size(sorted1,1))/sum(1./(sorted1(:,7)+0.25))];
%         rough1=[rough1,median(sorted1(:,7))];
    end
    
   if ~isempty(eo2) && ~isempty(which2)
        [which2(:,6),which2(:,7)]=knnsearch(eo2(:,1:2),which2(:,2:3));
        which2(:,9)=eo2(which2(:,6),4);
        sorted2=sortrows(which2,7);
        [a2,b2,c2]=unique(sorted2(:,6),'rows');
        sorted2=sorted2(b2,:);
        reflections2=[reflections2;sorted2];
        precise2=[precise2,(size(sorted2,1))/sum(1./(sorted2(:,7)+0.25))];
%         rough2=[rough2,median(sorted2(:,7))];
    end
end
%  e1=e1(ismember(e1(:,4),reflections1(:,8)),:);
%  e2=e2(ismember(e2(:,4),reflections2(:,8)),:);
%  scatter3(reflections2(:,2),reflections2(:,3),reflections2(:,4))
%  hold on
%  scatter3(e2(:,1),e2(:,2),e2(:,3))
 reflections1(:,6)=reflections1(:,9);
 reflections2(:,6)=reflections2(:,9);
%  reflections1(:,8)=reflections1(:,9);
%  reflections2(:,8)=reflections2(:,9);
 reflections1(:,9)=[];
 reflections2(:,9)=[];
precise1(isnan(precise1))=[];
precise2(isnan(precise2))=[];
rough1(isnan(rough1))=[];
rough2(isnan(rough2))=[];
%reflections explanation by columns:
%1 - X position of the simulated spot
%2 - Y position of the simulated spot
%3 - Z position of the simulated spot
%4 - Omega
%5 - Index of the diffraction plane with respect to the original G.hkl
%matrix
%6 - Global index of the experimental spot to which the simulated spot is assigned
%(With respect to E.Peaks and E.rawPeaks)
%7 - Distance between simulated spot and experimental spot
% rough=mean(rough1)+mean(rough2); %try sum in both
% logdist=log([reflections1(:,7);reflections2(:,7)]);
% gmdist=fitgmdist(logdist,2);
% precise=gmdist.mu(1);
precise=mean(precise1)+mean(precise2);%(size(reflections,1))/sum(1./(reflections(:,7)+0.25));%sum(GVecStd);%size(GVecStd,2)/sum(1./(GVecMean(:)+0.25));





%% Old version
% e1=E(1).Peaks;
% e2=E(2).Peaks;
% 
% 
% 
% reflections1=[];
% reflections2=[];
% for i=1:B.omegaN
%     eo1=e1(e1(:,3)==B.omegaList(i),:);
%     eo2=e2(e2(:,3)==B.omegaList(i),:);
%     if ~isempty(eo1) && ~isempty(eo2)
%         which1=p1(p1(:,4)==B.omegaList(i),:);
%         which2=p2(p2(:,4)==B.omegaList(i),:);
%         [which1(:,6),which1(:,7)]=knnsearch(eo1(:,1:2),which1(:,2:3));
%         [which2(:,6),which2(:,7)]=knnsearch(eo2(:,1:2),which2(:,2:3));
%         which1(:,9)=eo1(which1(:,6),4);
%         which2(:,9)=eo2(which2(:,6),4);
%         
%         sorted1=sortrows(which1,7);
%         sorted2=sortrows(which2,7);
%         [a1,b1,c1]=unique(sorted1(:,6),'rows');
%         [a2,b2,c2]=unique(sorted2(:,6),'rows');
%         sorted1=sorted1(b1,:);
%         sorted2=sorted2(b2,:);
%         % sorted1(isnan(sorted1(:,7)),:)=[];
%         % sorted2(isnan(sorted2(:,7)),:)=[];
%         reflections1=[reflections1;sorted1];
%         reflections2=[reflections2;sorted2];
%         
%         precise1(i)=size(sorted1,1)/sum(1./(sorted1(:,7)+0.25));
%         precise2(i)=size(sorted2,1)/sum(1./(sorted2(:,7)+0.25));
%     end
% end
% reflections1(:,6)=reflections1(:,9);
% reflections2(:,6)=reflections2(:,9);
% reflections1(:,9)=[];
% reflections2(:,9)=[];
% %reflections explanation by columns:
% %1 - X position of the simulated spot
% %2 - Y position of the simulated spot
% %3 - Z position of the simulated spot
% %4 - Omega
% %5 - Index of the diffraction plane with respect to the original G.hkl
% %matrix
% %6 - Global index of the experimental spot to which the simulated spot is assigned
% %(With respect to E.Peaks and E.rawPeaks)
% %7 - Distance between simulated spot and experimental spot
% %8 - Grain which the diffraction spot belongs to
% precise=mean(precise1+precise2);%2*size(sortedfinal,1)/sum(1./((sortedfinal(:,6).^2+0.25)));
% 

end

