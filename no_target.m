function no_target(Rx, MF_result, code_length, range_lags, times, carrier_freq, time_slot)
    %% random sequence
    avg_noise = zeros(1, code_length);
    for i = 1:times
        code = randi([0, 1], 1, code_length);
        tx = cos(2*pi*carrier_freq*time_slot+pi*(1-code));
        [temp_cross, ~] = xcorr(Rx(1, :), conj(tx));
        avg_noise = avg_noise + temp_cross(code_length:end);
    end
    MF_noise = 3.5*abs(avg_noise/times).^2 + 1.5e-6;
    %% MF
    MF_avg = abs(mean(MF_result));
    %% plot
    fprintf("R * S average power = %f\nR * S_{random} average power = %f\n", mean(MF_noise(1:300)), mean(MF_avg(1:300)));
    figure; grid on; hold on;
    plot(range_lags, MF_noise, 'Color', "red", 'LineWidth', 1.5);
    plot(range_lags, MF_avg, 'Color', "blue", 'LineWidth', 1.5);  % (noise*random_signal)^2
    xlim([0 200]);
    xlabel("targets range(m)")
    ylabel("power");
    legend("R * S_{t}", "R * S_{t} (no target)")
    title("matched filter(in no target) & noise power");
end