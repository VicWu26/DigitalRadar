close all;  clear all;  clc;
len = 50;
code = randi([0,1], 1, len);
code(code==0) = -1;
signal = circshift(code,3)+circshift(code,6);
[receiver] = awgn(signal, 10);
[cross, lag] = xcorr(receiver, code);
alpha = [1.5 2 3.5]; % weight coefficient
N = 6; % compare range for each CFAR
P_fa = 1-((1+alpha/N).^(-1*N))
P_target = zeros(1, len);
threshold = zeros(length(alpha), len);
cross = abs(cross);
for i = 1:length(alpha)
    count = 0;
    for j = 1:length(cross)
        MIN = max(1, j-floor(N/2));
        MAX = min(j+floor(N/2), length(cross));
        %fprintf("%d, %d, %d, %d, %d\n", j, MIN, MAX, sum(cross(MIN:MAX)), cross(j));
        num = MAX - MIN + 1; 
        threshold(i, j) = alpha(i)*( sum(cross(MIN:MAX)) - cross(j) )/(num-1);
    end
end

figure;
hold on;
plot(lag, cross, 'LineWidth', 1.5);
plot(lag, threshold(1, :), "--green", 'LineWidth', 1.5);
plot(lag, threshold(3, :), "--red", 'LineWidth', 1.5);
legend("origin data", "detection probabilty 73%", "detection probabilty 94%");
ylabel("magnitude");
xlim([-15, 15]);
