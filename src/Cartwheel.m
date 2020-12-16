function G = Cartwheel(h,n,m)
%This function finds the adjacency matrix for a cartwheel graph
% INPUT h - number of vertices in hub
% INPUT n - number of islands (n should be no greater than h)
% INPUT m - number vertices per island
% OUTPUT G - adjacency matrix for the graph

%% initalize
N = h+m*n;  %total number of vertices
G = zeros(N,N);  

%% construct complete hub
for i = 1:h-1
    G(i,i+1:h) = 1;
end

%% construct islands
for j = 1 : n
    for i = 1:m-1
        G(h+i+m*(j-1),h+i+1+m*(j-1):h+m*j)=1;
    end
end

%%  attach islands to hub
for i = 1:n
    G(i,h+1+m*(i-1)) = 1;
end

%% graph is undirected
 G = G + G';
