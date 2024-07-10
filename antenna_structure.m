function [Rx_each] = antenna_structure(Tx_each, Tx_num, Rx_num, code_length, target_info)
    targets_num = size(target_info, 1);
    %% caculate phase
    Rx_each = zeros(Tx_num*Rx_num, code_length);
    S = repmat(Tx_each, Rx_num, 1);
    d = 0.5; %天線之間的間隔(lamda)
    distance = 0:d:(Tx_num*Rx_num-1)*d;
    A = exp(-1i*2*pi*d.'*sin(theta*derad));
    %% print antenna structure
      
end