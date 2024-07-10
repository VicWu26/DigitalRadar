    derad = pi/180;     % 角度轉弧度
    Tx_d_1 = 0: 0.5 :(Tx_num-1)*0.5; % 0 ~ 0.5 
    Tx_d_2 = 0.5: 0.5 :(Tx_num)*0.5;
    Tx_d_3 = 1: 0.5 :(Tx_num+1)*0.5;
    Tx_d_4 = 1.5: 0.5 :(Tx_num+2)*0.5;
    Tx_d_5 = 2: 0.5 :(Tx_num+3)*0.5;
    Tx_d_6 = 2.5: 0.5 :(Tx_num+4)*0.5;
    Tx_d_7 = 3: 0.5 :(Tx_num+5)*0.5;
    Tx_d_8 = 3.5: 0.5 :(Tx_num+6)*0.5;
    Tx_d_9 = 4: 0.5 :(Tx_num+7)*0.5;
    Rx_d = 0 : 0.5 : (Rx_num-1)*0.5;
    % Rx_d = 0: 0.5 :(Rx_num-1)*0.5; % (lamda)
    Rx = zeros(Rx_num, code_length, "like", 1j);
    target_or_not = "off";
    %% transmit signal : 1*8192
    Tx_each_1 = Tx_each(1,:);
    Tx_each_2 = Tx_each(2,:);
    Tx_each_3 = Tx_each(3,:);
    Tx_each_4 = Tx_each(4,:);
    Tx_each_5 = Tx_each(5,:);
    Tx_each_6 = Tx_each(6,:);
    Tx_each_7 = Tx_each(7,:);
    Tx_each_8 = Tx_each(8,:);
    Tx_each_9 = Tx_each(9,:);
%%
                    phi = 0.5*(10-1);
                    % antenna_gain = antenna_gain / 9;
                    A_phi_1 = exp(1i*2*pi*Tx_d_1.'*sin(phi*derad)); % 12*1
                    W_phi_1 = conj(transpose(A_phi_1)); % 1*12
                    A_phi_2 = exp(1i*2*pi*Tx_d_2.'*sin(phi*derad)); % 12*1
                    W_phi_2 = conj(transpose(A_phi_2)); % 1*12
                    A_phi_3 = exp(1i*2*pi*Tx_d_3.'*sin(phi*derad)); % 12*1
                    W_phi_3 = conj(transpose(A_phi_3)); % 1*12
                    A_phi_4 = exp(1i*2*pi*Tx_d_4.'*sin(phi*derad)); % 12*1
                    W_phi_4 = conj(transpose(A_phi_4)); % 1*12
                    A_phi_5 = exp(1i*2*pi*Tx_d_5.'*sin(phi*derad)); % 12*1
                    W_phi_5 = conj(transpose(A_phi_5)); % 1*12
                    A_phi_6 = exp(1i*2*pi*Tx_d_6.'*sin(phi*derad)); % 12*1
                    W_phi_6 = conj(transpose(A_phi_6)); % 1*12
                    A_phi_7 = exp(1i*2*pi*Tx_d_7.'*sin(phi*derad)); % 12*1
                    W_phi_7 = conj(transpose(A_phi_7)); % 1*12
                    A_phi_8 = exp(1i*2*pi*Tx_d_8.'*sin(phi*derad)); % 12*1
                    W_phi_8 = conj(transpose(A_phi_8)); % 1*12
                    A_phi_9 = exp(1i*2*pi*Tx_d_9.'*sin(phi*derad)); % 12*1
                    W_phi_9 = conj(transpose(A_phi_9)); % 1*12
                    W_phi_1*A_phi_1
                    W_phi_2*A_phi_2
                    W_phi_3*A_phi_3
                    W_phi_4*A_phi_4
                    W_phi_5*A_phi_5
                    Tx_1 = (antenna_gain*exp(1i*2*pi*0*sin(phi*derad))*W_phi_1*A_phi_1*Tx_each_1)'; % 8192*1
                    Tx_2 = (antenna_gain*exp(1i*2*pi*0.5*sin(phi*derad))*W_phi_2*A_phi_2*Tx_each_2)'; % 8192*1
                    Tx_3 = (antenna_gain*exp(1i*2*pi*1*sin(phi*derad))*W_phi_3*A_phi_3*Tx_each_3)'; % 8192*1
                    Tx_4 = (antenna_gain*exp(1i*2*pi*1.5*sin(phi*derad))*W_phi_4*A_phi_4*Tx_each_4)'; % 8192*1
                    Tx_5 = (antenna_gain*exp(1i*2*pi*2*sin(phi*derad))*W_phi_5*A_phi_5*Tx_each_5)'; % 8192*1
                    Tx_6 = (antenna_gain*exp(1i*2*pi*2.5*sin(phi*derad))*W_phi_6*A_phi_6*Tx_each_6)'; % 8192*1
                    Tx_7 = (antenna_gain*exp(1i*2*pi*3*sin(phi*derad))*W_phi_7*A_phi_7*Tx_each_7)'; % 8192*1
                    Tx_8 = (antenna_gain*exp(1i*2*pi*3.5*sin(phi*derad))*W_phi_8*A_phi_8*Tx_each_8)'; % 8192*1
                    Tx_9 = (antenna_gain*exp(1i*2*pi*4*sin(phi*derad))*W_phi_9*A_phi_9*Tx_each_9)'; % 8192*1
                    Tx = Tx_1 + Tx_2 + Tx_3 + Tx_4 + Tx_5 + Tx_6 + Tx_7 + Tx_8 + Tx_9;