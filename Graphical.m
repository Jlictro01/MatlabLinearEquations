function[] = Graphical(M)
[Mrow, Mcol] = size(M);
A = M(:, 1:end-1);
B = M(:, Mcol);
[numEq, numVars] = size(A);
figure();
if numVars == 2
    if numEq == 2
         x21 = @(x1)( ( A(1,1)/A(1,2) * -1)*x1 + (B(1)/A(1,2) ))
         x22 = @(x1) ( ( A(2,1)/A(2,2) * -1)*x1 + (B(2)/A(2,2) ))
         fplot(x21)  
         hold on
         fplot(x22)
         xlabel("X1");
         ylabel("X2");
         
    elseif numEq == 3 %Probably unnecessary, but it can work for 3 linear equations with 1 unknown
         x21 = @(x1)( ( A(1,1)/A(1,2) * -1)*x1 + (B(1)/A(1,2) ))
         x22 = @(x1) ( ( A(2,1)/A(2,2) * -1)*x1 + (B(2)/A(2,2) ))
         x23  = @(x1) ( ( A(3,1)/A(3,2) * -1)*x1 + (B(3)/A(3,2) ))
         fplot(x21)
         hold on
         fplot(x22)
         hold on
         fplot(x23)
         xlabel("X1");
         ylabel("X2");
    end
elseif numVars == 3
    if numEq == 2 %Probably unecessary, but it can work for 3 equations of 2 unknowns
        [x1,x2] = meshgrid(-20:0.50:20);
        x31 = ( (B(1)/A(1,3) + (A(1,2)/A(1,3)*-1)*x2 + (A(1,1)/A(1,3)*-1)*x1 ));
        surf(x31, x1, x2)
        hold on
        x32 =( (B(2)/A(2,3) + (A(2,2)/A(2,3)*-1)*x2 + (A(2,1)/A(2,3)*-1)*x1 ));
        hold on
        surf(x32, x1, x2)
          xlabel("X1");
         zlabel("X2");
         ylabel("X3");
    elseif numEq == 3
        [x1,x2] = meshgrid(-20:0.50:20);
        x31 = ( (B(1)/A(1,3) + (A(1,2)/A(1,3)*-1)*x2 + (A(1,1)/A(1,3)*-1)*x1 ));
        surf(x31, x1, x2)
        hold on
        x32 =( (B(2)/A(2,3) + (A(2,2)/A(2,3)*-1)*x2 + (A(2,1)/A(2,3)*-1)*x1 ));
        hold on
        surf(x32, x1, x2)  
        x33  = ( (B(3)/A(3,3) + (A(3,2)/A(3,3)*-1)*x2 + (A(3,1)/A(3,3)*-1)*x1 ));
        hold on
        surf(x33, x1, x2)
        hold on
        xlabel("X3");
        zlabel("X2");
        ylabel("X1");
    end
end

