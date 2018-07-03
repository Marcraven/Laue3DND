% S?ren Schmidt, ssch@fysik.dtu.dk, Marc Raventos, marc.raventos@psi.ch

function [pointsfinal1,pointsfinal2]=generate_diff_spots(B,D,L,x,Dpos1,Dpos2,Dtilt1,Dtilt2)
Dnorm1=D(1).normal;
Dnorm2=D(2).normal;

for i=1:B.omegaN
    xOmega(i,:)=(B.O(:,:,i)*x')';
    a=L(:,4)==B.omegaList(i);
    L(a,5)=xOmega(i,1);
    L(a,6)=xOmega(i,2);
    L(a,7)=xOmega(i,3);
end
RotationDetector1=CreateRotX(Dtilt1(1))*CreateRotY(Dtilt1(2))*CreateRotZ(Dtilt1(3));
InvRotationDetector1=inv(RotationDetector1);
RotatedNormal1=RotationDetector1*Dnorm1';

RotationDetector2=CreateRotX(Dtilt2(1))*CreateRotY(Dtilt2(2))*CreateRotZ(Dtilt2(3));
InvRotationDetector2=inv(RotationDetector2);
RotatedNormal2=RotationDetector2*Dnorm2';


pointsfinal1=[];
pointsfinal2=[];

for i=1:B.omegaN
    planeIndexes=L(L(:,4)==B.omegaList(i),8);
    Llab=B.O(:,:,i)*L(L(:,4)==B.omegaList(i),1:3)';
    %Chnge the tolerances of the grains in the sample reference system
    I1=plane_line_intersect(RotatedNormal1,Dpos1,xOmega(i,:),Llab);
    points1=(InvRotationDetector1*(I1-Dpos1)')';
    points1(:,5)=planeIndexes;
    points1=points1(dot(Llab',repmat(Dnorm1,size(Llab,2),1),2)<0,:);
    points1=points1(abs(points1(:,2))<D(1).side/2,:);
    points1=points1(abs(points1(:,3))<D(1).side/2,:);
    points1=points1(sqrt(points1(:,2).^2+points1(:,3).^2)>D(1).hole/2,:);    
    points1(:,4)=B.omegaList(i);
   
    
    pointsfinal1=[pointsfinal1;points1];
    
    I2=plane_line_intersect(RotatedNormal2,Dpos2,xOmega(i,:),Llab);
    points2=(InvRotationDetector2*(I2-Dpos2)')';
    points2(:,5)=planeIndexes;
    points2=points2(dot(Llab',repmat(Dnorm2,size(Llab,2),1),2)<0,:);
    points2=points2(abs(points2(:,2))<D(2).side/2,:);
    points2=points2(abs(points2(:,3))<D(2).side/2,:);
    points2=points2(sqrt(points2(:,2).^2+points2(:,3).^2)>D(2).hole/2,:);    
    points2(:,4)=B.omegaList(i);
%     scatter(points1(:,2),points1(:,3))
%     axis([-200 200 -200 200]);
%     pause(1);
    
    pointsfinal2=[pointsfinal2;points2];

end
%     scatter(pointsfinal2(:,2),pointsfinal2(:,3))
%     axis([-250 250 -250 250])
%     pause(0.5)
end