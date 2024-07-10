function [Tx_list, Tx_mix] = modulation(code_list, code_length, code_pair, carrier_freq, time_slot)
    Tx_mix = zeros(1, code_length); % �V�X�T��
    Tx_list = [];   %�C�ӵo�g�ݰT�����}
    for i = 1:code_pair
        code = code_list(i, :);
        Tx = cos(2*pi*carrier_freq*time_slot+pi*(1-code)); % ���W & phase shift
        Tx_mix = Tx_mix + Tx;
    end
    Tx_list = [Tx_list;Tx];
end