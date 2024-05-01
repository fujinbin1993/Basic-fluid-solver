close
clc
clear all

m = 3;

a = zeros(m,m);
b = zeros(m,1);
for i = 1: m
    a(i,i) = 2.04;
    if i==1
        a(1,2) = -1;
    elseif i>1 && i<m
        a(i,i-1) = -1;
        a(i,i+1) = -1;
    elseif i==m
        a(m,m-1) = -1;
    end
    b(1,1) = 48.8;
    b(2,1) = 0.8;
    b(3,1) = 0.8;
end

x = zeros(m,1);
x = Thomas_function(a,b);
       
