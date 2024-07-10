function [range_probability_SIC] = Successive_Interference_Cancellation(plot_state, target, space_i, space_j, space_k, target_gain, Tx_each)
    for i = 1:size(target,1)-1
        eval(['space_cube',num2str(i),'=','zeros(space_i, space_j, space_k)',';']);
        eval(['space_cube',num2str(i),'=','target_in_space(space_cube',num2str(i),', target(',num2str(i),',:), target_gain)',';']);
        eval(['Rx_',num2str(i),'=','channel(Tx_each, antenna_gain, space_cube',num2str(i),', space_i, space_j, space_k, Tx_num, Rx_num, code_length, chip_rate, carrier_freq)',';']);
        %Rx_SIC1 = Rx_each - Rx_1;
        if i == 1
            eval(['Rx_SIC',num2str(i),'=','Rx_each - Rx_',num2str(i),';']);
        else
            eval(['Rx_SIC',num2str(i),'=','Rx_SIC',num2str(i-1),' - Rx_',num2str(i),';']);
        end
        eval(['Rx_',num2str(i),'=','channel(Tx_each, antenna_gain, space_cube',num2str(i),', space_i, space_j, space_k, Tx_num, Rx_num, code_length, chip_rate, carrier_freq)',';']); 
%       eval(['range_lags, MF_result_SIC',num2str(i),'=','matched_filter(plot_state, Tx_each, Rx_SIC',num2str(i),', Tx_num, Rx_num, chip_rate, code_length, c)',';']);
        eval(['MF_result_SIC',num2str(i),'=','matched_filter(plot_state, Tx_each, Rx_SIC',num2str(i),', Tx_num, Rx_num, chip_rate, code_length, c)',';']);
        eval(['P_measure_SIC',num2str(i),'=','noise_floor(plot_state, Tx_each, Rx_SIC',num2str(i),', MF_result_SIC',num2str(i),', code_length, carrier_freq, time_slot, antenna_gain_dB, chip_rate)',';']);
        eval(['P_null_SIC',num2str(i),'=','noise_floor_null(plot_state, Tx_each, Rx_SIC',num2str(i),', MF_result_SIC',num2str(i),', code_length, carrier_freq, time_slot, antenna_gain_dB, chip_rate)',';']);
        eval(['range_probability_SIC',num2str(i),'=','target_probability(plot_state, P_measure_SIC',num2str(i),', gamma)',';']);
    end

% Rx_SIC1 = Rx_each - Rx_1;
% Rx_SIC2 = Rx_SIC1 - Rx_2;
% [range_lags, MF_result_SIC1] = matched_filter(plot_state, Tx_each, Rx_SIC1, Tx_num, Rx_num, chip_rate, code_length, c);
% [P_measure_add1, P_null_add1] = noise_floor(plot_state, Tx_each, Rx_add1, MF_result_add1, code_length, carrier_freq, time_slot, antenna_gain_dB, chip_rate);
% [range_probability] = target_probability(plot_state, P_measure, range_lags, gamma);
end