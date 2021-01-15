%% 제어문_if_&&와||도 쓸 수 있음

a=3;
if(a>=4)
    display('Hello 2021')
elseif(a<4)
    display('Good luck 2021') %위에 조건문이 맞으면 실행 안됨.
else
    display('Error')
end
%위에서부터 순차적으로 실행됨.

a=1;b=2;
if((a==1)&&(b==3))
    display('Hello 2021')
else
    display('Error')
end


%% switch_if문보다 조금 빠름_ 코드 버전 1,2,3있을때
a=input('')
switch(a)
    case 1
        display('Case 1')
    case 2
        display('Case 2')
    case 3
        display('Case 3')
end        

prompt = '어느버전을 실행하시겠습니까? Please select 1-3\n'
a=input(prompt)
switch(a)
    case 1
        display('Case 1')
    case 2
        display('Case 2')
    case 3
        display('Case 3')
end

%% if문과 switch문 예제
n = input('')
if(rem(n,2)==0) %rem(a,b) : a/b의 나머지를 반환함
    disp('n은 짝수이다.')
else
    disp('n은 홀수이다')
end

n = input('')
switch rem(n,2)
    case 0
        disp('n은 짝수이다')
    otherwise %case 1
        disp('n은 홀수이다')
end


%% for_for 변수명 = 초기값:증가값:최종값
sum=0
for i0=1:2:10
    sum=sum+i0
end
disp(sum)

%파이썬의 리스트처럼 배열안에서 반복가능
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

%% while과 for 예제
total_sum = 0
for i=1:100
    total_sum = total_sum+i;
end
total_sum

total_sum=0
i=0 %이거 선언 & 초기화 꼭 해주기. 안하면 이상한 값 나옴.
% 또는 while문 한 번 실행 후 다시 할 때 이미 i=100이라서 동작 안 함.
while(i<=100)
    total_sum = total_sum+i;
    i=i+1;
end
total_sum


%% 반복문 예제_hankel matrix_중첩
test = hankel(1:5,5:9) %대각선으로 숫자가 같은 행렬

%함수 사용 안하고 for문으로 헨켈 만들기
H=zeros(5);
for r=1:5
    for c=1:5
        H(r,c)=r+(c-1);
    end
end
disp(H)

%% visualization_plot,stem,bar,histogram,errorbar
% plot : color / linestyle / marker type
% figure / title('제목','fontsize',16,'color','c')
% xlabel('내용입력','fontsize',13)
% xlim([하한 상한])  axis([x축하한 x축상한 y축하한 y축상한])
% legend('범례1','범례2')
% hand on/off
% image / imagesc / colormap


% plot(x,y,'linespec')---------------------------------------------------
x=1:10;
y1=randperm(10);
y2=randperm(10);
%figure('Name','Test 1','position',[1 1 1 1]) %이러면 왼쪽 구석에 생김. 불편.
figure('Name','Test 1'),
plot(x,y1,'Linestyle','-.','Marker','d','color','c')
hold on % 같은 피규어에 이어서 그림
plot(x,y2,'Linestyle',':','Marker','o','color','r')
legend('y1','y2')
title('First Plot','fontsize',16,'color','b')
xlabel('Time')
ylabel('mag')
hold off

% plot 예제--------------------------------------------------------------
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
%saveas(gca,'test_image.png') %이미지 파일로 저장


%% Subplot

x=1:10;
y1=randperm(10);
y2=randperm(10);
y3=randperm(10);
figure,
subplot(2,2,1),plot(x,y1)
subplot(2,2,2),plot(x,y2)
subplot(2,2,[3 4]),plot(x,y3)

x=imread('Clown.jpg') %mat file이 아닌 것은 바로 load할 수 없음. imread 사용
imshow(x)

% subplot 예제-------------------------------------------------------------
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

