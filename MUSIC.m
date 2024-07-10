function [music_normalized] = MUSIC(plot_state, X, M, N, angle_axis)
    %% MUSIC
    derad = pi/180;     % 角度轉弧度
    dd = 0.5;           % 接收端間距
    d = 0:dd:(N-1)*dd; 
    K = length(X);
    % 計算協方差矩陣
    Rxx = X*X'/K;
    % 特徵值分解
    [EV, D] = eig(Rxx);
    EVA = diag(D)';
    [~, I] = sort(EVA);
    EV = fliplr(EV(:, I));
    Pmusic = zeros(1, length(angle_axis));
    % 計算角度
    for index = 1:length(angle_axis)
        %phim = derad*angle(iang);
        a = exp(1i*2*pi*d*sin(derad*angle_axis(index))).';
        En = EV(:, M+1:N);
        Pmusic(index) = 1/(a'*En*En'*a);
    end
    %% print information
    if plot_state
        demo_MUSIC = abs(Pmusic);
        sort_MUSIC = sort(demo_MUSIC);
        % mainlobe
        mainlobe = max(demo_MUSIC);
        MF_dB = 10*log10(demo_MUSIC/mainlobe);
        MF_sort_dB = sort(MF_dB);
        % caculate sidelobe
        mean_sidelobe = mean(sort_MUSIC(1:end-2));
        fprintf("-----MUSIC information-----\n");
        %fprintf("peak %d\n", mainlobe);
        %fprintf("max sidelobe %d\n", max_sidelobe);
        fprintf("max sidelobe %d (dB)\n", (-1)*MF_sort_dB(end-1));
        fprintf("average sidelobe %d (dB)\n", 10*log10(mainlobe/mean_sidelobe));
    end
    %% plot
    Plot_music = abs(Pmusic);
    Pmmax = max(Plot_music);
    Plot_music_dB = 10*log10(Plot_music/Pmmax);
    
    normalized_scale = 40;
    Plot_music_temp = Plot_music_dB + normalized_scale;
    Plot_music_temp(Plot_music_temp < 0) = 0;
    music_normalized = abs(Plot_music_temp/normalized_scale);
    if plot_state
        figure; grid on; hold on;
        subplot(2, 1, 1), plot(angle_axis, Plot_music_dB, "Linewidth", 1.5);
        xlabel("AOA(degree)");
        ylabel("(dB)");
        ylim([-40 0]);
        xlim([-30 30]);
        subplot(2, 1, 2), plot(angle_axis, music_normalized, "Linewidth", 1.5);
        xlabel("AOA(degree)");
        ylabel("target probabilty");
        ylim([0 1]);
        xlim([-30 30]);
        title("MUSIC(target probabilty)");
        % saveas(gcf,'MUSIC','jpeg');
    end
end

% https://www.twblogs.net/a/5cd9882ebd9eee67a77fb444