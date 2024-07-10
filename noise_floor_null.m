function [P_null] = noise_floor_null(plot_state, Tx, Rx, MF_result, code_length, carrier_freq, time_slot, antenna_gain, chip_rate)
    % MF for test
    %[corr2, ~] = xcorr(Rx(1, :), conj(Tx));
    %MF_test = abs(corr2(code_length:code_length+199));

    %% no target(P_null)
    random_code = randi([0, 1], 1, code_length);
    random_tx = cos(2*pi*carrier_freq*time_slot+pi*(1-random_code));
    [corr, ~] = xcorr(Rx(1, :), conj(random_tx));
 
    P_null = abs(corr(code_length:code_length+199)).^2;
end