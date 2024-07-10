function [RF_all] = RF_modulation(IF_all, carrier_freq, time_slot)
    RF_all = IF_all.*cos(2*pi*carrier_freq*time_slot);
    figure;
    plot(time_slot, RF_all);
    xlim([0, 5e-7]);
    xlabel("time");
    title("RF signal");
end