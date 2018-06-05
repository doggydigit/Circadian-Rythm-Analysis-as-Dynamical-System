%%Generates 8 figures of the phase portaits with varying Δ and constant F= 0.2 

F = 0.2;

de=[-0.8 -0.4 -0.1 0 0.3 0.5 0.6 0.8];
n=length(de);    
l=floor(sqrt(n));
c=ceil(n/l);
h=figure('units','normalized','outerposition',[0 0 1 1]);

for i=1:n
    s(i)=subaxis(l,c,i);
    Ex10(de(i),F);
    title(strcat('Δ = ',num2str(de(i))));
end

linkaxes(s, 'xy');


