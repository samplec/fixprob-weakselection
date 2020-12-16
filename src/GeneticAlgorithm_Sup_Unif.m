%%This script uses a genetic algorithm to find the best supressor 
%%(smallest rhoprime) under uniform initialization
%%Genetic algorithm was modified from:
%%%% Moller M, Hindersin L, Traulsen A. Exploring and mapping the universe of
%%%% evolutionary graphs identifies structural properties affecting fixation
%%%% probability and time. Communications Biology. 2019.

%% parameters
clear
N = 11; %graph size
n = 5000; %number of iterations
p = 0.2; %erdos-reyni link probability
m = 400; %number of random graphs we are choosing
k = 10; %number of parents per generation
b = 1; %number of mutations per individual per time step
mutchance = b/nchoosek(N,2); %small chance of mutation

%% preallocate space
G = zeros(N,N,m);   rho0 = zeros(m,1);  rhoprime = zeros(m,1);

%% Generate m random Erdos-Renyi Graphs (step #1 and step #2 of genetic algorithm)
i = 1;
while i<=m %creates m graphs
    [G(:,:,i)]=create_ER_Graph(N,p); %creates erdos-reyni random graph of size N with link probability p
    if ~any(~(G(:,:,i)*ones(N,1))) %checks that the created graph has no isolated vertices
        [rho0(i), rhoprime(i), isocheck] = WeakSelectionFixProb(N, G(:,:,i),0);  %calcuate weak selection fixation probabity
        if isocheck < 2 %checks that the fixation probabilty is solvable
            i=i+1;
        end
    end
end

%% Iterate process n times (step #3 of genetic algorithm)
for nn = 1:n
    
    %% Choose the best k graphs (largest rhoprime) as parents for the next generation
    [~,pos] = mink(rhoprime,k);
    parents = G(:,:,pos);
    
    %% Generate m new graphs, each with two parents, by recombination (step # 4 of genetic algorithm)
    % Every link can be inherited from either parent with a probability of 1/2.
    % If a resulting graph is not connected, it gets recreated until it is.
    ii = 1;
    while ii <= m
        %choose two random parents  (parents can be the same)
        parent1 = parents(:,:,randi(k));
        parent2 = parents(:,:,randi(k));
        %create child
        G(:,:,ii) = 0;
        for i = 1:N-1
            for j = i+1:N  %upper triangular part of matrix
                %decides which parent to take value from
                if rand < 0.5
                    G(i,j,ii) = parent1(i,j);
                else
                    G(i,j,ii) = parent2(i,j);
                end
                %decides to mutate with average of b mutations per indiviual per time step
                if rand < mutchance
                    G(i,j,ii) = ~G(i,j,ii);
                end
            end
        end
        G(:,:,ii) = G(:,:,ii) + G(:,:,ii)'; %matrix is symmetric
        if ~any(~(ones(1,N)*G(:,:,ii)))  %checks that no vertices are isolated
            [rho0(ii), rhoprime(ii), isocheck] = WeakSelectionFixProb(N, G(:,:,ii),0);
            if isocheck < 2  %graph is connected and fix prob can be calculated
                ii = ii + 1;
            end
        end
    end
end

%% RESULTS
% find optimal graph
[val, pos] = min(rhoprime);
optimalG = G(:,:,pos);

% plot optimal graph
figure;
plot(graph(G(:,:,pos)),'EdgeAlpha',1,'MarkerSize',9,'NodeColor',[0.72 0.07 1],...
    'LineWidth',2, 'EdgeColor',[0 0 0], 'EdgeLabel',{}, 'NodeLabel',{}, 'Layout', 'force');
title(strcat('Smallest \rho'' for N = ',num2str(N),' is ', num2str(val)));
