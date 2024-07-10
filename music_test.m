close all;  clear all;  clc;
%% system parameter
derad = pi/180;     % �����੷��
N = 4;              % �����ݼƶq
theta = [12, 30]; % �ؼЪ�����
M = length(theta);  % �ؼЪ��ƶq
SNR = 10;
K = 256;            % �֩��??

dd = 0.5;           % �����ݶ��Z
d = 0:dd:(N-1)*dd;  
A = exp(-1i*2*pi*d.'*sin(theta*derad)); % �ۦ쨤

%% signal model
%S = randn(M, K);    % �J�g�T��
S = randi([0,1], M, K);
S(S == 0) = -1;
X = A*S;            % �����ݰT��
X = awgn(X, SNR, "measured");
[cross, lag] = xcorr(X(1, :));

figure;
plot(lag, abs(cross));
% �p����t�x�}
Rxx = X*X'/K;
% �S�x�Ȥ���
[EV, D] = eig(Rxx);
EVA = diag(D)';
[EVA, I] = sort(EVA);
EV = fliplr(EV(:, I));

% �p�⨤��
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

