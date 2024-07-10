close all;  clear all;  clc;

chip_rate = 500e6;      % 1/chip_rate is chip duration
carrier_freq = 79e9;  
c = 3e8;                % light speed

code_length = 2047; % 編碼長度
chip_duration = code_length/chip_rate; % 一組編碼的時間
time_slot = 0 : 1.0/chip_rate : chip_duration;
time_slot = time_slot(1:end-1);
time = 0 : 1.0/1e10 : chip_duration;
time = time(1:end-1);

sum_side = 0;
times = 10;
for i = 1:times    
    [code_list] = code_generator(code_length);
    [RF_each, RF_all] = BPSK(code_list, code_length, 1, carrier_freq, time_slot, time);
    [mainlobe, max_sidelobe] = autocorrelation(RF_all);
    sum_side = sum_side + max_sidelobe;
end
fprintf("average %.2d\n", sum_side/times);