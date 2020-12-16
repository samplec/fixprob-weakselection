function Y = Balloon(c,t)
%This function finds the adjacency matrix for a balloon graph
% INPUT c is the number of vertices in the balloon (complete graph)
% INPUT t is the number of vertices in the handle (path graph)
% OUTPUT Y is the adjacency matrix

N = c + t;  %graph size
Y=ones(c,c) - diag(ones(c,1)); %complete graph

%bridge part
Y(c-1,c) = 0;
Y(c,c-1) = 0;
Y([c-1, c],c+1) = 1; 
Y(c+1,[c c-1]) = 1; 

%path part
for i = 1 : t - 1 
    Y(c+i,c+i+1)=1;
    Y(c+i+1,c+i)=1;
end
