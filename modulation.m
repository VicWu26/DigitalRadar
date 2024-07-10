function [Tx_list, Tx_mix] = modulation(code_list, code_length, code_pair, carrier_freq, time_slot)
    Tx_mix = zeros(1, code_length); % 混合訊號
    Tx_list = [];   %每個發射端訊號分開
    for i = 1:code_pair
        code = code_list(i, :);
        Tx = cos(2*pi*carrier_freq*time_slot+pi*(1-code)); % 升頻 & phase shift
        Tx_mix = Tx_mix + Tx;
    end
    Tx_list = [Tx_list;Tx];
end