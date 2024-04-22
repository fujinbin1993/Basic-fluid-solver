close 
clc
clear all

%---------------parameters--------------------
global Im Jm
global xp yp 
global xc yc xc_ghost yc_ghost 
global xc1_ghost yc1_ghost xc2_ghost yc2_ghost
global u u_ghost u1 u1_ghost

Im = 201;
Jm = 201;

%---------------grids-------------------------
xp = zeros(Im,Jm);
yp = zeros(Im,Jm);

xc = zeros(Im-1,Jm-1);
yc = zeros(Im-1,Jm-1);

xc1_ghost = zeros(Im+1, Jm+1);
yc1_ghost = zeros(Im+1, Jm+1);

xc2_ghost = zeros(Im+1,Jm+1);
yc2_ghost = zeros(Im+1,Jm+1);

xc_ghost = zeros(Im+1,Jm+1);
yc_ghost = zeros(Im+1,Jm+1);

u        = zeros(Im-1, Jm-1);
u1       = zeros(Im-1, Jm-1);
u_ghost  = zeros(Im+1, Jm+1); 
u1_ghost = zeros(Im+1, Jm+1);

dx = 4.0/(Im-1);
dy = 4.0/(Jm-1);

x1 = 0 : dx : 4;
y1 = 0 : dy : 4;

% Grid point
for j = 1: Jm
    for i = 1: Im
        xp(i,j) = x1(i);
        yp(i,j) = y1(j);
    end
end

% Grid cell 
for j = 1: Jm-1
    for i = 1: Im-1
        xc(i,j) = (xp(i,j)+xp(i+1,j))/2.0;
        yc(i,j) = (yp(i,j)+yp(i,j+1))/2.0;
    end
end

% Grid cell with one layer ghost cells
for j = 2: Jm
    for i = 2: Im
        xc_ghost(i,j) = xc(i-1,j-1);
        yc_ghost(i,j) = yc(i-1,j-1);
    end
end

for j = 2: Jm
    xc_ghost(1,j)    = xc_ghost(2,j)-dx;
    yc_ghost(1,j)    = yc_ghost(2,j);
    
    xc_ghost(Im+1,j) = xc_ghost(Im,j)+dx;
    yc_ghost(Im+1,j) = yc_ghost(Im,j);
end

for i = 2: Im
    xc_ghost(i,1)    = xc_ghost(i,2);
    yc_ghost(i,1)    = yc_ghost(i,2)-dy;
    
    xc_ghost(i,Im+1) = xc_ghost(i,Im);
    yc_ghost(i,Im+1) = yc_ghost(i,Im)+dy;
end

xc_ghost(1,1) = xc_ghost(1,2);
yc_ghost(1,1) = yc_ghost(2,1);

xc_ghost(1,Jm+1) = xc_ghost(1,Jm);
yc_ghost(1,Jm+1) = yc_ghost(2,Jm+1);

xc_ghost(Im+1,1) = xc_ghost(Im+1,2);
yc_ghost(Im+1,1) = yc_ghost(Im,1);

xc_ghost(Im+1,Jm+1) = xc_ghost(Im+1,Jm);
yc_ghost(Im+1,Jm+1) = yc_ghost(Im, Jm+1);

%-------------Initialization-----------------------
for j = 1: Jm-1
    for i = 1: Im-1
        u(i,j) = scalar_function(xc(i,j), yc(i,j));
    end
end

for j = 2: Jm
    for i = 2: Im
        u_ghost(i,j) = u(i-1,j-1);
    end
end

% ghost cells
for i = 2: Im
    u_ghost(i,1)    = u_ghost(i,Jm);
    u_ghost(i,Jm+1) = u_ghost(i,2);
end

for j = 2: Jm
    u_ghost(1,j)    = u_ghost(Im,j);
    u_ghost(Im+1,j) = u_ghost(2,j);
end

% corner cells
u_ghost(1,1)       = u_ghost(Im,Jm);
u_ghost(Im+1,1)    = u_ghost(2,Jm);
u_ghost(1,Jm+1)    = u_ghost(Im,2);
u_ghost(Im+1,Jm+1) = u_ghost(2,2);

%--------------Advection---------------------------
a = 1;
b = 1;
dt = 0.5*max(dx,dy);
maxit = 400;

for it  = 1: maxit
    for j = 1: Jm+1
        for i = 1: Im+1
            xc1_ghost(i,j) = xc_ghost(i,j) - a * dt;
            yc1_ghost(i,j) = yc_ghost(i,j) - b * dt;
        
            if xc1_ghost(i,j)/(xp(Im,1)-xp(1,1)) > 1
                xc2_ghost(i,j) = xc1_ghost(i,j) - floor(xc1_ghost(i,j)/(xp(Im,1)-xp(1,1))) * (xp(Im,1)-xp(1,1));
            elseif xc1_ghost(i,j)/(xp(Im,1)-xp(1,1)) < 0 && xc1_ghost(i,j) < xp(1,1)-dx
                xc2_ghost(i,j) = xc1_ghost(i,j) - floor(xc1_ghost(i,j)/(xp(Im,1)-xp(1,1))) * (xp(Im,1)-xp(1,1));
            elseif yc1_ghost(i,j)/(yp(1,Jm)-yp(1,1)) > 1
                yc2_ghost(i,j) = yc1_ghost(i,j) - floor(yc1_ghost(i,j)/(yp(1,Jm)-yp(1,1))) * (yp(1,Jm)-yp(1,1));
            elseif yc1_ghost(i,j)/(yp(1,Jm)-yp(1,1)) < 0 && yc1_ghost(i,j) < yp(1,1)-dy
                yc2_ghost(i,j) = yc1_ghost(i,j) - floor(yc1_ghost(i,j)/(yp(1,Jm)-yp(1,1))) * (yp(1,Jm)-yp(1,1));
            else
                xc2_ghost(i,j) = xc1_ghost(i,j);
                yc2_ghost(i,j) = yc1_ghost(i,j);
            end
        
            u1_ghost(i,j) = interpolation_2D(xc2_ghost(i,j), yc2_ghost(i,j), xc_ghost, yc_ghost, u_ghost);
        end
    end
    u_ghost = u1_ghost;
    it
end

%-------------------Output--------------------------
file_o1 = strcat('mesh_initial.dat');
fid = fopen(file_o1,'w');

fprintf(fid, 'TITLE = "2D mesh with initial value"\n');
fprintf(fid, 'VARIABLES = "X" "Y" "scalar"\n');
fprintf(fid, 'ZONE I=%d, J=%d, F=POINT\n', Im-1, Jm-1);

% Write data in point format
for j = 1:Jm-1
    for i = 1:Im-1
        fprintf(fid, '%g %g %g\n', xc(i,j), yc(i,j), u(i,j));
    end
end

% Close the file
fclose(fid);

%-------------------Output--------------------------
file_o1 = strcat('mesh_final.dat');
fid = fopen(file_o1,'w');

fprintf(fid, 'TITLE = "2D mesh with final value"\n');
fprintf(fid, 'VARIABLES = "X" "Y" "scalar"\n');
fprintf(fid, 'ZONE I=%d, J=%d, F=POINT\n', Im-1, Jm-1);

% Write data in point format
for j = 1:Jm-1
    for i = 1:Im-1
        fprintf(fid, '%g %g %g\n', xc_ghost(i+1,j+1), yc_ghost(i+1,j+1), u_ghost(i+1,j+1));
    end
end

% Close the file
fclose(fid);










