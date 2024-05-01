close 
clc
clear all

%---------------parameters--------------------
global Im Jm
global xp yp
global xc yc xc_ghost yc_ghost
global T_ghost

Im = 101;
Jm = 101;

%---------------grids-------------------------
xp = zeros(Im,Jm);
yp = zeros(Im,Jm);

xc = zeros(Im-1,Jm-1);
yc = zeros(Im-1,Jm-1);

xc_ghost = zeros(Im+1,Jm+1);
yc_ghost = zeros(Im+1,Jm+1);

dx = 3.0/(Im-1);
dy = 3.0/(Jm-1);

x1 = 0 : dx : 3;
y1 = 0 : dy : 3;

% Grid points
for j = 1: Jm
    for i = 1: Im
        xp(i,j) = x1(i);
        yp(i,j) = y1(j);
    end
end

% Grid cells 
for j = 1: Jm-1
    for i = 1: Im-1
        xc(i,j) = (xp(i,j)+xp(i+1,j))/2.0;
        yc(i,j) = (yp(i,j)+yp(i,j+1))/2.0;
    end
end

% Grid cells with one layer ghost cells
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
T_ghost = zeros(Im+1,Jm+1);

for j = 2: Jm
    for i = 2: Im
        T_ghost(i,j) = 0.0;
    end
end

% ghost cells
for i = 2: Im
    T_ghost(i,1)    = 20;
    T_ghost(i,Jm+1) = 100;
end

for j = 2: Jm
    T_ghost(1,j)    = 100;
    T_ghost(Im+1,j) = 100;
end

% corner cells
T_ghost(1,1)       = (T_ghost(2,1)+T_ghost(1,2))/2.0;
T_ghost(Im+1,1)    = (T_ghost(Im,1)+T_ghost(Im+1,2))/2.0;
T_ghost(1,Jm+1)    = (T_ghost(1,Jm)+T_ghost(2,Jm+1))/2.0;
T_ghost(Im+1,Jm+1) = (T_ghost(Im,Jm+1)+T_ghost(Im+1,Jm))/2.0;

%--------------Heat conduction---------------------------




