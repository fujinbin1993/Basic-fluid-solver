function max = findMax2D(diff_T, Im, Jm)
%FINDMAX Summary of this function goes here
%   Detailed explanation goes here
max = 0.0;
for n = 1: Jm+1
    for m = 1: Im+1
        if (diff_T(m,n) > max)
            max = diff_T(m,n);
        end
    end
end
    
end

