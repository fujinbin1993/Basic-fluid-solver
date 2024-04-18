function us = interpolation_2D(x1, y1, x, y, u)
%INTERPOLATION_2D Summary of this function goes here
%   Detailed explanation goes here
Imx = size(x,1);
Jmx = size(x,2);

Imy = size(y,1);
Jmy = size(y,2);

Imu = size(u,1);
Jmu = size(u,2);

if Imx == Imy && Jmx == Jmy && Imx == Imu && Jmx == Jmu
    Im = Imx;
    Jm = Jmx;

    for i = 1: Im-1
        if x1>=x(i,1) && x1<=x(i+1,1)
            i1 = i;
            i2 = i+1;
            x2 = x1;
        elseif x1<x(1,1)
            i1 = Im-2;
            i2 = Im-1;
            dx = x(1,1)-x1;
            x2 = x(Im-1,1)-dx;
        elseif x1>x(Im,1)
            i1 = 2;
            i2 = 3;
            dx = x1 - x(Im,1);
            x2 = x(2,1) + dx;
        end
    end
        
    for j = 1: Jm-1
        if y1>=y(1,j) && y1<=y(1,j+1)
            j1 = j;
            j2 = j+1;
            y2 = y1;
        elseif y1<y(1,1)
            j1 = Jm-2;
            j2 = Jm-1;
            dy = y(1,1)-y1;
            y2 = y(1,Jm-1)-dy;
        elseif y1>y(1,Jm)
            j1 = 2;
            j2 = 3;
            dy = y1 - y(1,Jm);
            y2 = y(1,2) + dy;
        end
    end
           
    us1 = u(i1,j1) + (x2-x(i1,j1)) * (u(i2,j1)-u(i1,j1)) / (x(i2,j1)-x(i1,j1));
    us2 = u(i1,j2) + (x2-x(i1,j2)) * (u(i2,j2)-u(i1,j2)) / (x(i2,j2)-x(i1,j2));
    
    ys1 = (y(i2,j1) + y(i1,j1))/2.0;
    ys2 = (y(i2,j2) + y(i1,j2))/2.0;
    
    us = us1 + (y2-ys1) * (us2-us1)/(ys2-ys1);
end



