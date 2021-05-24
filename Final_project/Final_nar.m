%
% Final : 1. �� ���� signal�� ���� spectrogram
%       : Fs = 100Hz, Window width : 1s, overlap : 0.5s, nfft : 128
%       : 2. Feature ���� �� Gaussian pdf
%       : 3. likelihood
% signal1�� signal2 �м� - plot, spectrogram, scatter �� 
% ����þ� pdf �����Ͽ� signal1�� signal2 �н���Ŵ
% test signal�� ��ġ�� Ȯ��
% --------------------------------------------------------------------------------
clear all;
close all;
clc;

%% Train -----------------------------------------------------------------
load signal1.mat;
load signal2.mat;

Fs = 100;             % Fs >= 2*Fmax
T = 1/Fs;             % �ֱ� = 1/���ļ�
L = length(signal1);  % Length of signal
t = (0:L-1)*T;        % Time vector
nfft = 128; window = 100; overlap = 50;
% 100���� 10000���� ������ --> window width�� 1���̹Ƿ� window 100��
% ����������, overlap�� 0.5���̹Ƿ� overlap 50��

%% hw1 _ signal plot
% signal1�� signal2�� �ð������� plot��
figure(1),
plot(t,signal1+1,'b'); %�ϳ��� plot���� �������� ���� shift
hold on;
plot(t,signal2-1,'r'); %�Ʒ��� shift

% ����
set(gca,'ytick',[]);
ylabel('Signal2              Signal1','fontsize',16);
title('Train Signal','fontsize',20);

%% hw2 _ spectrogram
% 65x199���.
% nfft = 128. ¦���̹Ƿ� ���� ���� 128/2+1 = 65�� �ȴ�.
% window ���� 100�̹Ƿ� 10000���� ������ 100���� ���׸�Ʈ�� ������. �׸��� 50���� ��ø��Ų��.
% �׷��Ƿ� ���� ���� (10000 - 50) / (100 - 50) = 199�� �ȴ�.

