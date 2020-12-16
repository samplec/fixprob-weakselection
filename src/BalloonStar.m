function Y = BalloonStar(c,t,l)
%This function finds the adjacency matrix for a balloon-star graph
% INPUT c is the number of vertices in the balloon (complete graph)
% INPUT t is the number of vertices in the handle (path graph)
% INPUT l is the number of leaves on the star part of the graph
% OUTPUT Y is the adjacency matrix

N = c + t + l;  %graph size
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

%star part
Y(c+t,c+t+1:N) = 1;
Y(c+t+1:N, c+t) = 1;

end
