function Ex26betaSample
%EX26BETASAMPLE plots a chosen region of the bifurcation with the same algorithm than
%Ex26beta
n=3000;
ne=3000;
x=30;
[T,~]=Ex23(n,ne);
t=mod(T,2*pi)/(2*pi);
e=linspace(-5,0,ne);
p=0.9;
o=ones(p*n-x,1);
g=linspace(1,0.3,n*(1-p)+1);
ne1=round(ne*2/5);
ne2=round(ne*3/5);
for i=ne1:ne2
    plot(e(i)*o,t(x+1:p*n,i),'.','Color',[1 1 0],'Markersize',4);
    for j=p*n+1:n
        plot(e(i),t(j,i),'.','Color',[1 g(j-p*n) 0], 'Markersize',4);
    end
    hold on;
end
axis tight;
xlabel('ε');
ylabel('θ [2π·rad]');
title('Bifurcation Diagram');
end