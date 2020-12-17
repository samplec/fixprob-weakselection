% Script file to store the adjacency matrices of all simple, connected graphs
% of size N as a MATALB array called W
% The file graph.txt contains the adjacency matrix data, which was produced from
% executing showg on an infile in graph6 format
% found on Brendan McKay's website: http://users.cecs.anu.edu.au/~bdm/data/formats.html

clear;

%%%%%% Graph Size - user should change this value
N = 4;  
%%%%%%

row = 0;
graphnum = 1; 

fid = fopen('graphs.txt');
tline = fgetl(fid);

 while ischar(tline)
     size(tline)
    if ~isempty(tline) && (strcmp(tline(1),'0') || strcmp(tline(1),'1'))
        row = row + 1;
        if row > N
            graphnum = graphnum + 1;
            row = 1;
        end
        for i = 1 : N
            W(row,i,graphnum) = str2double(tline(i));
        end
    end
    tline = fgetl(fid);
 end
fclose(fid);