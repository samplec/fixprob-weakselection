function[G] = create_ER_Graph(N,p)
%This function generates an Erdos-Renyi random graph
%input N is the size of the graph
%input p is the probability that two nodes will have an edge between them
%output G is the adjacency matrix of the graph

% Create an N x N matrix of 0s (with probability 1-p) and 1s (with probability p)
G = rand(N,N) <= p; 
% Ensure that the matrix is symmetric 
G = triu(G,1); 
G = G + G'; 