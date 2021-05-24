%
% Final : 1. 두 개의 signal에 대한 spectrogram
%       : Fs = 100Hz, Window width : 1s, overlap : 0.5s, nfft : 128
%       : 2. Feature 추출 및 Gaussian pdf
%       : 3. likelihood
% signal1과 signal2 분석 - plot, spectrogram, scatter 등 
% 가우시안 pdf 생성하여 signal1과 signal2 학습시킴
% test signal로 일치율 확인
% --------------------------------------------------------------------------------
clear all;
close all;
clc;

%% Train -----------------------------------------------------------------
load signal1.mat;
load signal2.mat;

Fs = 100;             % Fs >= 2*Fmax
T = 1/Fs;             % 주기 = 1/주파수
L = length(signal1);  % Length of signal
t = (0:L-1)*T;        % Time vector
nfft = 128; window = 100; overlap = 50;
% 100초인 10000개의 데이터 --> window width는 1초이므로 window 100개
% 마찬가지로, overlap은 0.5초이므로 overlap 50개

%% hw1 _ signal plot
% signal1과 signal2를 시간축으로 plot함
figure(1),
plot(t,signal1+1,'b'); %하나의 plot에서 보기위해 위로 shift
hold on;
plot(t,signal2-1,'r'); %아래로 shift

% 셋팅
set(gca,'ytick',[]);
ylabel('Signal2              Signal1','fontsize',16);
title('Train Signal','fontsize',20);

%% hw2 _ spectrogram
% 65x199행렬.
% nfft = 128. 짝수이므로 행의 수는 128/2+1 = 65가 된다.
% window 수는 100이므로 10000개의 샘플을 100개의 세그먼트로 나눈다. 그리고 50개를 중첩시킨다.
% 그러므로 열의 수는 (10000 - 50) / (100 - 50) = 199가 된다.

