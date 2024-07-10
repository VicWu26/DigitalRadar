function [theta_input, phi_input] = decide_input_matrix(MF_result, Tx_num, Rx_num)
    theta_input = MF_result((1:Rx_num), :);
    phi_input = [];
    for i = 1:(Tx_num)
        phi_input = [phi_input; MF_result((Tx_num-i)*Rx_num+1, :)];
    end
end