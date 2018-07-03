function [E,q,temp,grainsinfo,GvE1,GvE2,cost,found,ten] = optimize_candidate( B,G,E,D,cost,q,grainsinfo,ten)
division=cost(1,2);
%  parfor i=1:ncandidates
[ all,~] = nested_minimization( B,G,E,D,division);
%  end
[E,q,temp,grainsinfo,GvE1,GvE2,found,ten]=remove_spots_from_E(B,G,E,D,all,q,grainsinfo,ten);

cost(1,:)=[];
% [a,b]=min(fval);
% parameters=all(b,:);
% cost(1:ncandidates,:)=[];
end




