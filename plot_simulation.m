function plot_simulation()
    figure;hold on;
    axis off;
    title('FMCW Radar & Object Positions')
    % draw X axis
    x = -4:0.1:4;
    y = zeros(size(x));
    plot(x,y,'k')
    plot(4.1,0,'k>');
    text(3.7,0.3,'X');
    % draw Y axis
    y = 0:0.1:10;
    x = zeros(size(y));
    plot(x,y,'k')
    plot(0,10.1,'k^');
    text(0.1,9.7,'Y');
    % draw antenna postition
    text(-1.2,-0.9,'Radar Antennas')
    plot(2,0,'bx');text(.2,-0.3,'rx2')
    plot(1,0,'bx');text(0.8,-0.3,'rx1')
    plot(0,0,'b*');text(-0.2,-0.3,'tx')

    plot(0,8,'rx');plot(-5,8,'r<');plot(5,8,'r>');
    plot(3,8,'ro');text(2.5,7.6,'Object')
    x = -5:0.1:5;
    y = ones(size(x))*8;
    plot(x,y,'r:')
    text(3.2,8.3,'\rightarrow vh');

    text(0,0.9,'\rightarrow');
    text(0.05,1.2,'theta');

    x = -1:0.1:3;
    y = 2*x+2;
    plot(x,y,'r:')
    text(1.4,5.8,'d1');

    x = 0:0.1:3;
    y = 8/3*x;
    plot(x,y,'r:')
    text(1.5,4.5,'d0');

    x = 1:0.1:3;
    y = 4*x-4;
    plot(x,y,'r:')
    text(2.45,5.5,'d2');

    text(-0.6,4.5,'Dm');
    xlim([-6 6]);ylim([-1 11])
    hold off;
end