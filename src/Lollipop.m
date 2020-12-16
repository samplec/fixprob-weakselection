function Y = Lollipop(c,t)
%c - number of vertices in the lollipop (complete graph)
%t - number of vertices in the stick (path graph)

N = c + t;  %graph size
Y=ones(c,c) - diag(ones(c,1)); %complete graph
%bridge part
Y(c,c+1) = 1; 
Y(c+1,c) = 1; 
%path part
for i = 1 : t - 1 
    Y(c+i,c+i+1)=1;
    Y(c+i+1,c+i)=1;
end

%plot(graph(Y))