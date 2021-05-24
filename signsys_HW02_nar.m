%
% HW #2 : �׸��� �̿��Ͽ� spectrogram �����
%       : raw signal magnitude : abs(c)
%       : psd magnitude : abs(fft(c)).^2
%       : FFT ���    -----------------------------------------------------
close all;
clear all;

A = imread('effel.png');
AA = double(A);
a = mean(AA,3); % z���� ���� ��ճ��� 2���� �迭�� ����
b = double(a)./255; % 255 -> 1
B = flipud(b); % �迭 ���Ʒ��� ������

%% spectrogram
C = zeros(480,320);
for i = 1:320 % ������ ��ҵ鿡 ���� psd, ifft
    tmp = B(:,i);
    tmp2 = sqrt(tmp); % PSD to magnitude response
    tmp3 = ifft(tmp2); % Inverse DFT 480x1 vector for 320 times
    C(:,i) = tmp3;
end
c = reshape(C,[],1); % 1���� ����Ʈ ���·� reshape

% c�� spectrogram�� ����ϰ� ǥ��
figure, subplot(2,2,[2,4]);
spectrogram(c,1024,512,1025,'yaxis'); %���׸�Ʈ ���� ���� 1024��, ��ø ���� ���� 512��, 1025�� ������ DFT�� ����
colormap colorcube;

% ����
colorbar('off');
set(gca,'xtick',[],'ytick',[])
title('Spectrogram','FontSize',20);
xlabel('Time','FontSize',16);
ylabel('Frequency','FontSize',16);

%% ���� ù ��°, raw signal
mag_c = abs(c); % raw signal�� magnitude
subplot(2,2,1); plot(1:length(c),mag_c); 

% ����
xlim([0 length(c)]);
set(gca,'xtick',[],'ytick',[]) % �� ���ֱ�
title('Raw Signal (Magnitude)','FontSize',20);
xlabel('Time','FontSize',16);
ylabel('Magnitude','FontSize',16);

%% ���� �� ��°, psd magnitude
psd_c = abs(fft(c)).^2; % power spectral density = <x^2(t)>
subplot(2,2,3); plot(1:length(psd_c),psd_c); 

% ����
xlim([0 length(c)]);
set(gca,'xtick',[],'ytick',[])
title('PSD (Magnitude)','FontSize',20);
xlabel('Frequency','FontSize',16);
ylabel('Magnitude','FontSize',16);
