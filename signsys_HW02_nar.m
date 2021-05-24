%
% HW #2 : 그림을 이용하여 spectrogram 만들기
%       : raw signal magnitude : abs(c)
%       : psd magnitude : abs(fft(c)).^2
%       : FFT 사용    -----------------------------------------------------
close all;
clear all;

A = imread('effel.png');
AA = double(A);
a = mean(AA,3); % z축의 값을 평균내서 2차원 배열로 만듦
b = double(a)./255; % 255 -> 1
B = flipud(b); % 배열 위아래로 뒤집기

%% spectrogram
C = zeros(480,320);
for i = 1:320 % 각각의 요소들에 대해 psd, ifft
    tmp = B(:,i);
    tmp2 = sqrt(tmp); % PSD to magnitude response
    tmp3 = ifft(tmp2); % Inverse DFT 480x1 vector for 320 times
    C(:,i) = tmp3;
end
c = reshape(C,[],1); % 1차원 리스트 형태로 reshape

% c의 spectrogram을 계산하고 표시
figure, subplot(2,2,[2,4]);
spectrogram(c,1024,512,1025,'yaxis'); %세그먼트 샘플 길이 1024개, 중첩 샘플 길이 512개, 1025개 지점에 DFT를 적용
colormap colorcube;

% 셋팅
colorbar('off');
set(gca,'xtick',[],'ytick',[])
title('Spectrogram','FontSize',20);
xlabel('Time','FontSize',16);
ylabel('Frequency','FontSize',16);

%% 왼쪽 첫 번째, raw signal
mag_c = abs(c); % raw signal의 magnitude
subplot(2,2,1); plot(1:length(c),mag_c); 

% 셋팅
xlim([0 length(c)]);
set(gca,'xtick',[],'ytick',[]) % 축 없애기
title('Raw Signal (Magnitude)','FontSize',20);
xlabel('Time','FontSize',16);
ylabel('Magnitude','FontSize',16);

%% 왼쪽 두 번째, psd magnitude
psd_c = abs(fft(c)).^2; % power spectral density = <x^2(t)>
subplot(2,2,3); plot(1:length(psd_c),psd_c); 

% 셋팅
xlim([0 length(c)]);
set(gca,'xtick',[],'ytick',[])
title('PSD (Magnitude)','FontSize',20);
xlabel('Frequency','FontSize',16);
ylabel('Magnitude','FontSize',16);
