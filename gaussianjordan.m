function [solutions] = gaussianjordan(matrix)
[rows, columns] = size(matrix);

multiplyRow = 0;
addRow = 0;

for i = 1:rows
   multiplyRow = 1/matrix(i,i);
   matrix(i,:) = matrix(i,:)*multiplyRow;
    for j = 1:rows
        if j == i
            %Do nothing
        else
          %Do formula  
        element = matrix(j,i);
        addRow = matrix(i,:)*element;
         matrix(j,:) = matrix(j,:) - addRow;  
        end
    end
end
   matrix = matrix(:,columns);
   solutions = matrix; 
end
