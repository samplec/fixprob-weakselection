function [minrho1, mat, tail, leaf] = OptimalBalloonStar(N)
%%% This function finds the balloon-star graph of a given size that has 
%%% the smallest rhoprime ratio under uniform initialization
% Input:  N - size of graph
% Output: minrho1 - the minimum rho prime 
% Output: mat - adjacency matrix of the graph with min rho prime
% Output: tail - the number of nodes in path part for the graph that minimizes rho prime given N
% Output: leaf - the number of leaf vertices at the end of the tail/path part of graph

%Loop through possible number of nodes in complete and path parts of graph
i = 0;
for c = ceil(N/2) : N - 1 %number of vertices in complete part (c >= t)
    for t = 1 : N-c  %number of vertices in tail part (path)
        i = i + 1;
        L(i) = N - c - t; %number of star vertices
        T(i) = t;  %number of tail vertices
    	W(:,:,i) = BalloonStar(c,t,L(i)); %create racket star graph of size N and path size t and star size L
        [~, rho1(i), ~] = WeakSelectionFixProb(N,W(:,:,i),0); %calculate fix prob
    end
end
%Find minimum ratio
[minrho1, ind] = min(rho1);

%adjacency matrix of graph with min ratio
mat = W(:,:,ind);
tail = T(ind);
leaf = L(ind);

end