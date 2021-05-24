%% 중간 프로젝트_K-menas clustering
clear all;
%close all;

%% 이미지 불러오기
x = imread('pill_gray.jpeg');
y = double(x); % 형변환 이미지 : 원본

%% 입력 받기
k = input('군집 개수 k를 입력하세요 : ')

%% 함수 수행
[image_clustered,means_func] = kmcluster_nar(y,k); % kmcluster 함수 실행
means = means_func; % kmcluster 함수의 출력 means_func을 means에 저장
image_clustered = uint8(image_clustered); % clustered 이미지

%% 이미지 화면 출력
figure,
% subplot 이용하여 구역 나눔. 왼쪽에 원본 이미지 출력.
subplot(1,2,1), imshow(x); title('\fontsize{16} original');
% 오른쪽에 image clustered 출력. 제목 k='입력 받은 k의 값'
subplot(1,2,2), imshow(image_clustered); title(['\fontsize{16} k = ',num2str(k)]);

%% 저장
imwrite(image_clustered,'image_clustered.jpg');
