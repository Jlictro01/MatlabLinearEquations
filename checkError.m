function [isDiagonalized, nonAug, broken] = checkError(Matrix)
[rows, cols] = size(Matrix);
nonAug = Matrix(:, 1:cols-1);
[row, col] = size(nonAug);
if row ~= col
    broken = 1;
    fprintf("Matrix must be square.")
    return;
end
if det(nonAug) == 0
    broken = 1;
    fprintf("Matrix is singular.")
else
    broken = 0;
end


cols = cols-1; %adjust for not counting col b
isDiagonallyDom = 1; %assume it is diagonally dominant unless proven otherwise
for i = 1: rows %nested for loop to sum each row, and compare the sum to the value of the diagonal number
    rowElements = Matrix(i,:);
    sum = 0;
    for j = 1: cols
        if(j~=i)
            sum = sum + abs(rowElements(j));
        end
    end
    if sum > Matrix(i,i)
       
        isDiagonallyDom = 0;
    end
end
isDiagonalized = isDiagonallyDom;
if isDiagonalized == 1
    fprintf("Diagonalized!")
else
    fprintf("Not Diagonalized!")
end