function [t,x,y] = forwardEuler(fundx, fundy, dt, x0, y0, tmax)
% t : vecteur avec les temps t0, t1, t2,...
% u : matrice avec les approximations u0, u1, u2, ... oï¿½ u0, u1 ... sont
% vecteurs colonne
% un sera l'approxiamtion de y(tn)
% Attention: les index de matlab demarre en 1 !!
% Donc u(1,:) represente u0 et de meme t(1) represente t0

it = tmax/dt;

t = [0:dt:tmax];

x = zeros(1,it);
y = zeros(1,it);
x(1)= x0;
y(1)=y0;

for n = 1 : it -1
x(n+1) = x(n) + dt*fundx(x(n),y(n));

y(n+1) = y(n) + dt*fundy(x(n),y(n));
end

return