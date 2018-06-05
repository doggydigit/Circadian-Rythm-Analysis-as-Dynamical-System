function Ex24
%EX24 plots three different plots describing the evolution of θ(n+1)
%depending on θ(n).
%
%For usage simply enter command:
%
%>> Ex24;
%
%If computation takes too long, reduce the parameter nt (LINE 11)

nt=1373151;
n=11;
[t,~,T]=Ex23(nt,n);
color=jet(n)/1.3;
figure(1)
le=cell(n,1);
eps=1:n;
epsi=linspace(-5,0,n);
pa=0.0001;


figure(1);
for i=1:n
    plot(1:(round(pa*nt)-1),squeeze(t(1:(round(pa*end)-1),eps(i))./t(2:round(pa*end),eps(i))),'Color',color(i,:));
    le{i}=strcat('ε = ',num2str(epsi(i)));
    hold on
end
legend(le);


t=mod(t,2*pi)/(2*pi);


figure(2);
for i=1:n
    le{i}=strcat('ε = ',num2str(epsi(i)));
    plot(t(1:(end-1),eps(i)),t(2:end,eps(i)),'.','Color',color(i,:));
    hold on;
end
plot(linspace(0,1),linspace(0,1),'--');
legend(le,'θ(n+1)=θ(n)');
xlabel('θ(n) [2π·rad]');
ylabel('θ(n+1) [2π·rad]');


figure(3)
np=1000;
wT=2*pi*T/24.5;
theta=@(theta,e) mod(theta+wT+e*sin(theta),2*pi)/(2*pi);
theta0=linspace(0,2*pi,np);
theta1=zeros(n,np);
temp=0;
for i=1:n
    theta1(i,:)=theta(theta0,epsi(i));
    t1=[theta1(i,:) 0.5];
    t2=[0.5 theta1(i,:)];
    Ind=find(abs(t1-t2)>0.6);
    theta1(i,Ind)=NaN;
end
for i=1:n
    le{i}=strcat('ε = ',num2str(epsi(i)));
    plot(theta0/(2*pi),theta1(i,:),'-','Color',color(i,:));
    hold on;
end
plot(linspace(0,1),linspace(0,1),'-k');
legend(le,'θ(n+1)=θ(n)');
xlabel('θ(n) [2π·rad]');
ylabel('θ(n+1) [2π·rad]');


end

