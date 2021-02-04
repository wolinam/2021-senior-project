clear all;
close all;

%% ������ ���� �� ���� ����
% ���� ����
iteration = 10:30:100000; % ���� �ð��� �ʹ� �����ɷ��� ������ 30���� ����
Pi = zeros(1,numel(iteration)); % �� iteration���� ���� ���̰��� �� �迭


%% ����
% ī��Ʈ �ʱ�ȭ�ϰ� ���� �Ź� ���� ��� ���
for i = iteration
    count = 0;
    x = rand(1,i); % iteration=10�� ���� ���� 10��. iteration=100�� ���� ���� 100��
    y = rand(1,i);
    for j = 1:i %�Ÿ��� 1���� ���� �� ī��Ʈ
        if ( sqrt(x(1,j)^2 + y(1,j)^2) ) < 1
            count = count+1;
        end
    end
    Pi(1,i) = 4*count/i; %1���� ���� ���� ������ ��ü ���� ���� ����*4�� �� Ƚ��(iteration)���� ����
end
Pi = nonzeros(Pi); % ������ 30�̹Ƿ� �߰��� ������ ����. �װ��� �����ֱ� ����.


%% �׸��� & ��� â�� ���
figure,
semilogx(iteration,Pi); %monte-carlo % plot(iteration,Pi);
hold on;
semilogx(iteration,pi.*ones(1,numel(iteration)),'r'); % 3.14 ����

ylim([1 4]); set(gca,'YTick',[1:0.5:4]); % y�� ����
legend('Monte-Carlo Estimation','��'); % ����
ylabel('Estimated ��'); xlabel('iteration'); % ���̺�

fprintf('Estimated Pi is\n %.4f\n',Pi(length(Pi),1)); % ����ī���ι����� ����� ����
fprintf('Exact Pi is\n %.4f\n',pi); % ��Ȯ�� ���� ���

