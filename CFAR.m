function [CFAR_result] = CFAR(plot_state, MF, P_fa, range_lags)
    
    %% target detection parameter
    MF_power = abs(MF).^2;
    len = length(MF_power);
    front_N = 4;    % compare range for each CFAR
    behind_N = 4;   % compare range for each CFAR
    N = front_N + behind_N;
    %P_fa = 1-((1+alpha/N).^(-1*N));
    alpha = N*(P_fa.^(-1/N)-1); % weight coefficient
    CFAR_threshold = zeros(1, len);
    CFAR_result = zeros(1, len);
    %% print CFAR information

    if plot_state
        fprintf("-----CFAR information-----\n");
        fprintf("threshold factor %d\n", alpha);
        fprintf("false alarm rate %d\n", P_fa*100);
        fprintf("detetced cell range %d\n", N);
    end
    
    %% CA-CFAR
    for i = 1:len
        MIN = max(1, i-front_N);
        MAX = min(len-1, i+behind_N);
        background_average = (sum(MF_power(MIN:MAX))-MF_power(i))/(MAX-MIN);
        CFAR_threshold(i) = alpha*background_average;
        if CFAR_threshold(i) < MF_power(i)
            CFAR_result(i) = 1;
        end
    end
    %% to dB
    CFAR_threshold_dB = 10*log10(CFAR_threshold);
    MF_power_dB = 10*log10(MF_power);
    %% plot
    if plot_state
        figure;
        hold on;    grid on;
        plot(range_lags, MF_power_dB, 'LineWidth', 1.5);
        plot(range_lags, CFAR_threshold_dB, 'LineWidth', 1.5, 'color', 'red');
        xlim([0 50]);
        xlabel("targets range(m)");    ylabel("Power(dB)");
        title("CFAR threshold");

        figure;
        hold on;    grid on;    hold on;
        bar(CFAR_result, 1);
        set(gca, "XTick", 0.5:1:50.5);
        xlim([0 50]);
        xlabel("targets range(m)");    ylabel("Probability");
        title("targets probability (CFAR)");
    end
 
end