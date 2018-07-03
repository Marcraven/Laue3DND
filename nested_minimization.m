function [ all,fval ] = nested_minimization( B,G,E,D,division)
% all0=horzcat(G.r(division,:),G.x,D(1).pos,D(2).pos,D(1).tilt,D(2).tilt);
% lall=horzcat(G.lbr(division,:),-G.xstol,D(1).lpostol,D(2).lpostol,-D(1).tilttol,-D(2).tilttol);
% uall=horzcat(G.ubr(division,:),G.xstol,D(1).upostol,D(2).upostol,D(1).tilttol,D(2).tilttol);
% options = optimoptions(@fmincon,'Display','off','FunValCheck','off','UseParallel',true);
% [all,fval]=fmincon(@fun,all0,[],[],[],[],lall,uall,[],options);
all0=horzcat(G.r(division,:),G.x,D(1).pos(1:2),D(2).pos,D(1).tilt,D(2).tilt);
lall=horzcat(G.lbr(division,:),-G.xstol,D(1).lpostol(1:2),D(2).lpostol,-D(1).tilttol,-D(2).tilttol);
uall=horzcat(G.ubr(division,:),G.xstol,D(1).upostol(1:2),D(2).upostol,D(1).tilttol,D(2).tilttol);
options = optimoptions(@fmincon,'Display','off','FunValCheck','off','UseParallel',false);
[all,fval]=fmincon(@fun,all0,[],[],[],[],lall,uall,[],options);
all= [all(1:8),0,all(9:17)];

function [cost]=fun(allx)
    r=allx(1:3);
    x=allx(4:6);
    Dpos1=allx(7:8);
    Dpos1(3)=0;
    Dpos2=allx(9:11);
    Dtilt1=allx(12:14);
    Dtilt2=allx(15:17);
    [L] =laue_continuous_source(B,G,r);% Get the reflections for all divisions and omegas
    [spositions1,spositions2] =generate_diff_spots(B,D,L,x,Dpos1,Dpos2,Dtilt1,Dtilt2);
    [temp1,cost,ref1,ref2] = compare_G_and_E(B,E,spositions1,spositions2);
%     Dpos1=allx(7:9);
%     Dpos2=allx(10:12);
%     Dtilt1=allx(13:15);
%     Dtilt2=allx(16:18);
%     [L] =laue_continuous_source(B,G,r);% Get the reflections for all divisions and omegas
%     [spositions1,spositions2] =generate_diff_spots(B,D,L,x,Dpos1,Dpos2,Dtilt1,Dtilt2);
%     [temp1,cost,ref1,ref2] = compare_G_and_E(B,E,spositions1,spositions2);
end
end

