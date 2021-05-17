r = 5+.5*rand(100,1);         %100 random radii
ang = linspace(0,2*pi,100)';  % angles
x = r.*cos(ang)+2; y = r.*sin(ang)+3; % x,y coordinates centered [2,3]
plot(x,y,'+')
axis equal; hold on;
c = [x y ones(length(x),1)]\-(x.^2+y.^2); %least squares fit
xhat = -c(1)/2;
yhat = -c(2)/2;
rhat = sqrt(xhat^2+yhat^2-c(3));
plot(rhat*cos(ang)+xhat,rhat*sin(ang)+yhat,...
    'g','linewidth',2) %best fit circle