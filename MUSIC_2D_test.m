close all;  clear all;  clc;

f1 = 450.0;
f2 = 600.0;
doa1 = [-37;0];
doa2 = [17;20];
fc = 150e6;
c = physconst('LightSpeed');
lam = c/fc;
fs = 8000;

array = phased.URA('Size',[4 4],'ElementSpacing',[lam/2 lam/2]);
array.Element.FrequencyRange = [50.0e6 500.0e6];

t = (0:1/fs:1).';
x1 = randi([0,1], 1, 1024)';
x2 = randi([0,1], 1, 1024)';
x = collectPlaneWave(array,[x1 x2],[doa1,doa2],fc);
noise = 0.1*(randn(size(x))+1i*randn(size(x)));

estimator = phased.MUSICEstimator2D('OperatingFrequency',fc,...
    'NumSignalsSource','Property',...
    'DOAOutputPort',true,'NumSignals',2,...
    'AzimuthScanAngles',-50:.5:50,...
    'ElevationScanAngles',-30:.5:30);
%[~,doas] = estimator(x + noise)

%plotSpectrum(estimator);