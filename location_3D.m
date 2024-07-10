function [] = location_3D(X_value, X_axis, Y_value, Y_axis, Z_value)
    %% 2D plain
    XY_plane = flip(Y_value)'*X_value;
    %% decide which elevation plot
    Z_index = [10, 12, 14, 18, 20];
    
    for i = 1:length(Z_index)
        Z = Z_value(Z_index(i))
        XYZ_plane = XY_plane * Z_value(Z_index(i));
        % axis for 2D plot
        %[XY_axis, YX_axis] = meshgrid(X_axis, Y_axis);
        %% 3D plot 
        figure;
        heatmap(XYZ_plane);
        colormap("jet");
        caxis([0 1]);
        xlabel('azimuth (degree)');ylabel('range (meter)');

    end
end
