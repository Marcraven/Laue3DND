function [rodri,xposi,sposi,DetectorStuff,fval,finalfit1,finalfit2] = global_optimization(B,G,E,D,q,allin)%,samp_init_pos)
%Introduce the sample position in the model
samp_init_pos=[mean(allin(:,4)),mean(allin(:,5)),mean(allin(:,6))];
grain_pos=allin(:,4:6)-repmat(samp_init_pos,size(allin,1),1);
%Define initial conditions and constrains over orientation, grain position,
%sample position, and detector positioning and tilts
all0=[reshape(allin(:,1:3)',1,[]),reshape(grain_pos',1,[]),samp_init_pos,mean(allin(:,7:18),1)];
lall=[all0(1:q*3)-0.1,repmat(-10,1,q*3),samp_init_pos-10,D(1).lpostol,D(2).lpostol,-D(1).tilttol,-D(2).tilttol];
uall=[all0(1:q*3)+0.1,repmat(10,1,q*3),samp_init_pos+10,D(1).upostol,D(2).upostol,D(1).tilttol,D(2).tilttol];

% all0=horzcat(G.r(:,:,division),G.x,B.axdev,D.tilt);
% lall=horzcat(G.lbr(:,:,division),-G.xstol,-B.axdevtol,-D.tilttol);
% uall=horzcat(G.ubr(:,:,division),G.xstol,B.axdevtol,D.tilttol);
options = optimoptions(@fmincon,'PlotFcn',@optimplotfval,'Display','iter','Algorithm','sqp','UseParallel',true);
[all,fval]=fmincon(@fun,all0,[],[],[],[],lall,uall,[],options);
rodri=reshape(all(1:q*3),3,[])';
xposi=reshape(all(q*3+1:q*6),3,[])';
sposi=all(q*6+1:q*6+3);
DetectorStuff=all(q*6+4:q*6+15);

    function [cost]=fun(allx)
        allx(q*3+1:q*6)=allx(q*3+1:q*6)+repmat(samp_init_pos,1,q);
        allspots1=[];
        allspots2=[];
        parfor i=1:q
            [L] =laue_continuous_source(B,G,allx((i-1)*3+1:3*i));% Get the reflections for all divisions and omegas
            [spositions1{i},spositions2{i}] =generate_diff_spots(B,D,L,allx(q*3+(i-1)*3+1:(q+i)*3),allx(q*6+4:q*6+6),allx(q*6+7:q*6+9),allx(q*6+10:q*6+12),allx(q*6+13:q*6+15));
            spositions1{i}(:,8)=i;
            spositions2{i}(:,8)=i;
        end
        for i=1:q
            allspots1=[allspots1;spositions1{i}];
            allspots2=[allspots2;spositions2{i}];
        end
        [cost,finalfit1,finalfit2] = compare_all(B,E,allspots1,allspots2);
        
        
    end
end


