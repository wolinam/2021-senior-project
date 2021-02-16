clear all
close all

mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];
x1 = -3:0.2:3;
x2 = -3:0.2:3;
[mu, sigma] = normfit(x1,x2);

[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));

surf(x1,x2,y)

caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
axis([-3 3 -3 3 0 0.4])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
colormap jet;
axis tight;