%% HW_RV1 : subplot 3개 그리기 & 주사위 눈의 합 10일 확률 계산하기
clear all;
close all;

%% 데이터 생성 및 변수 선언
uniform_distribution1 = randi([1,6],1,10000); %10000개의 1~6 데이터 생성

[data1, data2, data3, data4, data5, data6] = deal(0); % 변수 선언
for i = uniform_distribution1 % stem으로 그릴 3번째 그림의 데이터 생성
    if i==1
        data1 = data1+1;
    elseif i==2
        data2 = data2 +1;
    elseif i==3
        data3 = data3 +1;
    elseif i==4
        data4 = data4 +1;
    elseif i==5
        data5 = data5 +1;
    else
        data6 = data6 +1;
    end
end
stem_data = [data1/10000, data2/10000, data3/10000, data4/10000, data5/10000, data6/10000];

% stem에 값 표시위해, 위의 데이터를 string으로 만듦
stem_str=cell(1,6);
for i = 1:6
    stem_str{1,i} = num2str(stem_data(1,i));
end


%% 그리기
figure,
subplot(1,3,1); histogram(uniform_distribution1,'FaceColor','b'); xlim([0 7]); ylim([0 1800]); %히스토그램
subplot(1,3,2); cdfplot(uniform_distribution1); xlim([0 7]); ylim([0 1.2]); %cdf
subplot(1,3,3); stem(stem_data); xlim([0 7]); ylim([0 1]); %stem
text(1:6,stem_data,stem_str); %stem의 각 점에 값 표시


%% 평균과 표준편차 구하기
mean_data = mean(uniform_distribution1); % 평균
fprintf('Empirical Expectation for dice is \n %.4f\n',mean_data);
std_data = std(uniform_distribution1); % 표준편차
fprintf('Empirical standard deviation for dice is \n %.4f\n',std_data);


%% Probability, Conditional probability
uniform_distribution2 = randi([1,6],1,10000);
count1 = 0;
count2 = 0;
count3 = 0;
% count4 = 0;

for j=1:10000 
    % 두 눈의 합이 10이 되는 경우
    if((uniform_distribution1(1,j)+uniform_distribution2(1,j))==10) 
        count1 = count1 +1;
    end
    % 첫 번째가 6이라고 주어졌을 때, 두 번째 주사위와의 눈의 합이 10이 되는 경우
%     if((uniform_distribution2(1,j)==4))
%         count4 = count4 +1;
%     end
    if(uniform_distribution1(1,j)==6)
        count2 = count2 +1;
        if(uniform_distribution2(1,j)==4)
            count3 = count3 +1;
        end
    end
end

% 실험 확률과 이론 확률 비교
fprintf('Empirical probability that two dice sum up to 10 is\n %.4f\n',count1/10000); % 두 번 던져서 합이 10이 될 확률
fprintf('Theoretical probability is\n %.4f\n',1/12); % 이론 확률
fprintf('Empirical Conditional probability that two dice sum up to 10 is\n %.4f\n',count3/count2); % 첫 번째가 6일 때, 합이 10이 될 확률
% 원래 잘못한 주석처리 부분 처럼 했을 때는 count4/10000이었음
fprintf('Theoretical conditional probability is\n %.4f\n',1/6); % 이론 확률


