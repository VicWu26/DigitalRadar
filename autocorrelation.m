function [mainlobe, max_sidelobe] = autocorrelation(RF_all)
    %% autocorrelation
    [cross,lags] = xcorr(RF_all);
    cross = abs(cross);
    %cross_dB = cross/max(cross);
    cross_dB = 10*log10(cross/max(cross));  % to dB
    %% autocorrelation information
    sort_cross = sort(cross);
    mainlobe = sort_cross(end); % mainlobe
    max_sidelobe = sort_cross(end-1);   % caculate max sidelobe (PSL)
    sum_sidelobe = sum(sort_cross(1:end-1));    % caculate average sidelobe
    square_cross = sort_cross.^2;
    MF = length(sort_cross)^2/sum(square_cross(end-1));
    fprintf("-----Autocorrelation information-----\n");
    fprintf("peak %d\n", mainlobe);
    fprintf("max sidelobe %d\n", max_sidelobe);
    fprintf("max sidelobe %d(dB)\n",10*log(mainlobe/max_sidelobe));
    fprintf("average sidelobe %d\n", sum_sidelobe/(length(sort_cross)-1));
    fprintf("MF %d\n", MF);
    %% plot
    %{
    figure;
    %subplot(1, 2, 1), plot(lags,cross);
    plot(lags,cross, 'LineWidth', 1.5);
    %ylim([0, 250]);
    xlabel("delay");
    ylabel("magnitude");
    title("Autocorrelation");
    figure;
    %subplot(1, 2, 2), plot(lags,cross_dB);
    plot(lags,cross_dB);
    ylim([-20, 0]);
    xlabel("delay");
    ylabel("magnitude(dB)");
    title("Autocorrelation(dB)");
    %}
end
%% Reference
%Estimation of Sidelobe Level Variations of Phased Codes in Presence of Random Interference for Bistatic Wideband Noise Radar
