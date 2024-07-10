function [signal_interference] = Interference(SIR, code_length, carrier_freq, chip_rate, time_slot, signal)
% only one antenna interference(test)
    %% interference code
    inter_code = randi([0,1], 1, code_length);
    %% interference power
    power = 10^((-1)*SIR/20); % interference power
    %% interference signal
    interference = power*cos(2*pi*carrier_freq*time_slot).*cos(2*pi*chip_rate*time_slot+pi*(1-inter_code));
    signal_interference = signal + interference;
end
