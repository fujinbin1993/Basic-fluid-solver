function phi1 = interpolation_1D(x1, x, phi)
%INTERPOLATION_1D Summary of this function goes here
%   Detailed explanation goes here
n = length(x);
m = length(phi);
if n > 1 && n == m
    for i = 1: n-1
        if x1 >= x(i) && x1 <= x(i+1)
            phi1 = phi(i) + (x1-x(i)) * (phi(i+1)-phi(i)) / (x(i+1)-x(i));
        elseif x1 < x(1)                     
            dx = x(1) - x1;
            x2 = x(n-1) - dx;
            phi1 = phi(n-2) + (x2-x(n-2)) * (phi(n-1)-phi(n-2)) / (x(n-1)-x(n-2));
        elseif x1 > x(n)
            dx = x1 - x(n);
            x2 = x(2) + dx;
            phi1 = phi(2) + (x2-x(2)) * (phi(3)-phi(2)) / (x(3)-x(2));
        end
    end
end


