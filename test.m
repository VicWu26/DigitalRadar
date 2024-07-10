close all;  clear all;  clc;

code_length = 2000:500:20000;
times = 300;

%% SISO sidelobe simulation

upper_bond = zeros(1, length(code_length))-1000;
avg_sidelobe = zeros(1, length(code_length));
for j = 1:length(code_length)
    temp = 0;
    for i = 1:times
        code = randi([0,1], 1, code_length(j));
        code(code == 0) = -1;
        [correlation, ~] = xcorr(code);
        sidelobe = mean(abs(correlation(code_length(j)+1:code_length(j)+1600)));

        sidelobe_dB = 10*log10(sidelobe/max(correlation));
        
        upper_bond(j) = max(upper_bond(j), sidelobe_dB);

        temp = temp + sidelobe;
    end

    avg_sidelobe(j) = 10*log10(temp/(code_length(j)*times));
end

theory_sidelobe = sqrt(code_length.*log10(log10(2*code_length)))./code_length;
theory_sidelobe_dB = 10*log10(theory_sidelobe);
figure;
hold on;grid on;
plot(code_length, abs(avg_sidelobe), ...
    code_length, abs(upper_bond), '--', ...
    code_length, abs(theory_sidelobe_dB)-0.07, 'LineWidth', 1.5);

xlabel("code length"); ylabel("processing gain");
legend("simulation sidelobe(SISO)", "simulation sidelobe upper bond(SISO)", "upper bond From paper");
xlim([4000, 20000]);


%% MIMO sidelobe simulation

MIMO_stucture = [4, 8, 16, 32, 64];

MIMO_per_sidelobe = zeros(1, length(code_length));
MIMO_per_corr_sidelobe = zeros(1, length(code_length));
figure;
hold on;grid on;
plot(code_length, abs(avg_sidelobe), 'LineWidth', 1.5);

xlabel("code length"); ylabel("processing gain");
xlim([4000, 20000]);
for i = 1:length(MIMO_stucture)
    MIMO_sidelobe = zeros(1, length(code_length));
    for j = 1:length(code_length)
        code = randi([0,1], MIMO_stucture(i), code_length(j));
        code(code == 0) = -1;
        code = code/MIMO_stucture(i);
        sum_code = sum(code);
        temp = 0;

        for k = 1:times
            [correlation, ~] = xcorr(code(1, :), sum_code);
            sidelobe = mean(abs(correlation(code_length(j)+1:code_length(j)+1600)));
            
            sidelobe_dB = 10*log10(correlation(code_length(j))/sidelobe);
            temp = temp + sidelobe_dB;
        end
        MIMO_sidelobe(j) = temp/times;
    end
    plot(code_length, MIMO_sidelobe, 'LineWidth', 1.5);
end




% 
%{
i = [2, 15; 6, 10];
figure;
heatmap(i);

x = 0:0.05:5;
figure;
hold on;grid on;
plot(x, 0.5*exp(-0.5*x), 'LineWidth', 1.5);
ylabel("f(x)"); xlabel("x"); 
title("Probability Density Function(PDF)");

figure;
hold on;grid on;
plot(x, 1-exp(-0.5*x), 'LineWidth', 1.5);
ylabel("F(x)"); xlabel("x"); 
title("Cumulative Distribution Function(CDF)");
%}

