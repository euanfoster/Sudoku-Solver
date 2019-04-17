function [poss] = elim_poss(grid,poss)
%USAGE
%	elim_poss(grid,poss)
%AUTHOR
%	Euan Foster (2019)
%SUMMARY
%	Elimantes possible solutions of a sodoku problem
%OUTPUTS
%	Generates the possible solutions from a given sodoku grid in a 3D
%	9x9x9 possibility matrix
%INPUTS
%	grid - Initial/updated sodoku problem in a 9 x 9 array
%	poss - Possible values of sodoku problem in a 3D 9x9x9 array. Each
%	depth slice of 9x9 corresponds to a value 1-9. Each 9x9 vartical and
%	horizontal rows corresponds to where in the sodoku grid the possibility
%	could lie
%NOTES
%	Eliminates possibilities based on the rules of sodoku froma  given
%	grid. This should return a unique value which can then be used to
%	update the sodoku grid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[r,c,d] = size(poss);

%Initial comparison to grid
for z = 1:d
    for y = 1:r
        for x = 1:c
            if grid(y,x) ~= 0 && grid(y,x) ~= z
                poss(y,x,z) = 0;
            end
        end
    end
end


%compares to grid and removes row possibilities
for y=1:r   %LOOP THROUGH GRID IN Y/ROWS
    for x=1:c   %LOOP THROUGH GRID IN X/COLUMNS
        
        %STORES VALUE IF THERE IS ONE
        if grid(y,x) ~= 0
            
            B = grid(y,x);
            
            for x2=1:c  %LOOP THROUGH POSS COLUMNS X
                if poss(y,x2,B) ~= 0 && grid(y,x2) ~= grid(y,x)
                    poss(y, x2, B) = 0;
                end
            end
            
        end
    end
end

%compares to grid and removes column possibilities
for y=1:r   %LOOP THROUGH GRID IN Y/ROWS
    for x=1:c   %LOOP THROUGH GRID IN X/COLUMNS
        
        %STORES VALUE IF THERE IS ONE
        if grid(y,x) ~= 0
            
            B = grid(y,x);
            
            for y2=1:c  %LOOP THROUGH POSS COLUMNS X
                if poss(y2,x,B) ~= 0 && grid(y2,x) ~= grid(y,x)
                    poss(y2, x, B) = 0;
                end
            end
            
        end
    end
end

%Compares possibilities to grid and removes possibilites that are not
%possible in the subgrid
for z = 1:d
    for ssgy = 1:3
        
        if ssgy ==1
            sgy=1;
        elseif ssgy == 2
            sgy = 4;
        elseif ssgy == 3
            sgy = 7;
        end
        
        for ssgx = 1:3
            
            if ssgx == 1
                sgx = 1;
            elseif ssgx == 2
                sgx = 4;
            elseif ssgx == 3
                sgx = 7;
            end
            
            for gy = 0:2
                for gx = 0:2
                    if grid((sgy+gy),(sgx+gx)) == z
                        
                        for gy2=0:2
                            for gx2=0:2
                                if poss((sgy+gy2),(sgx+gx2),z) == 1 && grid((sgy+gy2),(sgx+gx2))~= z
                                    poss(x,y,z) = 0;
                                end
                            end
                        end
                    else
                        break
                    end
                end
            end
        end
    end
end



end