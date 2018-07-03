function [ lbr0,ubr0,rs0 ] = generate_constrains(nDiv)

%Divides the rodrigues space in nDiv divisions


CubesMatrix=ones(nDiv^3,3);
% 
for i=1:nDiv^3
    CubesMatrix(i,1)=ceil(i/nDiv^2);
    CubesMatrix(i,2)=ceil(i/nDiv)-(floor((i-1)/nDiv^2)*nDiv);
    CubesMatrix(i,3)=i-(CubesMatrix(i,2)-1)*nDiv-(CubesMatrix(i,1)-1)*nDiv^2;
end
% [x,y,z]=hilbert3(6);
% rs0=2*[x;y;z]';

rs0=((((2*CubesMatrix)-1)./(nDiv))-1);
% searchSize=2;
% lbr0=rs0-(4/(size(rs0,1))^(1/3));
% ubr0=rs0+(4/(size(rs0,1))^(1/3));
lbr0=rs0-(4/25);
ubr0=rs0+(4/25);
% scatter3(rs0(1,1,:),rs0(1,2,:),rs0(1,3,:))
% set(gca,'XLim',[-1 1],'YLim',[-1 1],'ZLim',[-1 1])
lbr0(lbr0<-1)=-1.01;
ubr0(ubr0>1)=1.01;
end

