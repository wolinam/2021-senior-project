% X = load('clown') % 왜 이건 안되는가? 
% clear all;
%-----------셀 생성 및 불러오기---------------------------------------
C=cell(2,2);
load('clown'); % 왜 자동으로 x에 저장되는가?
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
%-----------image 출력-----------------------------------------------
figure,imagesc(x2);colormap(copper);
set(gca,'xtick',[],'ytick',[])
title('Modified Image','fontweight','bold','fontsize',14)
xlabel('Reverse Left & Right')
ylabel('Reverse Up & Down')