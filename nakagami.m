% this code is written by Jamal A. Hussein
% barznjy79@yahoo.com
% all rights reserved

clc; clear all; close all;
%% init
colors=['r','g','b'] ;
m = 1;
r = 0:0.1:20;
Omega = [1, 5, 10];
%% reference
%{
for omega = 1:3
    for r = 1:length(x)
        %y(ii)=((2*m^m)/(gamma(m)*w^m))*x(ii)^(2*m-1)*exp(-((m/w)*x(ii)^2));
        
    end
    plot(x,y,colors(w))
    hold on

end
%}
%% Wang's paper(PDF)
%{
for i = 1:3
    omega = Omega(i);
    p = (m/omega).^m * (r.^(m-1))/gamma(m) .* exp(-1*m*r/omega);
    plot(r, p ,colors(i), 'LineWidth', 1.5);
    hold on
end
%}
%% Wang's paper(CDF)
%{
for i = 1:3
    omega = Omega(i);
    F = 1/gamma(m) .* gammainc(m*r/omega, m);
    %F = (m/omega).^m * (r.^(m-1))/gamma(m) .* exp(-1*m*r/omega);
    plot(r, F ,colors(i), 'LineWidth', 1.5);
    hold on
end
xlabel('Received SNR'); 
ylabel('CDF'); 
title('Cumulative Distribution Function')
hleg1 = legend('average SNR = 1','average SNR = 2','average SNR = 3');
set(hleg1,'Location','SouthEast')
axis([5 20 0 1.1]);
grid on 
%}
omega = 10;
P = zeros(length(r)-1);
F = 1/gamma(m) .* gammainc(m*r/omega, m);
for i = 1:length(r)-1
    P(i) = F(i+1)-F(i);
end
figure;
plot(r(1:end-1), P, 'LineWidth', 1.5);
xlabel('Received SNR'); 
ylabel('CDF'); 
title('Cumulative Distribution Function')
grid on;
figure;
plot(r, F, 'LineWidth', 1.5);
xlabel('Received SNR'); 
ylabel('Pr'); 
title('Cumulative Distribution Function')
grid on;



