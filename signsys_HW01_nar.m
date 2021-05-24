%
% HW #1 : 왜곡된 신호 만들고 확인하기
%       : Fs = 125Hz
%       : 왜곡된 신호의 Fs = 6.25Hz
%       : FFT 사용

%과제 수행 중 시행착오 mag_origin = sqrt(Y_ori.*conj(Y_ori)).^2/n_origin/(2*Fs);
%신호생성 :: x=cos(2*pi*f/Fs*n) --------------------------------------------------------------

close all;
clear all;

%% Time Domain
% 기본 설정
f = 5;  % fundamental frequency
Fs = 125; % Fs > (2*fmax) : 한 주기에 최소 2 샘플 이상의 데이터가 필요
Fs_aliasing = 6.25;

% Original
t_origin = 0:(1/Fs):4; %sampling frequency : 125Hz
original = cos(2*pi*f*t_origin); %원본 신호 생성

% Sampled signal
t_sample = 0:(1/Fs_aliasing):4; %sampling frequency : 6.25Hz
sampled = cos(2*pi*f*t_sample); %왜곡된 신호 생성

% 그리기
figure,subplot(2,1,1);
plot(t_origin,original,'b','LineWidth',1);
hold on
stem(t_sample,sampled,'r','filled','LineWidth',1);

% 셋팅
set(gca,'fontsize',14,'XTick',[0:0.5:4],'YTick',[-1:0.5:1]);
legend('Original','Sampled');
title('Example of Aliasing (Time Domain)','FontSize',20);
xlabel('Time (sec)','FontSize',16);
ylabel('Amplitude','FontSize',16);


%% Frequency Domain
% Original
n_origin = length(original); %원본 신호 샘플수
Y_ori = fft(original); %원본 신호 fft
mag_origin = abs(Y_ori/n_origin); % 원본 신호의 magnitude
shift_origin = fftshift(mag_origin); % y축 : shift된 최종 신호
f_origin = (-n_origin/2:n_origin/2-1)*(Fs/n_origin); % x축 : frequency

% Sampled
n_sample = length(sampled); %왜곡된 신호 샘플수
Y_sampled = fft(sampled); %왜곡된 신호 fft
mag_sampled = abs(Y_sampled/n_sample); % 왜곡된 신호의 magnitude
shift_sampled = fftshift(mag_sampled); % y축 : shift된 최종 신호
f_sampled = (-n_sample/2:n_sample/2-1)*(Fs_aliasing/n_sample); % x축 : frequency

% 그리기
subplot(2,1,2);
plot(f_origin,shift_origin,'b','LineWidth',1);
hold on
plot(f_sampled,shift_sampled,'r','LineWidth',1);

% 셋팅
legend('Original','Sampled');
set(gca,'fontsize',14,'XTick',[-10:2:10],'YTick',[0:0.1:0.5]);
axis([-10 10 0 0.5]);
title('Example of Aliasing (Frequency Domain)','FontSize',20);
xlabel('Frequency (Hz)','FontSize',16);
ylabel('Magnitude','FontSize',16);


%% 왜곡된 신호의 fundamental frequency
[magmax,idx] = max(shift_sampled); % 왜곡된 신호의 fundamental frequency index 찾기
x = abs(f_sampled(idx)); % 왜곡된 신호의 fundamental frequency
y = shift_sampled(idx); % fundamental frequency에서의 y좌표
text(x,y,[num2str(x),'Hz'],'color','r','fontsize',14); % 해당 좌표에 주파수 표시

