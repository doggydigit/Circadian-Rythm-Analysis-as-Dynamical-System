function Ex25
%%EX25 plots several histograms for different ε values.
% If the computation takes to long, reduce the value of n (line 4)
n=30;
normal=1;
if normal
    N=n;
else
    N=n/6;
end
[t,~]=Ex23(100000,n);
if n>8.5
    if n>15.5
        if n>24.5
            l=5;
        else
            l=4;
        end
    else
        l=3;
    end
else
    l=2;
end
eps=linspace(-5,0,n);
c=ceil(N/l);
%le=cell(n,1);
h=figure('units','normalized','outerposition',[0 0 1 1]);
edges=linspace(0,1,100);
for i=1:N
    s(i)=subaxis(l,c,i);
    histogram(mod(t(:,i),2*pi)/(2*pi),edges,'Normalization','pdf');
    legend(strcat('ε = ',num2str(eps(i))));
    xlabel('[2π·rad]')
end
linkaxes(s, 'x');

end

