# fixprob-weakselection
This code contains various MATLAB files to generate the data in the manuscript: "Fixation probabilities in graph-structured populations under weak selection" by Benjamin Allen, Christine Sample, Patricia Steinhagen, Julia Shapiro, Matthew King, Timothy Hedspeth, Megan Goncalves

## Description of files

Data Files:

* 'workspace_N3-9.mat' contains the weak selection fixation probabilities and adjacency matrices for all small graphs of size N = 3 through 9, under temperature and uniform initialization.
* 'workspace_N10.mat' contains the weak selection fixation probabilities and adjacency matrices for all small graphs of size N = 10, under temperature and uniform initialization.

Source Files:

* 'WeakSelectionFixProb.m' is a function that calculates the weak selection fixation probability for the given graph under temperature or uniform initialization. It returns rhocircle and rhoprime using the formulas provided in the main text.
* 'create_ER_Graph.m' is a function that creates a random Erdos-Reyni graph for the given graph size and link probability.
* 'GeneticAlgorithm_Amp_Temp.m' implements a genetic algorithm to find the optimal amplifier (largest rho prime) under temperature initialization. It depends on the functions WeakSelectionFixProb.m and create_ER_Graph.m.
* 'GeneticAlgorithm_Sup_Temp.m' implements a genetic algorithm to find the optimal supressor (smallest ratio of rho prime over rho circle) under temperature initialization. It depends on the functions WeakSelectionFixProb.m and create_ER_Graph.m.
* 'GeneticAlgorithm_Sup_Unif.m' implements a genetic algorithm to find the optimal supressor (smallest rho prime) under uniform initialization. It depends on the functions WeakSelectionFixProb.m and create_ER_Graph.m.
* 'Detour.m' is a function that creates a Detour graph of a given graph size and detour length.
* 'OptimalDetour.m' is a function that finds the Detour graph of a given graph size with the smallest ratio rhoprime/rhocircle. It depends on the functions WeakSelectionFixProb.m and Detour.m.
* 'Cartwheel.m' is a function that creates a Cartwheel graph of a given number of vertices in the hub, number of islands, and number of vertices per island.
* 'OptimalCartwheel.m' is a function that finds the Cartwheel graph of a given graph size with the largest rhoprime. It depends on the functions WeakSelectionFixProb.m and Cartwheel.m.
* 'Lollipop.m' is a function that creates a Lollipop graph of a given number of vertices in the hub and path parts of the graph.
* 'OptimalLollipop.m' is a function that finds the Lollipop graph of a given graph size with the smallest ratio rhoprime/rhocircle. It depends on the functions WeakSelectionFixProb.m and Lollipop.m.
* 'Balloon.m' is a function that creates a Balloon graph of a given number of vertices in the hub and path parts of the graph.
* 'OptimalBalloon.m' is a function that finds the Balloon graph of a given graph size with the smallest ratio rhoprime/rhocircle. It depends on the functions WeakSelectionFixProb.m and Balloon.m.
* 'BalloonStar.m' is a function that creates a Balloon-Star graph of a given number of vertices in the hub, path, and star parts of the graph.
* 'OptimalBalloonStar.m' is a function that finds the Balloon-Star graph of a given graph size with the smallest ratio rhoprime/rhocircle. It depends on the functions WeakSelectionFixProb.m and BalloonStar.m.

## Usage
The main MATLAB script files can be directly run as long as their helper functions have been downloaded.

## License
See LICENSE for details.
