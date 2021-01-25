%t=0:0.1:2*pi

%% �׸�1__for/if/plot__y������ ����
figure;subplot(2,2,1)
for t=0:0.1:2*pi
    if sin(t)>0.5
        plot(t,sin(t),'bd');
        hold on
    elseif sin(t)<-0.5
        plot(t,sin(t),'rs');
        hold on
    else
        plot(t,sin(t),'gx');
        hold on
    end
end
set(gca,'XTick',[0:2:6]);
% set(gca,'YTick',[-1:0.5:1]);
hold off;
box off;


%% �׸�2__while/if/plot/stem__x�� ������ ����
t=0;
subplot(2,2,2);
while(t<=2*pi)
    if((t>7*pi/6)&&(t<=11*pi/6))
        plot(t,sin(t),'rs');
        stem(t,sin(t),':rs');
        hold on
    elseif((t>pi/6)&&(t<=5*pi/6))
        plot(t,sin(t),'bd');
        stem(t,sin(t),':bd');
        hold on
    else
        plot(t,sin(t),'gx');
        stem(t,sin(t),':gx');
        hold on
    end
    t = t+0.1;
end
set(gca,'XTick',[0:2:6]);
hold off;
box off;


%% �׸�3__for/if/bar
subplot(2,2,3);
for t=0:0.1:2*pi
    if sin(t)<-0.5
        bar(t,sin(t),0.1,'r');
        hold on
    elseif sin(t)>0.5
        bar(t,sin(t),0.1,'b');
        hold on
    else
        bar(t,sin(t),0.1,'g');
        hold on
    end
end
xlim([0 7]);
set(gca,'XTick',[0:2:6]);
hold off;
box off;



%% �׸�4__hankel/imagesc/colormap
subplot(2,2,4);
H = hankel(0:60,60:120);
imagesc(H);
colormap('jet');
set(gca,'XTick',[0:20:60]);
set(gca,'YTick',[0:20:60]);

