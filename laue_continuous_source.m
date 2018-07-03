% S?ren Schmidt, ssch@fysik.dtu.dk, Marc Raventos, marc.raventos@psi.ch
function [L] =laue_continuous_source(B,G,r)
U=r2U(r);
w=U*G.v;% rotate the theoretical scatter vector v according to the orientation U. (UBh according to grainspotter)

lambdas=(-4*pi*G.Om*[G.inv.*w(1,:); G.inv.*w(2,:)])'; % find lambdas, laue mode

w=repmat(w,1,1,B.omegaN);
w=permute(w,[2 3 1]);
w=reshape(w,[],3,1);
lambdas=reshape(lambdas,numel(lambdas),1);
validlambdas=~(lambdas<=B.lambdamin | lambdas>= B.lambdamax); %Find lambdas outside the range
lambdas(:,2:4)=w; %Attach the scattering vectors
%lambda_w_omega_rotationvector
clear w
omeg=repmat(B.omegaList,G.nplanes,1);
omeg=reshape(omeg,[],1);
lambdas(:,5)=omeg; % Attach the omegas
clear omeg
Om=G.Om;
Om(:,3)=0;
Om=repmat(Om',G.nplanes,1);
Om=reshape(Om,3,[])';
lambdas(:,6:8)=Om; %Attach the rotation for every omega
clear Om
lambdas(:,9)=repmat([1:1:G.nplanes]',B.omegaN,1); %Attach the plane indexes
lambdas=lambdas(validlambdas,:);
clear validlambdas
Gr=repmat(lambdas(:,1),1,3)/4/pi.*lambdas(:,2:4);
L=2*Gr+lambdas(:,6:8); %substitute the theoretical scattering vector with G
L(:,4)=lambdas(:,5);
L(:,8)=lambdas(:,9);

%% REFORMULATION
% w2=U*G.v2;
% lambdas2=(-2*G.Om*[G.inv2.*w2(1,:); G.inv2.*w2(2,:)])';
% w2=repmat(w2,1,1,B.omegaN);
% w2=permute(w2,[2 3 1]);
% w2=reshape(w2,[],3,1);
% lambdas2=reshape(lambdas2,numel(lambdas2),1);
% validlambdas2=~(lambdas2<=B.lambdamin | lambdas2>= B.lambdamax); %Find lambdas outside the range
% lambdas2(:,2:4)=w2; 
% lambdas2=lambdas2(validlambdas,:);
% Gr2=repmat(lambdas2(:,1),1,3).*lambdas2(:,2:4)/2;
end

