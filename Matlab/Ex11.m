%%Generates 6 figures of the phase portaits with varying F and constant Δ = 0.2
 
de = 0.2;
F=linspace(0,1,6);
n=length(F);
l=floor(sqrt(n));
c=ceil(n/l);
h=figure('units','normalized','outerposition',[0 0 1 1]);

for i=1:n
    s(i)=subaxis(l,c,i);
    Ex10(de,F(i));
    title(strcat('F = ',num2str(F(i))));
end

linkaxes(s, 'xy');


