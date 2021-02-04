%% HW_RV1 : subplot 3�� �׸��� & �ֻ��� ���� �� 10�� Ȯ�� ����ϱ�
clear all;
close all;

%% ������ ���� �� ���� ����
uniform_distribution1 = randi([1,6],1,10000); %10000���� 1~6 ������ ����

[data1, data2, data3, data4, data5, data6] = deal(0); % ���� ����
for i = uniform_distribution1 % stem���� �׸� 3��° �׸��� ������ ����
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

% stem�� �� ǥ������, ���� �����͸� string���� ����
stem_str=cell(1,6);
for i = 1:6
    stem_str{1,i} = num2str(stem_data(1,i));
end


%% �׸���
figure,
subplot(1,3,1); histogram(uniform_distribution1,'FaceColor','b'); xlim([0 7]); ylim([0 1800]); %������׷�
subplot(1,3,2); cdfplot(uniform_distribution1); xlim([0 7]); ylim([0 1.2]); %cdf
subplot(1,3,3); stem(stem_data); xlim([0 7]); ylim([0 1]); %stem
text(1:6,stem_data,stem_str); %stem�� �� ���� �� ǥ��


%% ��հ� ǥ������ ���ϱ�
mean_data = mean(uniform_distribution1); % ���
fprintf('Empirical Expectation for dice is \n %.4f\n',mean_data);
std_data = std(uniform_distribution1); % ǥ������
fprintf('Empirical standard deviation for dice is \n %.4f\n',std_data);


%% Probability, Conditional probability
uniform_distribution2 = randi([1,6],1,10000);
count1 = 0;
count2 = 0;
count3 = 0;
% count4 = 0;

for j=1:10000 
    % �� ���� ���� 10�� �Ǵ� ���
    if((uniform_distribution1(1,j)+uniform_distribution2(1,j))==10) 
        count1 = count1 +1;
    end
    % ù ��°�� 6�̶�� �־����� ��, �� ��° �ֻ������� ���� ���� 10�� �Ǵ� ���
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

% ���� Ȯ���� �̷� Ȯ�� ��
fprintf('Empirical probability that two dice sum up to 10 is\n %.4f\n',count1/10000); % �� �� ������ ���� 10�� �� Ȯ��
fprintf('Theoretical probability is\n %.4f\n',1/12); % �̷� Ȯ��
fprintf('Empirical Conditional probability that two dice sum up to 10 is\n %.4f\n',count3/count2); % ù ��°�� 6�� ��, ���� 10�� �� Ȯ��
% ���� �߸��� �ּ�ó�� �κ� ó�� ���� ���� count4/10000�̾���
fprintf('Theoretical conditional probability is\n %.4f\n',1/6); % �̷� Ȯ��


