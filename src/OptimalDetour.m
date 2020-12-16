function [minratio, mat] = OptimalDetour(N)
%%% This function finds the detour graph of a given size that has 
%%% the smallest rhoprime/rhocircle ratio 
% Input:  N is size of graph
% Output: minratio is the minimum ratio 
% Output: mat is the adjacency matrix of the graph with min ratio

%initialize
W = zeros(N,N,N-3);     rho0=zeros(N-3,1);    rho1 = zeros(N-3,1);

%Loop through possible number of nodes in ring (detour) of graph
for R = 1:N-3
    W(:,:,R) = Detour(N,R); %create diamond ring graph of size N and ring size R
    [rho0(R), rho1(R), ~] = WeakSelectionFixProb(N,W(:,:,R),1); %calculate fix prob
end

%Find minimum ratio
[minratio, ind] = min(rho1./rho0);

%adjacency matrix of graph with min ratio
mat = W(:,:,ind);

end