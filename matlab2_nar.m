% X = load('clown') % �� �̰� �ȵǴ°�? 
% clear all;
%-----------�� ���� �� �ҷ�����---------------------------------------
C=cell(2,2);
load('clown'); % �� �ڵ����� x�� ����Ǵ°�?
%-----------modified image------------------------------------------
C{1,1}=x;
C{1,2}=fliplr(x);
C{2,1}=flipud(x);
C{2,2}=flipud(fliplr(x));
%-----------down sampling-------------------------------------------
x2=cell2mat(C);
x2=downsample(x2,2,1);
x2=downsample(x2',2,1);
x2=x2';
%-----------image ���-----------------------------------------------
figure,imagesc(x2);colormap(copper);
set(gca,'xtick',[],'ytick',[])
title('Modified Image','fontweight','bold','fontsize',14)
xlabel('Reverse Left & Right')
ylabel('Reverse Up & Down')