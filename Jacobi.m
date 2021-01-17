function [answers,i, error] = HW7Jacobi(matrix, guess, tolerance, stopping) %Define the function
%Algorithm for Jacobi
[rows,cols] = size(matrix);
roots = matrix(:, cols);
matrix(:, cols) = [];
[newRows, newCols] = size(matrix);

for i = 1:newRows
    roots(i) = roots(i)/matrix(i,i);
    newXValues(i) = guess(i);
    for j = 1:newRows
        if(i~=j)
            matrix(i,j) = matrix(i,j)/matrix(i,i);
        end
    end
end

error = intmax;
iterations = 0;
while(error > tolerance)
    iterations = iterations + 1;
    error = 0;
    for i = 1: newRows
        oldXValue(i) = newXValues(i);
        newXValues(i) = roots(i);
    end
    for i = 1: newRows
        for j = 1: newRows
            if(i~=j)
                newXValues(i) = newXValues(i)- (matrix(i,j) * oldXValue(j));
            end
        end
        error = error + abs(newXValues(i)-oldXValue(i));
    end
    if stopping == 1
        error = error/newRows;
    else
        error = sqrt((error^2)/newRows);
    end
end
answers = newXValues;
i = iterations;


