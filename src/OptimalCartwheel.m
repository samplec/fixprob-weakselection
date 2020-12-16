function [maxrhoprime, mat] = OptimalCartwheel(N)
%%% This function finds the cartwheel graph of a given size that has
%%% the largest rho prime
% Input:  N is size of graph
% Output: maxrhoprime is the maximum rho prime value
% Output: mat is the adjacency matrix of the optimal cartwheel graph

% Loop through possible cartwheel graphs of size N
i=0;
for h = 1:N-2  %number of vertices in hub
    for K = 2:N-1  %number of vertices on each island
        L = (N-h)/K; %number of islands
        if (floor(L) == L) && (L>0) && (K*L+h == N)
            i = i + 1;
            W(:,:,i) = Cartwheel(h,L,K);
            [~, rho1(i), ~] = WeakSelectionFixProb(N,W(:,:,i),1);
        end
    end
end

%Find largest rho prime
[maxrhoprime, pos] = max(rho1);

%adjacency matrix of graph with largest rho prime ratio
mat = W(:,:,pos);

end
