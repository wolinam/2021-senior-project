clear all;
close all;

%% 데이터 생성 및 변수 선언
% 변수 선언
iteration = 10:30:100000; % 실행 시간이 너무 오래걸려서 간격을 30으로 설정
Pi = zeros(1,numel(iteration)); % 각 iteration마다 계산된 파이값이 들어갈 배열


%% 동작
% 카운트 초기화하고 점을 매번 새로 찍는 방법
for i = iteration
    count = 0;
    x = rand(1,i); % iteration=10일 때는 점이 10개. iteration=100일 때는 점이 100개
    y = rand(1,i);
    for j = 1:i %거리가 1보다 작은 것 카운트
        if ( sqrt(x(1,j)^2 + y(1,j)^2) ) < 1
            count = count+1;
        end
    end
    Pi(1,i) = 4*count/i; %1보다 작은 점의 갯수와 전체 점의 갯수 비율*4를 각 횟수(iteration)마다 저장
end
Pi = nonzeros(Pi); % 간격이 30이므로 중간에 공백이 있음. 그것을 없애주기 위함.


%% 그리기 & 명령 창에 출력
figure,
semilogx(iteration,Pi); %monte-carlo % plot(iteration,Pi);
hold on;
semilogx(iteration,pi.*ones(1,numel(iteration)),'r'); % 3.14 직선

ylim([1 4]); set(gca,'YTick',[1:0.5:4]); % y축 셋팅
legend('Monte-Carlo Estimation','π'); % 범례
ylabel('Estimated π'); xlabel('iteration'); % 레이블

fprintf('Estimated Pi is\n %.4f\n',Pi(length(Pi),1)); % 몬테카를로법으로 계산한 파이
fprintf('Exact Pi is\n %.4f\n',pi); % 정확한 파이 출력

