function u_star = Thomas_function(LHS,RHS)
%THOMAS_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
Im = length(RHS);
LHS_star = zeros(Im,Im);
LHS_1    = zeros(Im,Im);
RHS_star = zeros(Im,1);
RHS_1    = zeros(Im,1);

u_star   = zeros(Im,1);

for i = 1: Im
    if i==1
        
        LHS_star(1,:) = LHS(1,:)./ LHS(1,1);
        RHS_star(1,1) = RHS(1,1) / LHS(1,1);

        LHS(1,:) = LHS_star(1,:);
        RHS(1,1) = RHS_star(1,1);
    
    elseif i>1 && i<Im 
        
        if  abs(LHS(i,i)) >= abs(LHS(i,i-1)) + abs(LHS(i,i+1))
            
            LHS_1(i,:) = LHS(i,:) - LHS(i-1,:).* LHS(i,i-1);
            RHS_1(i,1) = RHS(i,1) - RHS(i-1,1) * LHS(i,i-1);
            LHS_star(i,:) = LHS_1(i,:)./LHS_1(i,i);
            RHS_star(i,1) = RHS_1(i,1)/LHS_1(i,i);

            LHS(i,:) = LHS_star(i,:);
            RHS(i,1) = RHS_star(i,1);
        
        else
            
            msg = 'Error occured, ||b_i|| >= ||a_i||+||c_i||';
            error(msg)
        
        end
        
    elseif i==Im
        
        LHS_1(Im,:) = LHS(Im,:) - LHS(Im-1,:).* LHS(Im,Im-1);
        RHS_1(Im,1) = RHS(Im,1) - RHS(Im-1,1) * LHS(Im,Im-1);
        LHS_star(Im,:) =  LHS_1(Im,:)/LHS_1(Im,Im);
        RHS_star(Im,1) =  RHS_1(Im,1)/LHS_1(Im,Im);

        LHS(Im,:) = LHS_star(Im,:);
        RHS(Im,1) = RHS_star(Im,1);
        
    end
end

for i = Im: -1: 1
    if i==Im
        u_star(Im,1) = RHS(Im,1);
    else
        u_star(i,1) = RHS(i,1) - LHS(i,i+1) * u_star(i+1,1);
    end
end

