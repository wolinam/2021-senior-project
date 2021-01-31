t = 0:pi/30:2*pi;

%그림1--------------------------------------------------------------------
figure; subplot(2,2,1);
for t=0:pi/30:pi/6
    plot(t,sin(t),'gx');
    hold on
end
for t=pi/5:pi/30:5*pi/6
    plot(t,sin(t),'bd');
    hold on
end
for t=26*pi/30:pi/30:7*pi/6
    plot(t,sin(t),'gx');
    hold on
end
for t=6*pi/5:pi/30:11*pi/6
    plot(t,sin(t),'rs');
    hold on
end
for t=28*pi/15:pi/30:2*pi
    plot(t,sin(t),'gx');
    hold on
end
set(gca,'YTick',[-1:0.5:1]);
set(gca,'XTick',[0:2:6]);
hold off

%그림2---------------------------------------------------------------------
subplot(2,2,2);
for t=0:pi/30:pi/6
    plot(t,sin(t),'gx');
    stem(t,sin(t),':gx');
    hold on
end
for t=pi/5:pi/30:5*pi/6
    plot(t,sin(t),'bd');
    stem(t,sin(t),':bd');
    hold on
end
for t=26*pi/30:pi/30:7*pi/6
    plot(t,sin(t),'gx');
    stem(t,sin(t),':gx');
    hold on
end
for t=6*pi/5:pi/30:11*pi/6
    plot(t,sin(t),'rs');
    stem(t,sin(t),':rs');
    hold on
end
for t=28*pi/15:pi/30:2*pi
    plot(t,sin(t),'gx');
    stem(t,sin(t),':gx');
    hold on
end
set(gca,'YTick',[-1:0.5:1]);
set(gca,'XTick',[0:2:6]);
hold off


%그림3---------------------------------------------------------------------
subplot(2,2,3);
for t=0:pi/30:pi/6
    bar(t,sin(t),0.105,'g');
    hold on
end
for t=pi/5:pi/30:5*pi/6
    bar(t,sin(t),0.105,'b');
    hold on
end
for t=26*pi/30:pi/30:7*pi/6
    bar(t,sin(t),0.105,'g');
    hold on
end
for t=6*pi/5:pi/30:11*pi/6
    bar(t,sin(t),0.105,'r');
    hold on
end
for t=28*pi/15:pi/30:2*pi
    bar(t,sin(t),0.105','g');
    hold on
end
set(gca,'YTick',[-1:0.5:1]);
set(gca,'XTick',[0:2:6]);
hold off

%그림3---------------------------------------------------------------------
subplot(2,2,4);
H = hankel(0:60,60:120);
imagesc(H);
colormap('jet');