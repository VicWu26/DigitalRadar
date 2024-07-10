function [MF] = matched_filter(plot_state, Tx_each, Rx, Tx_num, Rx_num, chip_rate, code_length, c)
    % 2X2 example [Tx_num*Rx_num X L]
    % [Tx1 Rx1]
    % [Tx1 Rx2]
    % [Tx2 Rx1]
    % [Tx2 Rx2]
    MF = zeros(Tx_num*Rx_num, 200);
    for i = 1:Tx_num
        for j = 1:Rx_num
            index = (i-1)*Rx_num+j;
            [cross, ~] = xcorr(Rx(j, :), conj(Tx_each(i,:)));
            % 取200點(200公尺，根據想觀察的距離範圍調整)
            MF(index, :) = cross(code_length:code_length+199); % 取距離為正的區塊
            %MF(index, :) = cross(1:code_length-1) + cross(code_length+1:end);
        end
    end
    index_lags = 0:199;
    range_lags = (index_lags)*c/(2*chip_rate); % change index shift into real target range(for demo)    

    %% print information(get average for demo)
    if plot_state
        matched_filter_display(MF(1, :), range_lags);
        %matched_filter_display(mean(MF), range_lags);
    end    
end