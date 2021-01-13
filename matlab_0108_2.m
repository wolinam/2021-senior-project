%% 2��° ppt

%% 3���� ��� & Cell
ThreeD=[1 2 3]
ThreeD(2)=1+1j %������ ���ҵ� 1+0j ������ �ٲ�
ThreeD1 = ones(1,2,3) %1x2 ��� 3��

%�����͸� �����ϰ�, ���� ��¥ ���, ���� ������ �����͵鵵 ����ؾ���. �׷��� �����͵��� ũ�Ⱑ �ٸ� �� ���� ���
%�ڷ����� �ٸ� �����͸� �� ���� ������ ������ ��, cell�� ���
C=cell(1,3)
C{1,1} = 'NSPL' %���� ù ��°�� ���ڿ� ����
C{1,2}=ones(2,2) %���� �� ��°�� 2���� ��� ����
C{1,3}=ones(2,2,2) %���� �� ��°�� 3���� ��� ����
%���� ������ ���� �߰�ȣ!


%�̰� �� ������. ���� ����� ���� �ٲ� �� ����. �׷��� ��ķ� ������ �� ������ ���� ���� ������ �ʿ� ����.
B0=magic(5)
% matrix -> cell
%matrix B0�� cell�� ��ȯ. [1,3,1]�� ���� �� ���� ����. [2,3]�� ���� �� ���� ����
T2=mat2cell(B0,[1,3,1],[2 3])
% cell -> matrix
T3=cell2mat(T2)


%% ��� �� ���� ����

% EX1.
E0 = eye(3)
B2 = magic(3)
E1 = E0(1:3,1)
E2 = E0(2,1:2) %2��° ��, 1~2��° ��
E3 = B2([2 1],:)

% EX2.
B3 = magic(4)
E4 = B3(:,2)
E5 = B3(2:3,2:3)


%% ��� ��ġ��_Matrix merging

M0 = cat(1,B3,B3) %1�� �������� ��� �� ���� ����. 1�� ���� ����
M1 = [B3;B3] %���� �Ȱ���

M3 = cat(2,B3,B3) %2�� �������� ��� �� ���� ����. 2�� ���� ����
M4 = [B3 B3]

%% Transpose

B2
B2'

%% ������ flip

fliplr(B2) %�¿� ������
flipud(B2) %���� ������

%% Reshpae

pi=[1,2,3,4,5,6,7,8]
R1=reshape(pi,4,2)
R1T=reshape(pi,4,2)' %��ȯ�� ũ�� �׻� Ȯ��. ���� ���� ������, ������ ���� ������ ���
R2 = reshape(B3(1:2,1:3),3,2) %������ �Ϻ� 2X3�� 3X2�� �ٲ�.
R3 = reshape(R2,6,1)

%% ���� �� �þ����_Replication and tiling

Rr0=[1;2;3]
Rr1=repmat(Rr0,2,5) %R0�� ������ 2��, ���� 5�� ����

%% ȸ��_rotation

Rot0 = rot90( B3(1:2,1:2), 1) %90����ŭ �� �� ȸ��
Rot1 = rot90( B3(1:2,1:2), 3) %90����ŭ �� �� ȸ��

%% ��� �Ϻ� ����

Rr1(:,1)=[] %ù ��° �� ��ü ����
Rr1(2,:)=[] %�� ��° �� ����

% Ex.
B4 = B3
B4(3,:)=[] %3x4
R4 = reshape(B4,6,2)
F0 = flipud(R4)
Rr2 = repmat(F0,1,2)

%% �ﰢ�Լ�_sin,cos,tan,sinh,cosh,tanh

t = linspace(0,10,1000); %0���� 10���� 1000���� �ɰ�
% t = [0:0.001:10] % ���� ����
y0 = sin(2*pi*0.5*t)
y1 = cos(2*pi*0.5*t)

plot(t,y0)
hold on %���ļ� �׸� �� ����
plot(t,y1)

%% �����Լ�
y2 = exp(t)
plot(t,y2)
plot(t,t.^2) %�����Լ� ������

y3 = log(t) %���� e
plot(t,y3)
y4 = log10(t) %�α��� ���� 10
plot(t,y4)
y5 = log2(t) %�α��� ���� 2
plot(t,y5)

% Ex.
y2 = exp(t)
plot(t,y2)
hold on
y3 = log(t)
plot(t,y3)
legend('exp','log','location','southeast')

%% �Ҽ��� ó��

a_round = round(pi) %�ݿø�
a_ceil=ceil(pi) %�ø�
a_floor=floor(pi) %����
a_fix = fix(pi) %0�� ���� ���� �Ǵ� �ø�

%% ���Ҽ� ����� �� -> radar, fourier ��ȯ ��

a=1+2j
a_abs=abs(a) %mag
a_angle=angle(a) %phase
a_sqrt=sqrt(a)

load('clown')
figrue.imshow(x)