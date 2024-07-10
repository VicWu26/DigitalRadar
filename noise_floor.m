 function [P_measure, P_null] = noise_floor(plot_state, Tx, Rx, MF_result, code_length, carrier_freq, time_slot, antenna_gain, chip_rate)
    % MF for test
    %[corr2, ~] = xcorr(Rx(1, :), conj(Tx));
    %MF_test = abs(corr2(code_length:code_length+199));

    %% no target(P_null)
    random_code = randi([0, 1], 1, code_length);
    random_tx = cos(2*pi*carrier_freq*time_slot+pi*(1-random_code));
    [corr, ~] = xcorr(Rx(1, :), conj(random_tx));
 
    P_null = abs(corr(code_length:code_length+199)).^2;

    avg_P_null = mean(P_null);
    temp = mean(abs(MF_result)).^2;
    P_measure = temp/avg_P_null;
    
    temp_sort = sort(temp,'descend');
    temp_sort(1:4)
    avg_P_null
    temp_sort(1:4)/avg_P_null

    if plot_state
        fprintf("-----------in no targets---------\n");
        fprintf("average power(no target) = %f\n", avg_P_null);
        %fprintf("average power(measure) = %f\n", mean(P_measure));
    end
    
    %measure_SNR = MF_avg/avg_noise;
    %fprintf("R * S average power = %f\nR * S_{random} average power = %f\n", avg_noise, mean(MF_avg(1:300)));
    %{
    figure; grid on; hold on;
    plot(range_lags, MF_avg, 'Color', "blue", 'LineWidth', 1.5);  % (noise*random_signal)^2
    plot(range_lags, MF_noise, 'Color', "red", 'LineWidth', 1.5);
    xlabel("targets range(m)");    ylabel("power");
    legend("measure", "null");
    title("MF in no target comparsion");
    %}
end