function matched_filter_display(input_MF, range_lags)
    MF = abs(input_MF).^2;
    %% caculate information
    sort_MF = sort(MF);
    % mainlobe
    mainlobe = max(MF);
    MF_dB = 10*log10(MF/mainlobe);
    MF_sort_dB = sort(MF_dB);
    % caculate sidelobe
    mean_sidelobe = mean(sort_MF(1:end-1));
    fprintf("-----matched filter information-----\n");
    %fprintf("peak %d\n", mainlobe);
    %fprintf("max sidelobe %d\n", max_sidelobe);
    fprintf("max sidelobe %d (dB)\n", (-1)*MF_sort_dB(end-2));
    fprintf("average sidelobe %d (dB)\n", 10*log10(mainlobe/mean_sidelobe));
    %% plot
    % plot correlation(dot display)
    %{
    figure; grid on; hold on;
    subplot(2, 1, 1), plot(range_lags, MF_dB, 'LineWidth', 1.5);
    xlabel("targets range(m)"); ylabel("power(dB)");
    ylim([-40 0]);
    title("matched filter");
    subplot(2, 1, 2), plot(range_lags, MF, 'LineWidth', 1.5);
    xlabel("targets range(m)"); ylabel("power");
    title("matched filter");
    %}
    % plot correlation(cube colormap display)
    figure; grid on; hold on;
    subplot(2, 1, 1), plot(range_lags, MF, 'LineWidth', 1.5);
    xlabel("targets range(m)"); ylabel("power");
    subplot(2, 1, 2), plot(range_lags, MF_dB, 'LineWidth', 1.5);
    xlim([0 50]);
    xlabel("targets range(m)"); ylabel("power(dB)");
    title("matched filter");
end