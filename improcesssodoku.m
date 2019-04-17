clear improcesssodoku
close all

%Filename and location of sodoku image
filename = './sodoku.png';

%specifying where the numbers are stored on the sodoku grid
%psudo image processing o_0 could be improved
number   = [1, 2, 3, 4, 5, 6, 7, 8, 9];
indicesR = [2, 6, 1, 5, 1, 2, 1, 3, 3];
indicesC = [4, 5, 2, 1, 1, 1, 5, 3, 2];

%importing the image and deteriming where each number is
[grid, I] = import_sodoku(filename, number, indicesR, indicesC);

%plotting original problem
figure(01)
clf
imshow(I)
title('Original Sodoku Image')
hold on

%establish possible solutions relative to grid
poss = true([size(grid),9]);

counter = 1;
e = 1;

while e ~= 0
    old_grid = grid;
    
    %eliminates possibilites that are not possible
    poss = elim_poss(grid,poss);
    
    %update grid based on poss
    grid = poss_grid_comp(poss,grid);
    
    %calculates error based on scalar generated from grid
    %could use root finding method if computationally expensive
    e = sum(sum(grid)) - sum(sum(old_grid));
    
    counter = counter + 1;
end

sprintf('Puzzle Solved in %d iterations', counter)

%look up opening figure  maximised or better table
figure(02)
clf
t=uitable('Data',grid,'ColumnEditable',false, 'position', [5 5 500 200], 'ColumnWidth',{50});