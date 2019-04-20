function [grid] = poss_grid_comp(poss,grid)
%USAGE
%	elim_poss(poss,grid)
%AUTHOR
%	Euan Foster (2019)
%SUMMARY
%	Updates the soduku grid based on a 3D 9x9x9 array of possibilities
%OUTPUTS
%	Generates an updated grid based on a given 3D 9x9x9 array of possibilities 
%INPUTS
%	poss - Possible values of sodoku problem in a 3D 9x9x9 array. Each
%	depth slice of 9x9 corresponds to a value 1-9. Each 9x9 vartical and
%	horizontal rows corresponds to where in the sodoku grid the possibility
%	could lie
%   grid - Initial/updated sodoku problem in a 9 x 9 array. Unique
%   solutions of poss are identified in line with the rules of sodoku and
%   are used to update the grid.
%NOTES
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[r,c,d] = size(poss);

%if grid summation = 1, the value is stored, identified and implemented
sumpossd = sum(poss,3);

for y = 1:r
    for x = 1:c
        if grid(y,x) == 0 && sumpossd(y,x) == 1
            for z = 1:d
                if poss(y,x,z) == 1
                    grid(y,x) = z;
                end
            end
        else
            break
        end
    end
end

%if grid summation = 1, the value is stored, identified and implemented
sumpossc = sum(poss,2);

for z = 1:d
    for y = 1:r
        if sumpossc(y,1,z) == 1
            for x = 1:c
                if poss(y,x,z) == 1 && grid(y,x) == 0
                    grid(y,x) = z;
                end
            end
        else
            break
        end
    end
end

%Updates grid based on longitudinal summation
%if grid summation = 1, the value is stored, identified and implemented
sumpossr = sum(poss,1);

for z = 1:d
    for x = 1:c
        if sumpossr(1,x,z) == 1
            for y = 1:r
                if poss(y,x,z) == 1 && grid(y,x) == 0
                    grid(y,x) = z;
                end
            end
        else
            break
        end
    end
end

%updates grid based on sub grid values
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
                    B = sum(sum(poss(sgy:sgy+2,sgx:sgx+2,z)));
                    
                    if poss((sgy+gy),(sgx+gx),z) == 1 && B == 1
                        grid((sgy+gy),(sgx+gx))=z;
                    end
                end
            end
        end
    end
end

end