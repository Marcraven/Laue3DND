function [G] = setup_grains(B,planefams)
readeqmat;

% G.abc=2.867;%2.874 ;
unitcell(1)=2.867;
unitcell(2)=2.867;
unitcell(3)=2.867;
unitcell(4)=90;
unitcell(5)=90;
unitcell(6)=90;
G.Ba=2*pi*formB(unitcell);%2*pi/G.abc*[1 0 0;0 1 0;0 0 1];

% G.hkl=generate_hkl_new(G.nhkl);
h=importh(strcat(cd,'/ListOfHKLs/AlphaFe.txt'));

for i=1:size(h,1)
    G.F2(i)=h{i,3};
    G.dhkl(i)=h{i,2};
    G.hkl(i,1:3)=str2num(h{i,1});
    PlaneMagnitudes(i)=norm(G.hkl(i,1:3));
end
PlanesNormalized=round(G.hkl./repmat(PlaneMagnitudes,3,1)',5);
[a,b]=unique(PlanesNormalized,'rows');
b=sort(b);
G.hkl=G.hkl(b,:);
G.dhkl=G.dhkl(b);
G.F2=G.F2(b);
G.F2=G.F2';
G.dhkl=G.dhkl';
% F2s=sort(unique(G.F2),'descend');
% %forbidden=G.F2<1;
% forbidden=G.F2<F2s(planefams);
% %forbidden=G.F2==0;
% G.F2(forbidden)=[];
% G.dhkl(forbidden)=[];
% G.hkl(forbidden,:)=[];
G.nplanes=size(G.hkl,1);
G.v=(G.Ba*G.hkl');

G.inv = (1./(G.v(1,:).^2+G.v(2,:).^2+G.v(3,:).^2));

G.Om =[cosd(B.omegaList); -sind(B.omegaList)]';
G.ngrains=50; % How many grains should the code try to find.
% Divide the orientation space and set orientation constrains
G.Divisions=25;
G.lims=[sqrt(2)-1 sqrt(2)-1 sqrt(2)-1]; %side of the truncated cube in Rodrigues space for a cubic geometry
[lbr0,ubr0,rs0]=generate_constrains(G.Divisions);
G.lbr=[lbr0(:,1) lbr0(:,2) lbr0(:,3)].*G.lims;
G.ubr=[ubr0(:,1) ubr0(:,2) ubr0(:,3)].*G.lims;%ubr0*lims;
G.r=[rs0(:,1) rs0(:,2) rs0(:,3)].*G.lims;%rs0*lims;
% Set position constrains
G.lbx=[-10 -10 -10];
G.ubx=[10 10 10];
G.x = [0 0 0];
G.xstol=[15 15 15];
for i=1:B.omegaN
    G.xOmega(i,:)=(B.O(:,:,i)*G.x')';
end
% G.U=r2U(G.rs(1,:,:)); % Set the rotation from Rodrigues vector to rotation Matrix
%G.Ba2=formB(unitcell);
% G.v2=(G.Ba2*G.hkl');
%G.inv2 = (1./(G.v2(1,:).^2+G.v2(2,:).^2+G.v2(3,:).^2));
end