% ��ȣ1�� spectrogram �� �پ��� ���� �̾Ƴ� (s1, f1, t1, ps1)
figure(2),subplot(1,2,1);
[s1, f1, t1, ps1] = spectrogram(signal1, window, overlap, nfft,Fs,'yaxis');
spectrogram(signal1, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Signal1 Spectrogram','fontsize',20);

% ��ȣ2�� spectrogram �� �پ��� ���� �̾Ƴ� (s2, f2, t2, ps2)
subplot(1,2,2);
[s2, f2, t2, ps2] = spectrogram(signal2, window, overlap, nfft,Fs,'yaxis');
spectrogram(signal2, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Signal2 Spectrogram','fontsize',20);

%% hw2 _ feature ����
% ���ļ� 25Hz���� ū �Ͱ� 25Hz ���Ϸ� feature ����
% psd ���� ���. 33x199.
% feature1_s1  = abs(0.02*s1(1:(length(f1)+1)/2, :)).^2;
% feature2_s1  = abs(0.02*s1((length(f1)+1)/2:length(f1),:)).^2;
% feature1_s2  = abs(0.02*s2(1:(length(f1)+1)/2,:)).^2;
% feature2_s2  = abs(0.02*s2((length(f1)+1)/2:length(f1),:)).^2;

% 0~50Hz. ������ 25Hz�� �������� feature����
% spectrogram���� �̾Ƴ� ps�� ���
feature1_s1  = ps1(1:(length(f1)+1)/2, :);
feature2_s1  = ps1((length(f1)+1)/2+1:length(f1),:);
feature1_s2  = ps2(1:(length(f1)+1)/2,:);
feature2_s2  = ps2((length(f1)+1)/2+1:length(f1),:);

% psd ���
% ������ �ð��� ����, �ش��ϴ� psd�� ��ճ�. 1x199.
feature1_s1  = mean(feature1_s1,1);
feature2_s1  = mean(feature2_s1,1);
feature1_s2  = mean(feature1_s2,1);
feature2_s2  = mean(feature2_s2,1);

% scatter
figure(3),
scatter(feature1_s1,feature2_s1,'bd','filled'); %signal1
hold on
scatter(feature1_s2,feature2_s2,'rd','filled'); %signal2

% ����
xlabel('25Hz ������ psd ���','fontsize',16);
ylabel('25Hz���� ū psd ���','fontsize',16);
title('Signal features for learning','fontsize',20);
legend('signal1','signal2');


% ������ �ð�(100��)�� 65���� ���ļ��� ����.
% �װ��� 25�츣���� �������� ���� 2��(0~33��, 34~65��)�� �����Ͽ� psd�� ���.
% ������ �ð��� ���ؼ� �� ������ ��ü psd�� ��ճ�.
% ��, scatter �׷������� ������ �ش� �ð���.
% �ش� �ð�(������ ��)�� 25�츣�� ������ psd�� ��հ��� x���� ���� ����,
% 25�츣�� �̻��� psd�� ��հ��� y���� ���� ����.
%------------------------------------------------------------------------------------

%% Gaussian pdf
% �ڷ�. Data
x1 = feature1_s1;
y1 = feature2_s1;
x2 = feature1_s2;
y2 = feature2_s2;

% Data���� �������� ��հ� ���л� ���
mu1 = [mean(x1),mean(y1)];
mu2 = [mean(x2),mean(y2)];
sigma1 = cov(x1,y1); %���л�
sigma2 = cov(x2,y2);

% gaussian pdf�� �׸� �⺻ x,y�� ����
x = linspace(0,0.005,50);
y = linspace(0,0.0015,50);

% grid����. ��, xy��� ���� : plane
[X,Y] = meshgrid(x,y);
Z = [X(:) Y(:)];

% ���� ��հ� ���л��� �������� �� signal�� mvnpdf���. z��
% �⺻ grid�� ������ mu�� sigma�����ؼ� �����
z1 = mvnpdf(Z,mu1,sigma1);
z1 = reshape(z1,length(x),length(y)); %surf�� ���� reshape
z2 = mvnpdf(Z,mu2,sigma2);
z2 = reshape(z2,length(x),length(y));

% 3���� �׸���
figure(4),surf(x,y,z1);
hold on
surf(x,y,z2);
colormap jet; axis tight;
view(45, 45);
title('Gaussian pdf 3D','fontsize',20);

% 2���� �׸���
figure(5),surface(x,y,z1);
hold on
surface(x,y,z2);
colormap jet; axis tight;
title('Gaussian pdf 2D','fontsize',20);



%% Test signal --------------------------------------------------------------
load signal_test1.mat;
load signal_test2.mat;

%% plot �׸���
% �ð��࿡ ���� test signal plot
figure(6),
plot(t,signal_test1+1,'b'); %���� shift
hold on;
plot(t,signal_test2-1,'r');

% ����
set(gca,'ytick',[]);
ylabel('Signal_ test2              Signal_ test1','fontsize',16);
title('Test Signal','fontsize',20);

%% hw2 _ spectrogram
% test signal1
figure(7),subplot(1,2,1);
[st1, ft1, tt1, pst1] = spectrogram(signal_test1, window, overlap, nfft,Fs,'yaxis'); %ps �̾Ƴ���
spectrogram(signal_test1, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Test Signal1 Spectrogram','fontsize',20);

% test signal2
subplot(1,2,2);
[st2, ft2, tt2, pst2] = spectrogram(signal_test2, window, overlap, nfft,Fs,'yaxis');
spectrogram(signal_test2, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Test Signal2 Spectrogram','fontsize',20);

%% scatter
% ������ �̾Ƴ� ps�� test signal�� feature ���� -> psd ��հ�
feature1_test1  = mean(pst1(1:(length(ft1)+1)/2,:),1);
feature2_test1  = mean(pst1((length(ft1)+1)/2:length(ft1),:),1);
feature1_test2  = mean(pst2(1:(length(ft2)+1)/2,:),1);
feature2_test2  = mean(pst2((length(ft2)+1)/2:length(ft2),:),1);

% �׸���
figure(8),
scatter(feature1_test1,feature2_test1,'bd','filled');
hold on
scatter(feature1_test2,feature2_test2,'rd','filled');

% ����
title('test features','fontsize',20);
xlabel('25Hz ������ psd ���','fontsize',16);
ylabel('25Hz���� ū psd ���','fontsize',16);
legend('test signal1','test signal2');
axis([0 0.0058 0 0.0014]);



%% HW3 likelihood �м�(ML)-------------------------------------------------------
% �ڷ�
xtest1 = feature1_test1;
ytest1 = feature2_test1;
xtest2 = feature1_test2;
ytest2 = feature2_test2;

% ���� �Ҵ�
xmin1 = zeros(length(x),1);
xmin2 = zeros(length(x),1);
ymin1 = zeros(length(y),1);
ymin2 = zeros(length(y),1);

xidx1 = zeros(length(xtest1),1);
xidx2 = zeros(length(xtest2),1);
yidx1 = zeros(length(ytest1),1);
yidx2 = zeros(length(ytest2),1);

%% Test signal
% Test signal�� x��ǥ����? pdf�� x���Ϳ�������? ������ ������ ��Ī��Ų��.?
for i = 1:length(xtest1) % test signal�� x��ǥ��
    for j = 1:length(x) % pdf x���� ��� ��(50��)�� ������ �Ÿ��� ���Ѵ�. �׸��� �� ������ �����Ѵ�.
        xmin1(j,1) = abs(xtest1(1,i)-x(1,j)); 
    end
    [val, idx] = min(xmin1); % ���� ���� ���� ��(�Ÿ��� ���� �����Ƿ� ��ǥ�� ���� �����ϴ�.)�� �ε����� �����Ѵ�. 
    xidx1(i,1) = idx;
end % �� ������ test signal�� 199�� x��ǥ�鿡 ���ؼ� �ݺ��Ѵ�.

% Test signal�� y��ǥ����? pdf�� y���Ϳ�������? ������ ������ ��Ī��Ų��.?
for i = 1:length(ytest1)
    for j = 1:length(y)
        ymin1(j,1) = abs(ytest1(1,i)-y(1,j));
    end
    [val, idx] = min(ymin1);
    yidx1(i,1) = idx;
end

% Test signal�� ��� ��ǥ�鿡�� pdf���� ���Ͽ� ū pdf���� ������ ������Ų��.?
lk1_sig1 = 0;
lk1_sig2 = 0;
for i = 1:length(xtest1)
    if ( z1(xidx1(i),yidx1(i)) > z2(xidx1(i),yidx1(i)) ) % signal1�� pdf�� ũ�ٸ�
        lk1_sig1 = lk1_sig1 + 1; % signal1�� �з�. �� ���� �ϳ� ����
    elseif ( z1(xidx1(i),yidx1(i)) < z2(xidx1(i),yidx1(i)) ) % signal2�� pdf�� ũ�ٸ�
        lk1_sig2 = lk1_sig2 + 1; % signal2�� �з�
    else % ���� Ȯ���� ���ٸ�, ������ ���������� ������ ������ �з��ϴ� ���� �ƴ϶�,
         % test signal�� ���� signal���� ��ġ���� ���� �����̹Ƿ� �ϴ� �� �� ������Ű�� ��ġ���� �����
        lk1_sig1 = lk1_sig1 + 1;
        lk1_sig2 = lk1_sig2 + 1;
    end
end


%% Test signal2
% x��ǥ ��Ī
for i = 1:length(xtest2)
    for j = 1:length(x)
        xmin2(j,1) = abs(xtest2(1,i)-x(1,j));
    end
    [val, idx] = min(xmin2);
    xidx2(i,1) = idx;
end

% y��ǥ ��Ī
for i = 1:length(ytest2)
    for j = 1:length(y)
        ymin2(j,1) = abs(ytest2(1,i)-y(1,j));
    end
    [val, idx] = min(ymin2);
    yidx2(i,1) = idx;
end

% pdf�� �� ��
lk2_sig1 = 0;
lk2_sig2 = 0;
for i = 1:length(xtest1)
    if ( z1(xidx2(i),yidx2(i)) > z2(xidx2(i),yidx2(i)) )
        lk2_sig1 = lk2_sig1 + 1;
    elseif ( z1(xidx2(i),yidx2(i)) < z2(xidx2(i),yidx2(i)) )
        lk2_sig2 = lk2_sig2 + 1;
    else
        lk2_sig1 = lk2_sig1 + 1;
        lk2_sig2 = lk2_sig2 + 1;
    end
end

% ��ġ�� ���
rate11 = lk1_sig1 / (lk1_sig1 + lk1_sig2) *100; % test1�� signal1�� ��ġ��
rate12 = lk1_sig2 / (lk1_sig1 + lk1_sig2) *100; % test1�� signal2
rate21 = lk2_sig1 / (lk2_sig1 + lk2_sig2) *100; % test2�� signal1
rate22 = lk2_sig2 / (lk2_sig1 + lk2_sig2) *100; % test2�� signal2
