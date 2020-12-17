function W = ConvertGraphToMatrix(N,txtfile)
% Function to store the adjacency matrices of all simple, connected graphs of size N as a MATALB array called W
% INPUT N is the size of the graph
% INPUT txtfile is a text file that contains adjacency matrix data for all simple, connected graphs of size N
% this file should be produced from executing showg on an infile in graph6 format
% found on Brendan McKay's website: http://users.cecs.anu.edu.au/~bdm/data/formats.html
% OUTPUT W is an array of size N x N x (number of graphs)

row = 0;
graphnum = 1; 

fid = fopen(txtfile);
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