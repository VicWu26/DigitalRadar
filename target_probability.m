function [probability] = target_probability(plot_state, P_measure, thershold)
    %{
    if plot_state
        %% Probability distribution(CDF plot)
        
        x_dB = -5:0.5:20;
        x = 10.^(x_dB./10);
        CDF1 = exp((-1) * 2 ./ (1+x));
        CDF2 = exp((-1) * 4 ./ (1+x));
        CDF3 = exp((-1) * 6 ./ (1+x));
        CDF4 = exp((-1) * 8 ./ (1+x));
        CDF5 = exp((-1) * 10 ./ (1+x));
        figure; grid on; hold on;
        plot(x_dB, CDF1, x_dB, CDF2, x_dB, CDF3, x_dB, CDF4, x_dB, CDF5, 'LineWidth', 1.5);
        ylim([0 1]);
        xlabel("P_{measure} / P_{null} (dB)");     ylabel("targets probability");
        legend("\gamma = 2", "\gamma = 4", "\gamma = 6", "\gamma = 8", "\gamma = 10");

        figure; grid on; hold on;
        plot(range_lags, (1+P_measure(1, :)), 'LineWidth', 1.5);
        yline(2, 'LineWidth', 1.5, 'color', 'red');
        yline(4, 'LineWidth', 1.5, 'color', 'green');
        yline(6, 'LineWidth', 1.5, 'color', 'cyan');
        yline(8, 'LineWidth', 1.5, 'color', 'blue');
        yline(10, 'LineWidth', 1.5, 'color', 'magenta');
        xlim([0 100]);
        ylim([0 50]);
        xlabel("targets range(m)");    ylabel("P_{measure} / P_{null}");    
    end
    %}
    %% target probability
    % step function test
    %{
    status(P_measure(1, :) < thershold) = 0;
    status(status > thershold) = 1;
    figure; grid on; hold on;
    plot(range_lags, status, 'LineWidth', 1.5);
    xlim([0 100]);
    ylim([0 1]);
    xlabel("targets range(m)");    ylabel("targets probability");
    title("targets probability");
    %}
    
    gamma = thershold*ones(1, length(P_measure));
    
    %gamma(12) = 5;gamma(13) = 4.5;gamma(14) = 3;gamma(15) = 3;gamma(16:end) = 2.2;
    probability = round(exp((-1) .* gamma ./ (1+P_measure)), 3);
    
    % per probability
    %{
    if plot_state
        % plot probability(dot display)
        

        figure; grid on; hold on;
        plot(range_lags, probability(1, :), 'LineWidth', 1.5);
        %xlim([0 100]);
        %ylim([0 1]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("targets probability");
        
        % plot probability(cube colormap display)
        figure; grid on; hold on;
        bar(probability(1, 2:51), 1);
        set(gca, "XTick", 0.5:1:50.5);
        ylim([0 1]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("targets probability");

        figure; grid on; hold on;
        plot(range_lags, 10*log10(P_measure(1, :)), 'LineWidth', 1.5);
        xlim([0 100]);
        %ylim([0 1]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("P_{measure}");
    end
    %}
    %% union probability

    if plot_state
        figure; grid on; hold on;
        bar(probability, 1);%
        set(gca, "XTick", 0.5:1:50.5);
        ylim([0 1]);
        % xlim([0 50]);
        xlim([50 100]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("targets probability");
%      if plot_state
%         figure; grid on; hold on;
%         bar(probability, 1);%
%         set(gca, "XTick", 0.5:1:50.5);
%         ylim([0 1]);
%         xlim([0 50]);
%         xlabel("targets range(m)");    ylabel("targets probability");
%         title("targets probability");

        % saveas(gcf,'PMIMO_unequal_target','jpeg');
        %{
        figure; grid on; hold on;
        ylim([0 1]);
        subplot(3, 1, 1), plot(range_lags, union_probability_mean, 'LineWidth', 1.5);
        xlim([0 30]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("union probability Mean");
        subplot(3, 1, 2), plot(range_lags, union_probability_AND, 'LineWidth', 1.5);
        xlim([0 100]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("union probability AND");
        subplot(3, 1, 3), plot(range_lags, union_probability_OR, 'LineWidth', 1.5);
        xlim([0 100]);
        xlabel("targets range(m)");    ylabel("targets probability");
        title("union probability OR");  
        %}
    end
end