% 신호1의 spectrogram 및 다양한 정보 뽑아냄 (s1, f1, t1, ps1)
figure(2),subplot(1,2,1);
[s1, f1, t1, ps1] = spectrogram(signal1, window, overlap, nfft,Fs,'yaxis');
spectrogram(signal1, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Signal1 Spectrogram','fontsize',20);

% 신호2의 spectrogram 및 다양한 정보 뽑아냄 (s2, f2, t2, ps2)
subplot(1,2,2);
[s2, f2, t2, ps2] = spectrogram(signal2, window, overlap, nfft,Fs,'yaxis');
spectrogram(signal2, window, overlap, nfft,Fs,'yaxis');
colormap jet; colorbar('off');
title('Signal2 Spectrogram','fontsize',20);

%% hw2 _ feature 추출
% 주파수 25Hz보다 큰 것과 25Hz 이하로 feature 추출
% psd 직접 계산. 33x199.
% feature1_s1  = abs(0.02*s1(1:(length(f1)+1)/2, :)).^2;
% feature2_s1  = abs(0.02*s1((length(f1)+1)/2:length(f1),:)).^2;
% feature1_s2  = abs(0.02*s2(1:(length(f1)+1)/2,:)).^2;
% feature2_s2  = abs(0.02*s2((length(f1)+1)/2:length(f1),:)).^2;

% 0~50Hz. 절반인 25Hz를 기준으로 feature나눔
% spectrogram에서 뽑아낸 ps를 사용
feature1_s1  = ps1(1:(length(f1)+1)/2, :);
feature2_s1  = ps1((length(f1)+1)/2+1:length(f1),:);
feature1_s2  = ps2(1:(length(f1)+1)/2,:);
feature2_s2  = ps2((length(f1)+1)/2+1:length(f1),:);

% psd 평균
% 각각의 시간에 대해, 해당하는 psd를 평균냄. 1x199.
feature1_s1  = mean(feature1_s1,1);
feature2_s1  = mean(feature2_s1,1);
feature1_s2  = mean(feature1_s2,1);
feature2_s2  = mean(feature2_s2,1);

% scatter
figure(3),
scatter(feature1_s1,feature2_s1,'bd','filled'); %signal1
hold on
scatter(feature1_s2,feature2_s2,'rd','filled'); %signal2

% 셋팅
xlabel('25Hz 이하의 psd 평균','fontsize',16);
ylabel('25Hz보다 큰 psd 평균','fontsize',16);
title('Signal features for learning','fontsize',20);
legend('signal1','signal2');


% 각각의 시간(100초)은 65개의 주파수를 갖음.
% 그것을 25헤르츠를 기준으로 피쳐 2개(0~33행, 34~65행)로 구분하여 psd를 계산.
% 각각의 시간에 대해서 두 구간의 전체 psd를 평균냄.
% 즉, scatter 그래프에서 점들은 해당 시간임.
% 해당 시간(각각의 점)의 25헤르츠 이하인 psd의 평균값은 x축의 값을 갖고,
% 25헤르츠 이상인 psd의 평균값은 y축의 값을 갖음.
%------------------------------------------------------------------------------------

%% Gaussian pdf
% 자료. Data
x1 = feature1_s1;
y1 = feature2_s1;
x2 = feature1_s2;
y2 = feature2_s2;

% Data들을 바탕으로 평균과 공분산 계산
mu1 = [mean(x1),mean(y1)];
mu2 = [mean(x2),mean(y2)];
sigma1 = cov(x1,y1); %공분산
sigma2 = cov(x2,y2);

% gaussian pdf를 그릴 기본 x,y축 설정
x = linspace(0,0.005,50);
y = linspace(0,0.0015,50);

% grid생성. 즉, xy평면 생성 : plane
[X,Y] = meshgrid(x,y);
Z = [X(:) Y(:)];

% 계산된 평균과 공분산을 바탕으로 각 signal의 mvnpdf계산. z축
% 기본 grid에 각각의 mu와 sigma적용해서 만들기
z1 = mvnpdf(Z,mu1,sigma1);
z1 = reshape(z1,length(x),length(y)); %surf를 위해 reshape
z2 = mvnpdf(Z,mu2,sigma2);
z2 = reshape(z2,length(x),length(y));

% 3차원 그리기
figure(4),surf(x,y,z1);
hold on
surf(x,y,z2);
colormap jet; axis tight;
view(45, 45);
title('Gaussian pdf 3D','fontsize',20);

% 2차원 그리기
figure(5),surface(x,y,z1);
hold on
surface(x,y,z2);
colormap jet; axis tight;
title('Gaussian pdf 2D','fontsize',20);



%% Test signal --------------------------------------------------------------
load signal_test1.mat;
load signal_test2.mat;

%% plot 그리기
% 시간축에 대해 test signal plot
figure(6),
plot(t,signal_test1+1,'b'); %위로 shift
hold on;
plot(t,signal_test2-1,'r');

% 셋팅
set(gca,'ytick',[]);
ylabel('Signal_ test2              Signal_ test1','fontsize',16);
title('Test Signal','fontsize',20);

%% hw2 _ spectrogram
% test signal1
figure(7),subplot(1,2,1);
[st1, ft1, tt1, pst1] = spectrogram(signal_test1, window, overlap, nfft,Fs,'yaxis'); %ps 뽑아내기
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
% 위에서 뽑아낸 ps로 test signal의 feature 추출 -> psd 평균값
feature1_test1  = mean(pst1(1:(length(ft1)+1)/2,:),1);
feature2_test1  = mean(pst1((length(ft1)+1)/2:length(ft1),:),1);
feature1_test2  = mean(pst2(1:(length(ft2)+1)/2,:),1);
feature2_test2  = mean(pst2((length(ft2)+1)/2:length(ft2),:),1);

% 그리기
figure(8),
scatter(feature1_test1,feature2_test1,'bd','filled');
hold on
scatter(feature1_test2,feature2_test2,'rd','filled');

% 셋팅
title('test features','fontsize',20);
xlabel('25Hz 이하의 psd 평균','fontsize',16);
ylabel('25Hz보다 큰 psd 평균','fontsize',16);
legend('test signal1','test signal2');
axis([0 0.0058 0 0.0014]);



%% HW3 likelihood 분석(ML)-------------------------------------------------------
% 자료
xtest1 = feature1_test1;
ytest1 = feature2_test1;
xtest2 = feature1_test2;
ytest2 = feature2_test2;

% 공간 할당
xmin1 = zeros(length(x),1);
xmin2 = zeros(length(x),1);
ymin1 = zeros(length(y),1);
ymin2 = zeros(length(y),1);

xidx1 = zeros(length(xtest1),1);
xidx2 = zeros(length(xtest2),1);
yidx1 = zeros(length(ytest1),1);
yidx2 = zeros(length(ytest2),1);

%% Test signal
% Test signal의 x좌표들을? pdf의 x벡터에서가장? 유사한 값으로 매칭시킨다.?
for i = 1:length(xtest1) % test signal의 x좌표와
    for j = 1:length(x) % pdf x축의 모든 값(50개)들 사이의 거리를 구한다. 그리고 그 값들을 저장한다.
        xmin1(j,1) = abs(xtest1(1,i)-x(1,j)); 
    end
    [val, idx] = min(xmin1); % 그중 가장 작은 값(거리가 가장 작으므로 좌표가 가장 유사하다.)의 인덱스를 저장한다. 
    xidx1(i,1) = idx;
end % 위 과정을 test signal의 199개 x좌표들에 대해서 반복한다.

% Test signal의 y좌표들을? pdf의 y벡터에서가장? 유사한 값으로 매칭시킨다.?
for i = 1:length(ytest1)
    for j = 1:length(y)
        ymin1(j,1) = abs(ytest1(1,i)-y(1,j));
    end
    [val, idx] = min(ymin1);
    yidx1(i,1) = idx;
end

% Test signal의 모든 좌표들에서 pdf값을 비교하여 큰 pdf값의 갯수를 증가시킨다.?
lk1_sig1 = 0;
lk1_sig2 = 0;
for i = 1:length(xtest1)
    if ( z1(xidx1(i),yidx1(i)) > z2(xidx1(i),yidx1(i)) ) % signal1의 pdf가 크다면
        lk1_sig1 = lk1_sig1 + 1; % signal1로 분류. 즉 갯수 하나 증가
    elseif ( z1(xidx1(i),yidx1(i)) < z2(xidx1(i),yidx1(i)) ) % signal2의 pdf가 크다면
        lk1_sig2 = lk1_sig2 + 1; % signal2로 분류
    else % 만약 확률이 같다면, 지금은 직접적으로 각각의 값들을 분류하는 것이 아니라,
         % test signal과 원래 signal들의 일치율을 보기 위함이므로 일단 둘 다 증가시키고 일치율을 계산함
        lk1_sig1 = lk1_sig1 + 1;
        lk1_sig2 = lk1_sig2 + 1;
    end
end


%% Test signal2
% x좌표 매칭
for i = 1:length(xtest2)
    for j = 1:length(x)
        xmin2(j,1) = abs(xtest2(1,i)-x(1,j));
    end
    [val, idx] = min(xmin2);
    xidx2(i,1) = idx;
end

% y좌표 매칭
for i = 1:length(ytest2)
    for j = 1:length(y)
        ymin2(j,1) = abs(ytest2(1,i)-y(1,j));
    end
    [val, idx] = min(ymin2);
    yidx2(i,1) = idx;
end

% pdf의 값 비교
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

% 일치율 계산
rate11 = lk1_sig1 / (lk1_sig1 + lk1_sig2) *100; % test1과 signal1의 일치율
rate12 = lk1_sig2 / (lk1_sig1 + lk1_sig2) *100; % test1과 signal2
rate21 = lk2_sig1 / (lk2_sig1 + lk2_sig2) *100; % test2와 signal1
rate22 = lk2_sig2 / (lk2_sig1 + lk2_sig2) *100; % test2와 signal2
