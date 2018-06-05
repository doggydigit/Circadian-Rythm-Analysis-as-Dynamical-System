
%représentation des trajectoires dans le plan (x,y) pour différent mu
%(point6)

T=24.5;
w= 2*pi/T;
mu=1;
dy = @(x,y) mu*y+w*x-y*x.^2-y.^3;
dx = @(x,y) x*mu-w*y-x.^3-x*y.^2;
[t,x,y]= forwardEuler(dx,dy,0.01,0.1,0.1,100);
plot(x,y,'b');

hold on;
xlabel('x')
ylabel('y')
title('Trajectories for different mu in the (x,y) plane')

mu=2.5;
dy = @(x,y) mu*y+w*x-y*x.^2-y.^3;
dx = @(x,y) x*mu-w*y-x.^3-x*y.^2;
[t,x,y]= forwardEuler(dx,dy,0.01,-0.5,0.6,100);
plot(x,y,'k');

mu = 5;
dy = @(x,y) mu*y+w*x-y*x.^2-y.^3;
dx = @(x,y) x*mu-w*y-x.^3-x*y.^2;
[t,x,y]= forwardEuler(dx,dy,0.01,-0.7,-0.3,100);
plot(x,y,'r');
hold on
plot(0,0,'.m','Markersize',20);

legend('mu=1','mu=2.5','mu = 5')


