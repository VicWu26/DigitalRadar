close all;  clear all;  clc;

%% simultion for different gamma(x:gamma, y:Pr, z:target distence)
gamma = 2:0.5:10;

% ----------targets exist probability----------
% P_measure     10m:292
%               20m:289
%               40m:314
%               80m:295
%               100m:305
figure; grid on; hold on;
test1 = exp((-1) * gamma ./ (1+828));
test2 = exp((-1) * gamma ./ (1+280));
test3 = exp((-1) * gamma ./ (1+93));
test4 = exp((-1) * gamma ./ (1+31));
test5 = exp((-1) * gamma ./ (1+16));
%test6 = exp((-1) * gamma ./ (1+55));
%test7= exp((-1) * gamma ./ (1+5));
figure; grid on; hold on;
plot(gamma, test1, "-o", gamma, test2, "-o", gamma, test3, "-o", gamma, test4...
    , "-o", gamma, test5, "-o", 'LineWidth', 1.5);
%plot(gamma, test1, "-o", gamma, test2, "-o", gamma, test3, "-o", 'LineWidth', 1.5);
ylim([0 1]);
xlabel("\gamma");     ylabel("targets probability");
legend("target:10m", "target:20m", "target:40m", "target:80m", "target:100m");
%{
figure; grid on; hold on;
plot(gamma, test1-test2, "-o", gamma, test3-test4, "-o", gamma, test5-test6, "-o", gamma, test7-test8, "-o", 'LineWidth', 1.5);
xlabel("\gamma");     ylabel("targets probability different");
legend("target:5m~10m", "target:11m~20m", "target:21m~40m", "target:41m~80m");
ylim([0 0.2]);
%}
%{
% ----------targets not exist probability----------
% P_null        10m:1.14
%               20m:0.93
%               40m:1.12
%               80m:1.22
%               100m:1.11
figure; grid on; hold on;
testno10 = exp((-1) * gamma ./ (1+1.14));
testno20 = exp((-1) * gamma ./ (1+0.93));
testno40 = exp((-1) * gamma ./ (1+1.12));
testno80 = exp((-1) * gamma ./ (1+1.22));
testno100 = exp((-1) * gamma ./ (1+1.11));
plot(gamma, testno10, "-o", gamma, testno20, "-o", gamma, testno40, "-o", gamma, testno80, "-o", gamma, testno100, "-o", 'LineWidth', 1.5);
ylim([0 1]);
xlabel("\gamma");     ylabel("targets probability");
legend("target:10m", "target:20m", "target:40m", "target:80m", "target:100m");
%}
% ----------targets exist probability miss detection----------
MD10 = [0.008, 0.009, 0.012, 0.014, 0.015, 0.018, 0.019, 0.021, 0.023, 0.025, 0.027, 0.029, 0.031, 0.033, 0.035, 0.036, 0.038];
MD20 = [0.008, 0.01, 0.012, 0.014, 0.016, 0.017, 0.019, 0.021, 0.023, 0.025, 0.027, 0.029, 0.030, 0.033, 0.035, 0.036, 0.039];
