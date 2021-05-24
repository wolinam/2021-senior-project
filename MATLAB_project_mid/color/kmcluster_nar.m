% 평균값을 계산하고 이미지를 군집화 시키는 함수
function [image_clustered,means] = kmcluster_nar(y,k)

% 변수 선언-----------------------------------------------------------------------------------

image_clustered = zeros(407,608,3);%clustered 이미지
d = zeros(1,k); % distance 함수 사용 출력 저장할 공간

means = 255.*rand(1,k); % means 초기값 랜덤 설정
new_means = zeros(1,k); % 새로 계산된 means값이 저장될 공간

idx = 1; % intensity_ary에 사용될 column index
min_idx = 1; % means의 index 값을 저장할 변수
iteration = 0;

cols = 247456; %요소의 개수. 열의 수를 모르므로 전체 요소의 개수로 설정함
intensity_ary = zeros(k,int8(cols)); % new means를 만들기 위해 군집에 따라 intensity를 저장한 테이블.



% 동작 함수----------------------------------------------------------------------------------
while(true)
    convergence = round(means)==round(new_means); % convergence는 수렴 조건
    flag = convergence_nar(convergence,iteration); %조건 만족 여부를 flag에 저장. 함수 사용
    if(flag==1) % 기존 means와 new means가 완전히 동일하거나, 횟수가 50을 초과하면 중단
        break;
    else
        % 1) 이미지 군집화 image clustering
        for rgb = 1:3 % 픽셀마다 RGB를 계산하는 것이 아니라, R,G,B에 대해서 한꺼번에 계산
            for i = 1:407
                for j = 1:608
                    idx = idx+1; % 각 요소의 intensity를 배열에 저장 할 때 사용할 column index
                    for k_increase = 1:k % 각각의 요소와 means 사이에 distance 함수 사용
                        d(1,k_increase) = distance_nar(y(i,j,rgb),means(1,k_increase));
                        if(min(d)==d(1,k_increase)) % 위에서 계산한 k개의 거리 중 최소 거리를 선택하기위함.
                            min_idx = k_increase; % 최소. 즉, 가장 가까운 거리에 있는 cluster의 번호 저장
                        end
                    end
                    % 군집화 : image_clustered를 가장 가까운 cluster의 means로 표현
                    image_clustered(i,j,rgb) = means(min_idx);
                    % means 계산을 위해 군집에 따라 intensity를 저장
                    intensity_ary(min_idx,idx) = y(i,j,rgb);
                end
            end
            
            % 2) 새로운 means 계산 및 저장
            for k_increase = 1:k
                % 군집된 요소들의 intensity를 평균냄. 새롭게 계산된 평균값을 new_means에 저장
                intensity_k=nonzeros(intensity_ary(k_increase,:));
                new_means(k_increase,1)=mean(intensity_k);
                means(1,k_increase)=new_means(k_increase,1);
            end
        end
    end
    iteration = iteration +1;
end
end