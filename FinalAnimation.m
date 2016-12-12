     
function FinalAnimation () 
%% V 
  X3 = -2:.1:2;
    Y3 = X3;
    [x,y] = meshgrid(X3);
    u = -y;
    v = .5*x;
    subplot(2,2,1);
    quiver(x,y,u,v) 

 %% DivGrad - Grad*V    

     X2 = linspace(-2, 2);
     Y2 = linspace(-2, 2); 
     U20 = zeros(100,100);
     size(U20)
     function res = Udipole2(t,x,y)
         res = [0.5* log(((x - 1)^2 + y^2))];
     end
     for i = 1: 100 
        for j = 1:100
         U20(i,j) = Udipole2(0, X2(i), Y2(j));
        end
     end 
     U20 = reshape(U20,[10000,1]); 
     %Convert to matrix
     function divgrad2 = Divgrad2(~, V2, u, v)
           size(V2)
           V2 = reshape(V2,[100,100]);
           [dx2, dy2] = gradient(V2);
           divgrad2 = divergence(dx2,dy2)- gradient(V2)*[u;v];
           divgrad2 = reshape(divgrad2,[10000, 1]);
     end 
     [t,y] = ode45(@Divgrad2, [0 100], U20);
     subplot(2,2,4);
     
     function outcome = Grady(y,u,v) 
         for t = 1:100 
            arbitrary = gradient(y(t)) + [u;v]; 
            dx3 = arbitrary(1); 
            dy3 = arbitrary(2);
            outcome = [dx3, dy3]; 
         end 
     end 
    [t1,y1] = ode45(@Grady, [0 100], U20);
end 
    
