function [RF] = demodulator(signal, carrier_freq, time_slot)
    RF = [];
    for i = 1:size(signal, 1)
        rf = signal(i, :).*cos((-2)*pi*carrier_freq*time_slot); % ­°ÀW
        RF = [RF; rf];
    end
end