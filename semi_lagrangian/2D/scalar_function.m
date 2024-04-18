function u = scalar_function(x,y)
%SCALAR_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
if (x>=0.1 && x<=0.5)  && (y>=0.23 && y <=0.37)
    u = 1.0;
elseif (x>=0.23 && x<=0.37) && (y>=0.1 && y<=0.5)
    u = 1.0;
else
    u = 0.0;
end

