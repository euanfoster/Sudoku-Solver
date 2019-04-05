function [grid, I] = import_sodoku(filename, number, indicesR, indicesC)
%Imports a sodoku image and stores each number in a 9x9 array
%You need to give a filename and location
%You need to give where the numbers are stored in the array

    I = imread(filename);
    I = im2bw(I);
    I = imcomplement(I);
    
    spacingY = size(I,1)/9;
    gridcentres.Y = [spacingY/2:spacingY:size(I,1)];

    spacingX = size(I,2)/9;
    gridcentres.X = [spacingX/2:spacingX:size(I,2)];

    % extract masks

    for i=1:length(indicesR)
        r = indicesR(i);
        c = indicesC(i);

        x = round(gridcentres.X(c)-spacingX*4/10):round(gridcentres.X(c)+spacingX*4/10);
        y = round(gridcentres.Y(r)-spacingY*4/10):round(gridcentres.Y(r)+spacingY*4/10);
        mask{i} = I(y, x);

    end

    % process the image
    grid = zeros(9,9);


    for i=1:length(gridcentres.X)
        for j=1:length(gridcentres.Y)
            plot(gridcentres.X(i), gridcentres.Y(j), 'yx')

            x = round(gridcentres.X(i)-spacingX*4/10):round(gridcentres.X(i)+spacingX*4/10);
            y = round(gridcentres.Y(j)-spacingY*4/10):round(gridcentres.Y(j)+spacingY*4/10);
            data = I(y, x);
            %figure(2)
            %clf
            %imshow(data)


            % check if there's something there at all
            if sum(data(:))>0
                val = zeros(9,1);
                for k=1:9
                    M = xcorr2(double(data), double(mask{k}));
                    val(k) = max(M(:));
                end
                [~,number] = max(val);

                grid(j,i) = number;
            end
                
            

        end
    end
end