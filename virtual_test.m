    Tx_d_x = zeros(1,9);
    Tx_d_y = 0 : 0.5 : (9-1)*0.5;
    Rx_d_x = 0 : 0.5 : (15-1)*0.5;
    Rx_d_y = zeros(1,15);
    virtual_x = zeros(1,9*15); % 1*135
    virtual_y = zeros(1,9*15); 
    count = 0;
    for i = 1:9
        for j = 1:15
            count = count+1;
            virtual_x(1,count) = Tx_d_x(i)+Rx_d_x(j);
            virtual_y(1,count) = Tx_d_y(i)+Rx_d_y(j);
        end
    end

    figure;
    scatter(Rx_d_x,Rx_d_y,"blue",'filled',"^");
    hold on
    scatter(Tx_d_x,Tx_d_y,"red",'filled',"o");
    hold on
    scatter(virtual_x,virtual_y,"green","diamond");
    legend('Rx','Tx','virtual')
    ylim([0 5]);
