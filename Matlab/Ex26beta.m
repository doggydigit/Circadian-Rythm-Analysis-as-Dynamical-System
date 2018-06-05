function Ex26beta
%%EX26BETA plots a bifuration diagram with another algorithm than Ex26.
% Carefull! This computation is very expensive!
n=1000;
ne=1000;
x=30;
[T,~]=Ex23(n,ne);
t=mod(T,2*pi)/(2*pi);
e=linspace(-5,0,ne);
p=0.8;
o=ones(p*n-x,1);
g=linspace(1,0.3,n*(1-p)+1);
for i=1:ne
    plot(e(i)*o,t(x+1:p*n,i),'.','Color',[1 1 0]);
    for j=p*n+1:n
        plot(e(i),t(j,i),'.','Color',[1 g(j-p*n) 0]);
    end
    hold on;
end
xlabel('ε');
ylabel('θ [2π·rad]');
title('Bifurcation Diagram');
end

