function location_2D(X_value, X_axis, Y_value, Y_axis)
    %% print(X*Y)
    XY_plane = flip(Y_value)'*X_value;
    
    XY_plane(21, 30) = 0.1;%(range,  azimuth)
    XY_plane(21, 32) = 0.1;
    XY_plane(36, 17) = 0;
    XY_plane(21, 21) = 0.5;
    XY_plane(18, 27) = 0.3;

    [XY_axis, YX_axis] = meshgrid(X_axis, Y_axis);
    figure;
    %contourf(XY_axis, YX_axis, XY_plane);
    heatmap(XY_plane);
    %h.XDisplayData = {-7.5, -7, -6.5, -6, -5.5, -5, -4.5, -4, -3.5, -3, -2.5, -2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5};
        
    colormap("jet");
    caxis([0 1]);
    %set(gca, "XTick", 0.5:1:40.5);
    %ylim([0 30]);
    %xlim([0 10]);
    %bar = colormap;
    %ylabel(bar,'targets probability');
    xlabel('azimuth (degree)');ylabel('range (meter)');
    %% print(X*Y)(selected)
    
end
