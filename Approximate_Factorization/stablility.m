%close 
clc
clear all

nx = 150 * 1.0;
Lx = 3.0;
k1 = 0 : 2*pi/Lx : 2*pi*(nx/2)/Lx;
dx = Lx / nx;
P1 = (sin(k1.*(dx/2.0) + 0.01)).^2;

P = (2/dx)^2 .* P1;

N = 22;
Pj(1) = 1;
Pj(N) = (2/dx)^2;

for j = 2: N-1
    Pj(j) = (2/dx)^(2*(j-2)/(N-3));
end


for i = 1: nx/2+1
    tmp = 1.0;
    for j = 1: N
        betaj(j) = abs(P(i) - Pj(j)) / (P(i) + Pj(j));
        tmp = tmp * betaj(j);
    end
    beta(i) = tmp^(1/N);
end

%figure;
%plot(P1);

%figure;
%plot(P1, beta);
semilogx(P1, beta);
xticks([0.001 0.01 0.1 1]);
xticklabels({'0.001', '0.01', '0.1', '1.0'});
grid on
hold on




