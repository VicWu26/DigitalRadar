close all;  clear all;  clc;
%% system parameter
derad = pi/180;     % 角度轉弧度
N = 4;              % 接收端數量
theta = [12, 30]; % 目標物角度
M = length(theta);  % 目標物數量
SNR = 10;
K = 256;            % 快拍數??

dd = 0.5;           % 接收端間距
d = 0:dd:(N-1)*dd;  
A = exp(-1i*2*pi*d.'*sin(theta*derad)); % 相位角

%% signal model
%S = randn(M, K);    % 入射訊號
S = randi([0,1], M, K);
S(S == 0) = -1;
X = A*S;            % 接收端訊號
X = awgn(X, SNR, "measured");
[cross, lag] = xcorr(X(1, :));

figure;
plot(lag, abs(cross));
% 計算協方差矩陣
Rxx = X*X'/K;
% 特徵值分解
[EV, D] = eig(Rxx);
EVA = diag(D)';
[EVA, I] = sort(EVA);
EV = fliplr(EV(:, I));

% 計算角度
for iang = 1:361
    angle(iang) = (iang-181)/2;
    phim = derad*angle(iang);
    a = exp(-1i*2*pi*d*sin(phim)).';
    En = EV(:, M+1:N);
    Pmusic(iang) = 1/(a'*En*En'*a);
end

Pmusic = abs(Pmusic);
Pmmax = max(Pmusic);
Pmusic = 10*log10(Pmusic/Pmmax);

figure;
plot(angle, Pmusic, "Linewidth", 1.5);
xlabel("AOA (degree)");
ylabel("(dB)");
ylim([-8 0]);
%xlim([-90 90]);
grid on;

% https://www.twblogs.net/a/5cd9882ebd9eee67a77fb444

