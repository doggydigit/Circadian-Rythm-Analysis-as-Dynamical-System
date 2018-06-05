function Ex17
%EX17 plots two graphs; one depicting the amplitude and the other the relative phase of the synchronized state of
%the model with varying ∆ and for a range of different F values.
%   If the computation takes to long, reduce nF and/or n (LINES 5 and 9).
nF=8;
g1=@(x,y,d,f) x-d.*y-x.*(x.^2 + y.^2)+f;
g2=@(x,y,d) y+d.*x-y.*(x.^2 + y.^2);
syms x y;
n=16;
rf=squeeze(zeros(2,nF,n));
Fs=linspace(0,1,nF);
for nf=1:nF
    F=Fs(nf);
    a=1;
    for de = linspace(-F,F,n)
        [xf, yf]=solve(g1(x,y,de,F)==0, g2(x,y,de)==0,x,y);
        xf=double(xf);
        yf=double(yf);
        r= sqrt(xf.^2+yf.^2);
        d=atan(yf./xf);
        for i=1:length(xf)
            j=[1-(xf(i)^2+yf(i)^2)-2*xf(i)^2 -de-2*yf(i)*xf(i); de-2*yf(i)*xf(i) 1-(xf(i)^2+yf(i)^2)-2*yf(i)^2];
            t=trace(j);
            ei=eig(j);
            D=ei(1)*ei(2);
            if D>0 && t<0
                rf(1,nf,a)=r(i);
                rf(2,nf,a)=d(i);
            end
        end
        a=1+a;
    end
end

ax(1,:)=[-1 1 1 1.4];
ax(2,:)=[-1 1 -1.5 1.5];
ylab{1}='Amplitude';
ylab{2}='Relative Phase'; 


for i=1:2
    s(i)=subaxis(1,2,i);
    for nf=1:nF
        plot(linspace(-Fs(nf),Fs(nf),n), squeeze(rf(i,nf,:)));
        le{nf}=(strcat('F = ',num2str(Fs(nf))));
        hold on;
    end
    axis(ax(i,:));
    legend(le);
    xlabel('∆');
    ylabel(ylab{i});
    hold off;
end

end


