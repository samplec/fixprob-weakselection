function [minrho1, mat, minT] = OptimalBalloon(N)
%%% This function finds the balloon graph of a given size that has 
%%% the smallest rhoprime ratio under uniform initialization
% Input:  N - size of graph
% Output: minrho1 - the minimum rho prime 
% Output: mat - adjacency matrix of the graph with min rho prime
% Output: minT - the number of nodes in tail (path) for the graph that minimizes rho prime 

%Initialize
W = zeros(N,N,N-3);     rho1 = zeros(N-3,1);

%Loop through possible number of nodes in tail (path) of graph
for t = 1:N-3
    W(:,:,t) = Balloon(N-t,t); %create racket graph of size N and tail size t
    [~, rho1(t), ~] = WeakSelectionFixProb(N,W(:,:,t),0); %calculate fix prob
end

%Find minimum ratio
[minrho1, minT] = min(rho1);

%adjacency matrix of graph with min ratio
mat = W(:,:,minT);

end