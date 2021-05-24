%% �߰� ������Ʈ_K-menas clustering
clear all;
%close all;

%% �̹��� �ҷ�����
x = imread('pill_gray.jpeg');
y = double(x); % ����ȯ �̹��� : ����

%% �Է� �ޱ�
k = input('���� ���� k�� �Է��ϼ��� : ')

%% �Լ� ����
[image_clustered,means_func] = kmcluster_nar(y,k); % kmcluster �Լ� ����
means = means_func; % kmcluster �Լ��� ��� means_func�� means�� ����
image_clustered = uint8(image_clustered); % clustered �̹���

%% �̹��� ȭ�� ���
figure,
% subplot �̿��Ͽ� ���� ����. ���ʿ� ���� �̹��� ���.
subplot(1,2,1), imshow(x); title('\fontsize{16} original');
% �����ʿ� image clustered ���. ���� k='�Է� ���� k�� ��'
subplot(1,2,2), imshow(image_clustered); title(['\fontsize{16} k = ',num2str(k)]);

%% ����
imwrite(image_clustered,'image_clustered.jpg');
