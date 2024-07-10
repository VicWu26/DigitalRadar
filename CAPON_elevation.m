function [capon_normalized] = CAPON_elevation(plot_state, X, N, angle_axis)
    %% CAPON
    derad = pi/180;     % 角度轉弧度
    dd = 0.5;           % 接收端間距
%     array = linspace(0,120,121);
    d = 0:dd:(N-1)*dd; 
    K = (length(X))/2;
    % 計算協方差矩陣
    Rxx = X*X';
%     R_ss = spsmooth(Rxx,K);
    % QR分解
    [Q11,R11] = qr(Rxx);
    R1 = pinv(R11);
%     [EV, D] = eig(Rxx);
%     EVA = diag(D)';
%     [~, I] = sort(EVA);
%     EV = fliplr(EV(:, I));
    Pcapon = zeros(1, length(angle_axis));
    % 計算角度
    for index = 1:length(angle_axis)
        %phim = derad*angle(iang);
        a = exp(-1i*2*pi*d*sin(derad*angle_axis(index))).';
%         a = exp(-1i*2*pi*dd*sind(angle_axis(index)).*array); 
%         En = EV(:, M+1:N);
%         Pmusic(index) = 1/(a'*En*En'*a);
        Pcapon(index) = 1/(a'*R1*a);
%         Pcapon(index) = 1/(abs(a*R1*a')); 
    end
    %% print information
    if plot_state
        demo_CAPON = abs(Pcapon);
        sort_CAPON = sort(demo_CAPON);
        % mainlobe
        mainlobe = max(demo_CAPON);
        MF_dB = 10*log10(demo_CAPON/mainlobe);
        MF_sort_dB = sort(MF_dB);
        % caculate sidelobe
        mean_sidelobe = mean(sort_CAPON(1:end-2));
        fprintf("-----CAPON information-----\n");
        %fprintf("peak %d\n", mainlobe);
        %fprintf("max sidelobe %d\n", max_sidelobe);
        fprintf("max sidelobe %d (dB)\n", (-1)*MF_sort_dB(end-1));
        fprintf("average sidelobe %d (dB)\n", 10*log10(mainlobe/mean_sidelobe));
    end
    %% plot
    Plot_capon = abs(Pcapon);
%     Pmmax = max(Plot_capon);
%     Plot_capon_dB = 20*log10(Plot_capon/Pmmax);
    Plot_capon_dB = 20*log10(Plot_capon./max(Plot_capon));
    normalized_scale = 53;
    Plot_capon_temp = Plot_capon_dB + normalized_scale;
    Plot_capon_temp(Plot_capon_temp < 0) = 0;
    capon_normalized = abs(Plot_capon_temp/normalized_scale);
    if plot_state
        figure; grid on; hold on;
        subplot(2, 1, 1), plot(angle_axis, Plot_capon_dB, "Linewidth", 1.5);
        xlabel("AOA(degree)");
        ylabel("(dB)");
        ylim([-40 0]);
        xlim([0 30]);
        subplot(2, 1, 2), plot(angle_axis, capon_normalized, "Linewidth", 1.5);
        xlabel("AOA(degree)");
        ylabel("target probabilty");
        ylim([0 1]);
        xlim([0 30]);
        title("CAPON(target probabilty)");
        % saveas(gcf,'PMIMO_unequal_CAPON','jpeg');
    end
end