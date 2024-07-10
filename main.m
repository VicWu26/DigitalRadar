
close all;  clear all;  clc;
%% system parameter
chip_rate = 150e6;      % 1/chip_rate is chip duration, c=3x10^8, c/2=1.5x10^8, 1.5x10^8/1.5x10^8=1m 
carrier_freq = 77e9;    % lamda 1cm
c = 3e8;                % light speed
lambda = c/chip_rate;
Tx_num_each = 12;            % number of transmitter 
Tx_num = 20;
Rx_num = 15;            % number of reciever
Tx_power = 12;         % (12dBm)
Tx_gain = 12;           % (12 dBi)
Rx_gain = 12;           % (12 dBi)
target_gain = 10;       % (dBsm)
antenna_gain = 10^((Tx_power + Tx_gain + Rx_gain)/10); % ratio
antenna_gain_dB = Tx_power + Tx_gain + Rx_gain;
fprintf("-----parameter information-----\n");
fprintf("天線數量 %d*%d\n", Tx_num, Rx_num);
fprintf("取樣頻率 %dMHz\n", chip_rate/1e6);
fprintf("載波頻率 %dGHz\n", carrier_freq/1e9);
fprintf("波長 %.2d(m)\n", lambda);
fprintf("總增益 %.0d, %d (dB)\n", round(antenna_gain), Tx_power + Tx_gain + Rx_gain + target_gain);
%%  Optimum Partitioning of a Phased-MIMO Radar   IEEE ANTENNAS AND WIRELESS PROPAGATIONLETTERS,VOL.16,2017
subarray_num = 9;
subarray_element = 12;

%% noise and interference parameter
%SIR = 0;64*64
%Noise = "on";

%% object information
% (range, azimuth, elevation)
%[meter, degree, degree]
% ([0:1:250], [-30:0.5:30], [0:0.5:30])
P_measure_total_SIC = zeros(1,200);
space_i = 250;  space_j = 121;  space_k = 61;
space_cube = zeros(space_i, space_j, space_k);  % 空間網格數量
% space_cube1 = zeros(space_i, space_j, space_k);
% space_cube2 = zeros(space_i, space_j, space_k);
% space_cube3 = zeros(space_i, space_j, space_k);
% space_cube4 = zeros(space_i, space_j, space_k);
% space_cube5 = zeros(space_i, space_j, space_k);
% target = [100, 0, 0];
% target = [5, 3, 0; 7, 7, 0; 9, 10, 0; 10, 7, 10; 14, 3, 0; 17, 10, 0];
% target = [1, 3, 0; 2, 4, 0; 3 ,5, 0; 7, 1, 0; 10, 2, 0];
target = [50, -5, 0; 51, -3, 0; 52 ,-1, 0; 55, 0, 10; 56, 4, 0]; % [range, azimuth, elevation]
% target = [50, 0, 0; 51, 0, 0; 52 ,0, 0; 55, 0, 0; 56, 0, 0];
% target = [50, -15, 0; 60, -5, 0; 65 ,-1, 0; 70, 1, 0; 80, 4, 10; 83, 10, 10; 90, 15, 10];
% target = [50, -7, 10; 51, -5, 10; 52 ,-1, 10; 55, 1, 20; 60, 4, 20; 56, 5, 20; 62, 7, 20];
% target = [50, -15, 1; 51, -8, 3; 52 ,-3, 5; 55, 0, 7; 60, 5, 9; 56, 20, 11; 62, 25, 13];
% target = [50, -6, 0; 51 ,-5, 0; 55, -1, 0; 60, 1, 0; 56, 2, 0; 62, 5, 0];
% target = [50, -21, 0; 51, -19, 0; 52 ,-3, 0; 54, 0, 0; 55, 1, 0; 81, 21, 0];
% target = [5, 2, 0; 8, 8, 0];
% target = [5, 0, 0; 7, 0, 0; 10, 0, 0; 12, 0, 0; 15, 0, 0];
% target = [20, 0, 0; 22, 0, 0; 26, 0, 0; 31, 0, 0; 33, 0, 0; 39, 0, 0; 40, 0, 0; 41, 0, 0; 43, 0, 0; 45, 0, 0];
space_cube = target_in_space(space_cube, target, target_gain); 
% space_cube1 = target_in_space(space_cube1, target(1,:), target_gain);
% space_cube2 = target_in_space(space_cube2, target(2,:), target_gain);
% space_cube3 = target_in_space(space_cube3, target(3,:), target_gain);
% space_cube4 = target_in_
% space(space_cube4, target(4,:), target_gain);
% space_cube5 = target_in_space(space_cube5, target(5,:), target_gain); 
%% code information
code_length = 8192; % 編碼長度
chip_duration = code_length/chip_rate; % 一組編碼的時間
range = [2:code_length];
range_axis = range*c/(2*chip_rate);
azimuth_axis = -30:0.5:30;
elevation_axis = 0:0.5:30;

