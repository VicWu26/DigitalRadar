function [Rx_each] = delay(RF_each, RF_all, code_length, target_info, time_slot, Tx_num, Rx_num, chip_rate, c)
    %% parameter
    targets_num = size(target_info, 1);
    Tx_all = zeros(1, code_length);
    Rx_each = zeros(Rx_num, code_length);
    % delay from target reflection
    velocity = 0;
    % angle of target
    derad = pi/180;     % 角度轉弧度
    Tx_d = 0: 0.5 :(Tx_num-1)*0.5; % (lamda)
    Rx_d = 0: 0.5 :(Rx_num-1)*0.5; % (lamda)    
    for i = 1:targets_num % each target
        %{
        % for  xyz coordinate
        x =  target_info(j, 1) + target_info(j, 4)*time_slot;
        y =  target_info(j, 2) + target_info(j, 5)*time_slot;
        z =  target_info(j, 3) + target_info(j, 6)*time_slot;
        delay_shift = fix(2*chip_rate*sqrt(x.^2 + y.^2 + z.^2)/c);
        %}
        each_Tx = zeros(Tx_num, code_length);
        %% delay(range)
        range = target_info(i, 1) + velocity*time_slot;
        delay_shift = fix(2*chip_rate*range/c);
        fprintf("delay index %d\n", delay_shift(1));
        for j = 1:code_length % determine the index after delay
            shift_index = mod((j-delay_shift(j)), code_length);
            if shift_index == 0
                shift_index = code_length;
            end
            each_Tx(:, shift_index) = RF_each(:, j);    % M*L
        end
        
        %% AOA(Transmitter)(cos(phi))
        phi = target_info(i, 3);
        A_phi = transpose(exp(1i*2*pi*Tx_d.'*sin(phi*derad))); % 相位角 [1*Tx_num]
        % 發射端訊號總合 [1*Tx_num]*[Tx_num*L]=[1*L]
        fprintf("size A_phi [%d*%d]*[%d*%d]\n", size(A_phi, 1), size(A_phi, 2), size(each_Tx, 1), size(each_Tx, 2));
        Tx_temp = A_phi*each_Tx;
        Tx_all = Tx_all + Tx_temp;
        
        %% AOA(Receiver, sin(theta))
        theta = target_info(i, 2);
        A_theta = exp(1i*2*pi*Rx_d.'*sin(theta*derad)); % 相位角 [Rx_num*1]
        % 各個接收端訊號 [Rx_num*1]*[1*L]=[Rx_num*L]
        fprintf("size A_phi [%d*%d]*[%d*%d]\n", size(A_theta, 1), size(A_theta, 2), size(RF_all, 1), size(RF_all, 2));
        Rx_temp = A_theta*Tx_all;%Tx_temp;
        Rx_each = Rx_each + Rx_temp;
    end
end