%% ���_if_&&��||�� �� �� ����

a=3;
if(a>=4)
    display('Hello 2021')
elseif(a<4)
    display('Good luck 2021') %���� ���ǹ��� ������ ���� �ȵ�.
else
    display('Error')
end
%���������� ���������� �����.

a=1;b=2;
if((a==1)&&(b==3))
    display('Hello 2021')
else
    display('Error')
end


%% switch_if������ ���� ����_ �ڵ� ���� 1,2,3������
a=input('')
switch(a)
    case 1
        display('Case 1')
    case 2
        display('Case 2')
    case 3
        display('Case 3')
end        

prompt = '��������� �����Ͻðڽ��ϱ�? Please select 1-3\n'
a=input(prompt)
switch(a)
    case 1
        display('Case 1')
    case 2
        display('Case 2')
    case 3
        display('Case 3')
end

%% if���� switch�� ����
n = input('')
if(rem(n,2)==0) %rem(a,b) : a/b�� �������� ��ȯ��
    disp('n�� ¦���̴�.')
else
    disp('n�� Ȧ���̴�')
end

n = input('')
switch rem(n,2)
    case 0
        disp('n�� ¦���̴�')
    otherwise %case 1
        disp('n�� Ȧ���̴�')
end


%% for_for ������ = �ʱⰪ:������:������
sum=0
for i0=1:2:10
    sum=sum+i0
end
disp(sum)

%���̽��� ����Ʈó�� �迭�ȿ��� �ݺ�����
for i1=[1, 2, 3, 4, 5]
    i1
end

i1=[1, 2, 3, 4, 5]
i2 = zeros(1,5)
for i=1:numel(i1)
    i2(i) = i1(i)+10
end
i2

while(sum<100)
    sum=sum+k
    k=k+i
end
sum

%% while�� for ����
total_sum = 0
for i=1:100
    total_sum = total_sum+i;
end
total_sum

total_sum=0
i=0 %�̰� ���� & �ʱ�ȭ �� ���ֱ�. ���ϸ� �̻��� �� ����.
% �Ǵ� while�� �� �� ���� �� �ٽ� �� �� �̹� i=100�̶� ���� �� ��.
while(i<=100)
    total_sum = total_sum+i;
    i=i+1;
end
total_sum


%% �ݺ��� ����_hankel matrix_��ø
test = hankel(1:5,5:9) %�밢������ ���ڰ� ���� ���

%�Լ� ��� ���ϰ� for������ ���� �����
H=zeros(5);
for r=1:5
    for c=1:5
        H(r,c)=r+(c-1);
    end
end
disp(H)

%% visualization_plot,stem,bar,histogram,errorbar
% plot : color / linestyle / marker type
% figure / title('����','fontsize',16,'color','c')
% xlabel('�����Է�','fontsize',13)
% xlim([���� ����])  axis([x������ x����� y������ y�����])
% legend('����1','����2')
% hand on/off
% image / imagesc / colormap


% plot(x,y,'linespec')---------------------------------------------------
x=1:10;
y1=randperm(10);
y2=randperm(10);
%figure('Name','Test 1','position',[1 1 1 1]) %�̷��� ���� ������ ����. ����.
figure('Name','Test 1'),
plot(x,y1,'Linestyle','-.','Marker','d','color','c')
hold on % ���� �ǱԾ �̾ �׸�
plot(x,y2,'Linestyle',':','Marker','o','color','r')
legend('y1','y2')
title('First Plot','fontsize',16,'color','b')
xlabel('Time')
ylabel('mag')
hold off

% plot ����--------------------------------------------------------------
t = linspace(0,2*pi,1000);
y3 = sin(t); y4 = cos(t);

figure,
plot(t,y3,'--r');
hold on;
plot(t,y4,'-b');

title('Graph Example','fontsize',20);
xlabel('Time [s]','fontsize',14);
ylabel('Amplitude','fontsize',14);
xlim([0 5]); ylim([-1.5 1.5]); %axis([0 5 -1.5 1.5])
legend('sin(t)','cos(t)');
%saveas(gca,'test_image.png') %�̹��� ���Ϸ� ����


%% Subplot

x=1:10;
y1=randperm(10);
y2=randperm(10);
y3=randperm(10);
figure,
subplot(2,2,1),plot(x,y1)
subplot(2,2,2),plot(x,y2)
subplot(2,2,[3 4]),plot(x,y3)

x=imread('Clown.jpg') %mat file�� �ƴ� ���� �ٷ� load�� �� ����. imread ���
imshow(x)

% subplot ����-------------------------------------------------------------
t = linspace(0,2*pi,1000);
y3 = sin(t); y4 = cos(t);

figure,
subplot(2,2,[1,2]); plot(t,y3,'-b');
hold on; plot(t,y4,'--r');

title('Subplot Example','fontsize',20);
axis([0 5 -1.5 1.5])
legend('sin(t)','cos(t)');

subplot(2,2,3); plot(t,y3,'-b');
axis([0 5 -1.5 1.5])
subplot(2,2,4); plot(t,y4,'--r');
axis([0 5 -1.5 1.5])

