function [answers, i, error] = HW7GaussSeidel(matrix, guess, tolerance, stopping) %Define the function
%Algorithm for Gauss-Seidel
[rows,cols] = size(matrix);
roots = matrix(:, cols);
matrix(:, cols) = [];
[newRows, newCols] = size(matrix);

disp(matrix)

for i=1:newRows
    roots(i) = roots(i)/matrix(i,i);
    xValues(i) = guess(i);
    oldXValues(i) = xValues(i);
    for j = 1:newRows
        if(i~=j)
            matrix(i,j) = matrix(i,j) / matrix(i,i);
        end
    end
end
error = intmax;

iterations = 0;
while(error > tolerance)
    iterations = iterations + 1;
    error = 0;
    for i = 1:newRows
        xValues(i) = roots(i);
        for j = 1:newRows
            if(i~=j)
                xValues(i) = xValues(i) - matrix(i,j) * xValues(j);
            end
        end
        error = error + abs(xValues(i) - oldXValues(i));
        oldXValues(i) = xValues(i);
    end
    if stopping == 1
        error = error/newRows;
    else
        error = sqrt((error^2)/newRows);
    end
end
answers = xValues;
i = iterations;