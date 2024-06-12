function [minIdx, minBeta] = findSequenceNum(Im, L, dx, itmax)
%FINDSEQUENCENUM Summary of this function goes here
%   Detailed explanation goes here
    k1 = 0: 2*pi/L : 2*pi*((Im-1)/2)/L;
    P1 = (sin(k1.*(dx/2.0) + 0.01)).^2;
    P = (2/dx)^2 .* P1;
    
    %legendEntries = cell(itmax, 1);
    %figure;
    
    for it = 1: itmax
        
        N = it;
        
        if (N == 1)
            Pj(1) = 1;
        elseif (N == 2)
            Pj(1) = 1;
            Pj(2) = (2/dx)^2;
        else
            Pj(1) = 1;
            Pj(N) = (2/dx)^2;
            
            for j = 2: N-1
                Pj(j) = (2/dx)^(2*(j-2)/(N-3));
            end
        end
        
        for i = 1: (Im-1)/2+1
            tmp = 1.0;
            for j = 1: N
                betaj(j) = abs(P(i) - Pj(j)) / (P(i) + Pj(j));
                tmp = tmp * betaj(j);
            end
            beta(i) = tmp^(1/N);
        end
        
        %semilogx(P1, beta);
        %xticks([0.001 0.01 0.1 1]);
        %xticklabels({'0.001', '0.01', '0.1', '1.0'});
        %hold on;
        %grid on;
        
        % Store the legend entry for this iteration
        %legendEntries{it} = ['It = ' num2str(it)];
        maxBetaI(it) = findMax1D(beta);
    end
    
    % Set the legend with all entries
    %legend(legendEntries, 'Location', 'southeast');
    %hold off;
    
    % Find the N value corresponds the min beta
    minBeta = 100000.0;
    for it = 4: itmax
       if (maxBetaI(it) < minBeta)
           minBeta = maxBetaI(it);
           minIdx = it;
       end
    end
    
end

