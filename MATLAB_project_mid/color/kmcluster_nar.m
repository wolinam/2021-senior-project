% ��հ��� ����ϰ� �̹����� ����ȭ ��Ű�� �Լ�
function [image_clustered,means] = kmcluster_nar(y,k)

% ���� ����-----------------------------------------------------------------------------------

image_clustered = zeros(407,608,3);%clustered �̹���
d = zeros(1,k); % distance �Լ� ��� ��� ������ ����

means = 255.*rand(1,k); % means �ʱⰪ ���� ����
new_means = zeros(1,k); % ���� ���� means���� ����� ����

idx = 1; % intensity_ary�� ���� column index
min_idx = 1; % means�� index ���� ������ ����
iteration = 0;

cols = 247456; %����� ����. ���� ���� �𸣹Ƿ� ��ü ����� ������ ������
intensity_ary = zeros(k,int8(cols)); % new means�� ����� ���� ������ ���� intensity�� ������ ���̺�.



% ���� �Լ�----------------------------------------------------------------------------------
while(true)
    convergence = round(means)==round(new_means); % convergence�� ���� ����
    flag = convergence_nar(convergence,iteration); %���� ���� ���θ� flag�� ����. �Լ� ���
    if(flag==1) % ���� means�� new means�� ������ �����ϰų�, Ƚ���� 50�� �ʰ��ϸ� �ߴ�
        break;
    else
        % 1) �̹��� ����ȭ image clustering
        for rgb = 1:3 % �ȼ����� RGB�� ����ϴ� ���� �ƴ϶�, R,G,B�� ���ؼ� �Ѳ����� ���
            for i = 1:407
                for j = 1:608
                    idx = idx+1; % �� ����� intensity�� �迭�� ���� �� �� ����� column index
                    for k_increase = 1:k % ������ ��ҿ� means ���̿� distance �Լ� ���
                        d(1,k_increase) = distance_nar(y(i,j,rgb),means(1,k_increase));
                        if(min(d)==d(1,k_increase)) % ������ ����� k���� �Ÿ� �� �ּ� �Ÿ��� �����ϱ�����.
                            min_idx = k_increase; % �ּ�. ��, ���� ����� �Ÿ��� �ִ� cluster�� ��ȣ ����
                        end
                    end
                    % ����ȭ : image_clustered�� ���� ����� cluster�� means�� ǥ��
                    image_clustered(i,j,rgb) = means(min_idx);
                    % means ����� ���� ������ ���� intensity�� ����
                    intensity_ary(min_idx,idx) = y(i,j,rgb);
                end
            end
            
            % 2) ���ο� means ��� �� ����
            for k_increase = 1:k
                % ������ ��ҵ��� intensity�� ��ճ�. ���Ӱ� ���� ��հ��� new_means�� ����
                intensity_k=nonzeros(intensity_ary(k_increase,:));
                new_means(k_increase,1)=mean(intensity_k);
                means(1,k_increase)=new_means(k_increase,1);
            end
        end
    end
    iteration = iteration +1;
end
end