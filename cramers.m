function [solutions] = cramers(matrix)

[rows,columns] = size(matrix);

solutions = [];

b = matrix(:,columns);
A = matrix(:,1:columns-1);
tempMatrix = A;

D = det(A);
tempD = 0;
if (D == 0)
    fprintf("Determinant is 0, the system is singular");
    solutions = -1;
    return
end

for i = 1:columns-1
    tempMatrix(:,i) = b;
    tempD = det(tempMatrix);
    solutions = [solutions;tempD/D]; 
    tempMatrix = A;
end
end










