function [Tx] = BPSK(code_list, Tx_power, carrier_freq, time_slot)
    %% BPSK
    Tx = [];
    %Power = 10^(Tx_power/10);
    for i = 1:size(code_list, 1)
        code = code_list(i, :);
        % 升頻 & phase shift
        Tx_each = cos(2*pi*carrier_freq*time_slot+pi*(1-code)); 
        Tx = [Tx; Tx_each];    %發射訊號分別記錄
    end

    %% print
    %{
    % sampling with small time(for display)
    sampling_freq = 1e10;
    time = 0 : 1.0/sampling_freq : chip_duration;
    time = time(1:end-1);
    times = sampling_freq/chip_rate;
     
    
    % plot phase code
    figure;
    subplot(2, 1, 1), plot(time_slot, RF_all);
    xlim([0, 5e-7]);
    ylim([-1.2, 1.2]);
    xlabel("time");
    ylabel("magnitude");
    title("phase code");

    % plot RF signal(for diplay)
    Code = repelem(code_list(1, :), times);
    rf = cos(2*pi*carrier_freq*time+pi*(1-Code));
    subplot(2, 1, 2), plot(time, rf);
    xlim([0, 5e-8]);
    ylim([-1.2, 1.2]);
    xlabel("time");
    ylabel("magnitude");
    title("RF signal");
    %}
end

%% reference
%https://en.wikipedia.org/wiki/Phase-shift_keying
