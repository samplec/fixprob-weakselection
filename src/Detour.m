function Y = Detour(N,R)
%This function finds the adjacency matrix for a detour graph
% INPUT N is graph size
% INPUT R is the number of vertices in the detour
% OUTPUT Y is the adjacency matrix

%creates a complete graph of size N-R
X=ones(N-R,N-R);
Y=triu(X,1);
%adds a detour to the graph
for i = 1 : R 
    Y(N-R+i-1,N-R+i)=1;
end
Y(1,N-R)=0;
Y(N,N)=0;
Y(1,N)=1;
Y=Y'+Y; %matrix is symmetric

