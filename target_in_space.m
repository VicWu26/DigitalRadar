function [cube] = target_in_space(cube, target, gain)
    %{
    fprintf("-----target information-----\n");
    fprintf("%d物體\n", size(target, 1));
    %}
    target_gain = 10^(gain/10);
    for i = 1:size(target, 1)
        range_index = target(i, 1);             % 距離
        azimuth_index = 2*(target(i, 2)+30)+1;  % 水平
        elevation_index = 2*target(i, 3)+1;     % 垂直
        cube(range_index, azimuth_index, elevation_index) = target_gain;
        %{
        fprintf("target %d in (%d, %d, %d), index (%d, %d, %d)\n" ...
            , i, target(i, 1), target(i, 2), target(i, 3) ...
            , range_index, azimuth_index, elevation_index);
        %}
    end
end