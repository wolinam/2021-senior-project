%% 3차시 _ 졸작할 때 함수로 짜기! 여기 내부는 한 눈에 알아보게 깨끗해야함.
% clear all;

%% 연산자_관계연산자, 논리연산자
% 결과 값은 1 또는 0 (boolean)
% 관계연산자 : < <= > >= == ~=
% 논리연산자 : &(배열 and) | &&(스칼라 and) ||(스칼라 or) ~

%스칼라--------------------------------------------------------------------
a = 1; b = 2;
a>b %틀리니까 0
a~=b % 같지 않다

(a>2)&&(b<1) % 0&&0 = 0
(a>2)||(b<3) %a>2는 False, b<3은 True이므로 OR연산하면, 1
(a<2)&&(b>1) %1

%배열---------------------------------------------------------------------
A = 1:9; B = 9-A
a = A>4 %1x9배열. 4보다 크면 1. 1~4까지는 0. 0과1로 이루어진 배열 생성
b = B-(A-2) %B-A+2
c = ~a %~(A>4)
d = (A>2) & (A<6) %3~5

% 배열끼리 연산------------------------------------------------------------
a = [1 0 1 0 1]; b = [1 1 1 1 0]; a&b % 1 0 1 0 0
% a&&b %스칼라가 아니라서 오류

a == b % 1 0 1 0 0



%% find 함수_관계식이 참인 원소의 인덱스 찾기
% 원소의 값 비교 -> 위치 반환
% 2차원 배열 -> 출력 변수를 2개로 받는다.

%예제1---------------------------------------------------------------------
A = [10 11 15 13 12];
B1 = [1 0 1 1];
af = find(A>12) %12보다 큰 원소는 3,4번째 원소
af = find(A>1) % 1차원 배열에서는 원소의 값, 2차원 배열에서는 원소의 위치
bf = find(B1) %0이 아닌 원소 위치 찾음
bf = find(~B1) %0인 요소
A(af) %af에는 원소 위치 4,5번 들어있음. 그래서 4,5번째 원소 반환

%예제2---------------------------------------------------------------------
B = [1,2,3;4,5,6;7,8,9] %컴퓨터는 1 4 7 2 5 8 3 6 9로 저장
[x,y] = find(B>5) %2차원일 때는 출력 변수를 2개로 받으면 된다.
%x는 5보다 큰 원소의 row index. y는 5보다 큰 원소의 col index

w = find(B>2,4) %2보다 값이 큰 처음 4개 원소의 인덱스
B(w) %해당 인덱스의 원소
z = find(B>5) %5번째 이후 원소 7 8 6 9의 인덱스 반환. 3 6 8 9
B(z)

%예제3---------------------------------------------------------------------
A = -3:3 %index 1~7
x = find(abs(A)>2) %-3, 3
A(x)



%% 분석함수_max,min,sum,sort,size,length,numel
%입력변수 1차원 행렬일 때---------------------------------------------------
R = randperm(6)
max(R)
[m,n] = max(R) %m은 max, n은 원소의 위치
min(R)
mean(R) %스칼라
mean(B) %배열
mean(B(:)) %스칼라

sum(R)
sort(R)
[m,n] = sort(R) % m은 정렬된 원소, n은 원소의 원래 위치
size(R) %1x6
[m,n] = size(R)
length(R)
numel(R)

%입력변수 2차원 행렬일 때---------------------------------------------------
max(B) % 7 8 9
[m,n] = max(B) %m은 max, n은 원소의 row 위치
min(B)
[m,n] = min(B) %m은 min, n은 원소의 row 위치
mean(B) %배열
mean(B(:)) %스칼라

sum(B) %column끼리 더해서 3x3 -> 1x3출력
B = [8 6 1;3 5 4;2 9 7]
% 8 3 2 6 5 9 1 4 7
% 2 3 7 5 6 9 1 4 7
sort(B) %같은 행 안에서 정렬
[m,n] = sort(B) % m은 정렬된 원소, n은 원소의 원래 column 위치
size(B) %3x3
[m,n] = size(B) % m = row size, n = col size
length(B) %3_배열의 길이
numel(B) %9_배열 요소의 갯수

%col,row size 구하기------------------------------------------------------
data = [8 7 6 1;3 5 2 4;2 9 7 2]
time = size(data,1) %행렬 data의 row size
time = size(data,2) %행렬 data의 col size


%% 함수_같은 동작을 반복_  function output = name(input)
% 내부 변수는 해당 함수 내에서만 유효한 지역 변수임.
% 기본적으로, 현재 폴더에 있어야 함.
% 파일명과 함수명은 동일하게!
f = add_mult_div(1,2,3,4) %함수를 불러옴

x=0 %내부 함수 값에 영향을 미치지 않음. 전역변수와 지역변수
func1()

%함수 예제-----------------------------------------------------------------
load clown
imshow(x,[])
y = user_rep(x);
imshow(y,[])

