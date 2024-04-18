close
clc
clear all

%---------------parameters--------------------
global Im
global xp 
global xc
global dx
global u

Im=101;
u = 1;

Ermax=1*10^-5;
maxit=200;

%--------------initializing------------------

dx = 1/ (Im-1);
dt = 0.5 * dx;

flag = 0;             % 0: equal-interval, 1: non-equal-interval
alpha = 1.2;

if flag == 0
    for i = 1: Im+2
        xp(i) = -dx + (i-1)*dx;
    end
end
    
% Initial conditions
for i = 2: Im
    xc(i) = ( xp(i) + xp(i+1) ) / 2.0;
    phi(i) = scalar_function(xc(i));
end

% Boundary conditions
xc(1)    = (xp(1)+xp(2)) / 2.0;
xc(Im+1) = (xp(Im+1)+xp(Im+2)) / 2.0;

phi(1)    = phi(Im);
phi(Im+1) = phi(2);

plot(xc, phi);

phi_1 = phi;

for it = 1: maxit
    
    for i = 1: Im+1
        
        xs(i) = xc(i) - u*dt;
        
        if xs(i)/(xp(Im+1)-xp(2)) > 1
            xs_new(i) = xs(i) - floor(xs(i)/(xp(Im+1)-xp(2))) * (xp(Im+1)-xp(2));
        elseif xs(i)/(xp(Im+1)-xp(2)) < 0 && xs(i) < xp(1) 
            xs_new(i) = xs(i) - floor(xs(i)/(xp(Im+1)-xp(2))) * (xp(Im+1)-xp(2));
        else
            xs_new(i) = xs(i);
        end
        
        %if i==33
            phi1(i) = interpolation_1D(xs_new(i), xc, phi_1);
        %end
            
        %phi_1(i) = phi1(i);
       
    end
    
    phi_1 = phi1;
    it;
end
hold on
plot(xc, phi_1);


