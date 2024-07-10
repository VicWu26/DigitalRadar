clc; clear;
%%
Rx = ones(8,8192) ;
Tx_each = ones(8,8192) ;
corr = ones(1,200) ;

MF = zeros(8*8, 200);
    for i = 1:8
        for j = 1:8
            index = (i-1)*8+j;
            [cross, s] = xcorr(Rx(j, :), conj(Tx_each(i,:)));
            % 取200點
            MF(index, :) = cross(8192:8192+199); % 取距離為正的區塊
            %MF(index, :) = cross(1:code_length-1) + cross(code_length+1:end);
        end
    end

MF_power = abs(MF).^2;
len = length(MF_power);

p_null = abs(corr).^2 ;
avg_p_null = mean(p_null) ;
temp = abs(mean(MF)).^2;
P_measure = temp / avg_p_null ;
temp_sort = sort(temp,'descend');

gamma = 6*ones(1, length(P_measure));
probability = round(exp((-1) .* gamma ./ (1+P_measure)), 3);
%%
a = [1 1 2;1 2 0;3 0 1] ;
b = a(1:3,:) ;
c = [] ;
    for i = 1:3
        c = [c; a(i, :)]; 
    end

[EV, D] = eig(c);
EVA = diag(D)';
[~, I] = sort(EVA);
EV = fliplr(EV(:, I));


%%
d = [2 3 1 9 4 7] ;
[~, E] = sort(d);
En = E(: ,4:6);

f = [1 2 -1];
f(f<0)=0;
f;

%%
   Tx_d_x = zeros(1,9);
    % Tx_d_y = 1.75 : 3 : 7.75;
    Tx_d_y = 0 : 0.5 : 4;
    Rx_d_x = 0 : 0.5 : (8-1)*0.5;
    Rx_d_y = zeros(1,8);
    virtual_x = zeros(1,9*8); % 1*24
    virtual_y = zeros(1,9*8); % 1*24
    count = 0;
    for i = 1:9
        for j = 1:8
            count = count+1;
            virtual_x(1,count) = Tx_d_x(i)+Rx_d_x(j);
            virtual_y(1,count) = Tx_d_y(i)+Rx_d_y(j);
        end
    end
    

    virtual_x_1 = repmat(virtual_x(1:5),1,9);
    virtual_x_2 = repmat(virtual_x(2:6),1,9);
    virtual_x_3 = repmat(virtual_x(3:7),1,9);
    virtual_x_4 = repmat(virtual_x(4:8),1,9);

    virtual_y_r = [];
    for i = 1 : 9
        virtual_y_r = [virtual_y_r,repmat(virtual_y((8*(i-1)+1)),1,5)];
    end

    % virtual_y_1 = repmat(virtual_y(1:5),virtual_y(9:13))
    figure;
    scatter(Rx_d_x,Rx_d_y,"blue",'filled',"^");
    hold on
    scatter(Tx_d_x,Tx_d_y,"red",'filled',"o");
    hold on
    scatter(virtual_x_1,virtual_y_r,"green","diamond");
    legend('Rx','Tx','virtual')
    ylim([0 5]);
    % saveas(gcf,'antenna array','jpeg');

    %%
    a = [1,1,1;1,1,1;1,1,1];
    b = zeros(5,3); % 疊加後傳送的訊號
    c = zeros(5,3);
    for i = 1 : 3
        c(i:2+i,:) = a;
        b = b + c;
        c = zeros(5,3);
    end

    %%
                    A_r_1 = ones(45,1); % 45*1
                    A_r_2 = ones(45,1);
                    A_r_3 = ones(45,1);
                    A_r_4 = ones(45,1);
                    A_theta = zeros(72,1);
                    for loop = 1 : 9
                        A_theta((loop-1)*8+1) = A_r_1((loop-1)*5+1);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+2) = A_r_1((loop-1)*5+2) + A_r_2((loop-1)*5+1);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+3) = A_r_1((loop-1)*5+3) + A_r_2((loop-1)*5+2) + A_r_3((loop-1)*5+1);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+4) = A_r_1((loop-1)*5+4) + A_r_2((loop-1)*5+3) + A_r_3((loop-1)*5+2) + A_r_4((loop-1)*5+1);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+5) = A_r_1((loop-1)*5+5) + A_r_2((loop-1)*5+4) + A_r_3((loop-1)*5+3) + A_r_4((loop-1)*5+2);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+6) = A_r_2((loop-1)*5+5) + A_r_3((loop-1)*5+4) + A_r_4((loop-1)*5+3);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+7) = A_r_3((loop-1)*5+5) + A_r_4((loop-1)*5+4);
                    end
                    for loop = 1 : 9
                        A_theta((loop-1)*8+8) = A_r_4((loop-1)*5+5);
                    end
