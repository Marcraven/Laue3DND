function [B] = fillwithzeros(A,n)
%A=fliplr(A);
C=centerOfMass(A);
dif=round(C-size(A)/2);
left=floor((n-size(A,2))/2)-dif(2);
top=floor((n-size(A,1))/2)-dif(1);
right=ceil((n-size(A,2))/2)+dif(2);
bottom=ceil((n-size(A,1))/2)+dif(1);
A=imbinarize(A);
%A=A*1000;
%A=A./(sum(sum(A)));
B=padarray(A,[top left],0,'pre');
B=padarray(B,[bottom right],0,'post');
 end