%% time slot
% sampling with chip rate
time_slot = 0 : 1.0/chip_rate : chip_duration;
time_slot = time_slot(1:end-1);

index_lags = 0:199;
range_lags = (index_lags)*c/(2*chip_rate); 
%% print information
fprintf("-----sigal information-----\n");
fprintf("chip duration %.2d(us)\n", chip_duration*1e6);
fprintf("編碼長度 %d\n", code_length);
fprintf("最大偵測距離 %d (m)\n", (c*code_length)/(2*chip_rate));
fprintf("距離解析度 %d (m)\n", c/(2*chip_rate));

%% statistical analysis parameter
plot_state = true;
testing_times = 100;
% false_alarm = zeros(1, 46);
% miss_detection = zeros(1, 46);
% CFAR_false_alarm = zeros(1, 46);
% CFAR_miss_detection = zeros(1, 46);
% CFAR parameter
gamma = 7;%2:0.5:10.1;
% P_fa = 0.08;

% gamma_miss_detection = zeros(1, length(gamma));

%% simulation
if plot_state
    testing_times = 1;
end
    for times = 1:testing_times
        %% code word generator
        [code_list] = code_generator(code_length, subarray_element, subarray_num);
        %% Tx
        [Tx_each] = BPSK(code_list, Tx_power, carrier_freq, time_slot); % 9組訊號
        %% Rx
        [Rx_each] = channel(Tx_each, antenna_gain, space_cube, space_i, space_j, space_k, Tx_num_each, Rx_num, code_length, chip_rate, carrier_freq);
        %% DSP(range)
        [MF_result] = matched_filter(plot_state, Tx_each, Rx_each, subarray_num, Rx_num, chip_rate, code_length, c);
        [P_measure, ~] = noise_floor(plot_state, Tx_each, Rx_each, MF_result, code_length, carrier_freq, time_slot, antenna_gain_dB, chip_rate);
        [P_null] = noise_floor_null(plot_state, Tx_each, Rx_each, MF_result, code_length, carrier_freq, time_slot, antenna_gain_dB, chip_rate);
        [range_probability] = target_probability(plot_state, P_measure, gamma);
        %% DSP(angle) Analysis_of_the_accuracy_of_the_estimation_of_signal_arrival_angle
        %             in_monostatic_MIMO_radar_using_the_Capon_algorithm_and_its_modifications
        [theta_input, phi_input] = decide_input_matrix(MF_result, subarray_num, Rx_num);
        [azimuth_probability] = CAPON(plot_state, theta_input, Rx_num, azimuth_axis);
        [elevation_probability] = CAPON(plot_state, phi_input, subarray_num, elevation_axis);
        %% 2D/3D vistualization
%         location_3D(range_value, phi_abs, theta_abs, range_lags, angle_lags);
%         location_3D(range_probability_total(2:41), abs(elevation_probability(1:36)), abs(azimuth_probability(61:101)), range_lags, azimuth_axis);
        if plot_state
            % location_2D(azimuth_probability(61:101), azimuth_axis, range_probability(2:41), range_lags);
%             location_3D(azimuth_probability(61:101), azimuth_axis, range_probability(2:41), range_lags, elevation_probability);
        end
    end
%end
