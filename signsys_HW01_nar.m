%
% HW #1 : �ְ�� ��ȣ ����� Ȯ���ϱ�
%       : Fs = 125Hz
%       : �ְ�� ��ȣ�� Fs = 6.25Hz
%       : FFT ���

%���� ���� �� �������� mag_origin = sqrt(Y_ori.*conj(Y_ori)).^2/n_origin/(2*Fs);
%��ȣ���� :: x=cos(2*pi*f/Fs*n) --------------------------------------------------------------

close all;
clear all;

%% Time Domain
% �⺻ ����
f = 5;  % fundamental frequency
Fs = 125; % Fs > (2*fmax) : �� �ֱ⿡ �ּ� 2 ���� �̻��� �����Ͱ� �ʿ�
Fs_aliasing = 6.25;

% Original
t_origin = 0:(1/Fs):4; %sampling frequency : 125Hz
original = cos(2*pi*f*t_origin); %���� ��ȣ ����

% Sampled signal
t_sample = 0:(1/Fs_aliasing):4; %sampling frequency : 6.25Hz
sampled = cos(2*pi*f*t_sample); %�ְ�� ��ȣ ����

% �׸���
figure,subplot(2,1,1);
plot(t_origin,original,'b','LineWidth',1);
hold on
stem(t_sample,sampled,'r','filled','LineWidth',1);

% ����
set(gca,'fontsize',14,'XTick',[0:0.5:4],'YTick',[-1:0.5:1]);
legend('Original','Sampled');
title('Example of Aliasing (Time Domain)','FontSize',20);
xlabel('Time (sec)','FontSize',16);
ylabel('Amplitude','FontSize',16);


%% Frequency Domain
% Original
n_origin = length(original); %���� ��ȣ ���ü�
Y_ori = fft(original); %���� ��ȣ fft
mag_origin = abs(Y_ori/n_origin); % ���� ��ȣ�� magnitude
shift_origin = fftshift(mag_origin); % y�� : shift�� ���� ��ȣ
f_origin = (-n_origin/2:n_origin/2-1)*(Fs/n_origin); % x�� : frequency

% Sampled
n_sample = length(sampled); %�ְ�� ��ȣ ���ü�
Y_sampled = fft(sampled); %�ְ�� ��ȣ fft
mag_sampled = abs(Y_sampled/n_sample); % �ְ�� ��ȣ�� magnitude
shift_sampled = fftshift(mag_sampled); % y�� : shift�� ���� ��ȣ
f_sampled = (-n_sample/2:n_sample/2-1)*(Fs_aliasing/n_sample); % x�� : frequency

% �׸���
subplot(2,1,2);
plot(f_origin,shift_origin,'b','LineWidth',1);
hold on
plot(f_sampled,shift_sampled,'r','LineWidth',1);

% ����
legend('Original','Sampled');
set(gca,'fontsize',14,'XTick',[-10:2:10],'YTick',[0:0.1:0.5]);
axis([-10 10 0 0.5]);
title('Example of Aliasing (Frequency Domain)','FontSize',20);
xlabel('Frequency (Hz)','FontSize',16);
ylabel('Magnitude','FontSize',16);


%% �ְ�� ��ȣ�� fundamental frequency
[magmax,idx] = max(shift_sampled); % �ְ�� ��ȣ�� fundamental frequency index ã��
x = abs(f_sampled(idx)); % �ְ�� ��ȣ�� fundamental frequency
y = shift_sampled(idx); % fundamental frequency������ y��ǥ
text(x,y,[num2str(x),'Hz'],'color','r','fontsize',14); % �ش� ��ǥ�� ���ļ� ǥ��

