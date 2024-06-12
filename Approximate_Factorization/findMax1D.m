function max = findMax1D(T)
%FINDMAX Summary of this function goes here
%   Detailed explanation goes here

max = 0.0;
N = length(T);

for i = 3: N
    if (T(i)>max)
        max = T(i);
    end
end
    
end

