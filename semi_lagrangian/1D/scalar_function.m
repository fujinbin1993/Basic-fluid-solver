function phi = scalar_function(xi)
%SCALAR_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
if xi >= 0.25 && xi <= 0.5
    phi = sin(4*pi*(xi-0.25));
elseif xi >= 0.6 && xi <= 0.8
    phi = 1.0;
else
    phi = 0.0;
end

