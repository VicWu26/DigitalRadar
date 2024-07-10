function [Rx] = channel7(Tx_each, antenna_gain, space_cube, space_i, space_j, space_k, Tx_num, Rx_num, code_length, chip_rate, carrier_freq)
    %% -------------------initial-------------------------
    %% antenna structure
    derad = pi/180;     % 角度轉弧度
    Tx_d = 3 : 0.5 :(Tx_num+5)*0.5; % 0 ~ 0.5 
    Rx_d = 0 : 0.5 : (Rx_num-1)*0.5;
    % Rx_d = 0: 0.5 :(Rx_num-1)*0.5; % (lamda)
    Rx = zeros(Rx_num, code_length, "like", 1j);
    target_or_not = "off";
    %% path loss
    path = phased.FreeSpace('TwoWayPropagation', true, 'SampleRate', chip_rate, 'OperatingFrequency', carrier_freq);
    thermal_noise = comm.ThermalNoise('SampleRate', chip_rate);
    %% channel
    for i = 1:space_i
        for j = 1:space_j   % 0~121
            for k = 1:space_k   % 0~61
                if(space_cube(i, j, k)~=0)
                    target_or_not = "on";
                    %% AOA(Transmitter)(sin(phi))
                    phi = 0.5*(k-1);
                    % antenna_gain = antenna_gain / 9;
                    A_phi = exp(1i*2*pi*Tx_d.'*sin(phi*derad)); % 12*1
                    W_phi = conj(transpose(A_phi)); % 1*12
                    Tx = (antenna_gain*(sqrt(20/(9*12)))*W_phi*A_phi*Tx_each)'; % 8192*1
                    %% range(path loss)
                    temp = path(repmat(Tx, 2, 1), [0; 0; 0], [i; 0; 0], [0;0;0], [0;0;0]);
                    Tx = temp(code_length+1:end);       % circular shift
                    % 空間反射(當不完全反射時要打開)
                    Tx = space_cube(i, j, k)*Tx;
                    %% AOA(Receiver, sin(theta))
                    theta = -30+0.5*(j-1);
                    A_r = exp(-1i*2*pi*Rx_d.'*sin(theta*derad)); % 15*1
                    Rx_temp = A_r*(Tx'); % [72*1]*[1*8192] %Tx_temp;  
                    %a = Rx_temp;
                    Rx = Rx + Rx_temp;
                end
            end
        end
    end
    
    %% thermal noise
    if(target_or_not == "off")
        Rx_t = ones(Rx_num, code_length) + 1j*ones(Rx_num, code_length);
        for m = 1:Rx_num
            s_noise = thermal_noise(Rx_t(m, :)');
            n = s_noise - Rx_t(m, :)';
            %n = n * 31.6;
            Rx(m, :) = n';
        end
    else
        for m = 1:Rx_num
            % Rx = thermal_noise(Rx(m, :)');
            s_noise = thermal_noise(Rx(m, :)');
            n = s_noise - Rx(m, :)';
            %n = n * 31.6;  % 31.6為實驗值
            Rx(m, :) = Rx(m, :) + n';
        end
    end
    
end