%% 2번째 ppt

%% 3차원 행렬 & Cell
ThreeD=[1 2 3]
ThreeD(2)=1+1j %나머지 원소도 1+0j 등으로 바뀜
ThreeD1 = ones(1,2,3) %1x2 행렬 3개

%데이터를 측정하고, 오늘 날짜 기록, 오늘 측정한 데이터들도 기록해야함. 그런데 데이터들의 크기가 다를 때 셀을 사용
%자료형이 다른 데이터를 한 개의 변수로 저장할 때, cell을 사용
C=cell(1,3)
C{1,1} = 'NSPL' %셀의 첫 번째에 문자열 삽입
C{1,2}=ones(2,2) %셀의 두 번째에 2차원 행렬 삽입
C{1,3}=ones(2,2,2) %셀의 세 번째에 3차원 행렬 삽입
%셀에 접근할 때는 중괄호!


%이건 잘 사용안함. 셀과 행렬을 서로 바꿀 수 있음. 그런데 행렬로 저장할 수 있으면 굳이 셀로 저장할 필요 없음.
B0=magic(5)
% matrix -> cell
%matrix B0를 cell로 변환. [1,3,1]은 셀에 들어갈 행의 갯수. [2,3]은 셀에 들어갈 열의 갯수
T2=mat2cell(B0,[1,3,1],[2 3])
% cell -> matrix
T3=cell2mat(T2)


%% 행렬 내 원소 추출

% EX1.
E0 = eye(3)
B2 = magic(3)
E1 = E0(1:3,1)
E2 = E0(2,1:2) %2번째 행, 1~2번째 열
E3 = B2([2 1],:)

% EX2.
B3 = magic(4)
E4 = B3(:,2)
E5 = B3(2:3,2:3)


%% 행렬 합치기_Matrix merging

M0 = cat(1,B3,B3) %1의 방향으로 행렬 두 개를 연결. 1은 세로 방향
M1 = [B3;B3] %위랑 똑같음

M3 = cat(2,B3,B3) %2의 방향으로 행렬 두 개를 연결. 2는 가로 방향
M4 = [B3 B3]

%% Transpose

B2
B2'

%% 뒤집기 flip

fliplr(B2) %좌우 뒤집기
flipud(B2) %상하 뒤집기

%% Reshpae

pi=[1,2,3,4,5,6,7,8]
R1=reshape(pi,4,2)
R1T=reshape(pi,4,2)' %변환시 크기 항상 확인. 열이 먼저 들어가는지, 행으로 먼저 들어가는지 등등
R2 = reshape(B3(1:2,1:3),3,2) %마방진 일부 2X3을 3X2로 바꿈.
R3 = reshape(R2,6,1)

%% 복제 및 늘어놓기_Replication and tiling

Rr0=[1;2;3]
Rr1=repmat(Rr0,2,5) %R0를 행으로 2번, 열로 5번 복제

%% 회전_rotation

Rot0 = rot90( B3(1:2,1:2), 1) %90도만큼 한 번 회전
Rot1 = rot90( B3(1:2,1:2), 3) %90도만큼 세 번 회전

%% 행렬 일부 삭제

Rr1(:,1)=[] %첫 번째 열 전체 삭제
Rr1(2,:)=[] %두 번째 행 삭제

% Ex.
B4 = B3
B4(3,:)=[] %3x4
R4 = reshape(B4,6,2)
F0 = flipud(R4)
Rr2 = repmat(F0,1,2)

%% 삼각함수_sin,cos,tan,sinh,cosh,tanh

t = linspace(0,10,1000); %0부터 10까지 1000개로 쪼갬
% t = [0:0.001:10] % 위와 동일
y0 = sin(2*pi*0.5*t)
y1 = cos(2*pi*0.5*t)

plot(t,y0)
hold on %겹쳐서 그릴 수 있음
plot(t,y1)

%% 지수함수
y2 = exp(t)
plot(t,y2)
plot(t,t.^2) %이차함수 포물선

y3 = log(t) %밑은 e
plot(t,y3)
y4 = log10(t) %로그의 밑은 10
plot(t,y4)
y5 = log2(t) %로그의 밑은 2
plot(t,y5)

% Ex.
y2 = exp(t)
plot(t,y2)
hold on
y3 = log(t)
plot(t,y3)
legend('exp','log','location','southeast')

%% 소수점 처리

a_round = round(pi) %반올림
a_ceil=ceil(pi) %올림
a_floor=floor(pi) %버림
a_fix = fix(pi) %0을 향해 버림 또는 올림

%% 복소수 계산할 때 -> radar, fourier 변환 등

a=1+2j
a_abs=abs(a) %mag
a_angle=angle(a) %phase
a_sqrt=sqrt(a)

load('clown')
figrue.imshow(x)