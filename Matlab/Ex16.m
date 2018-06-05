function Ex16
%EX16 plots a figure depicting the Arnold tongues of the model. Yellow
%squares correspond to synchronization states, while blue states describe
%asychronous states
%   If the computation time is to long, n should be reduced (LINE 13).

mu=1;
g1=@(x,y,d,f) mu.*x-d.*y-x.*(x.^2 + y.^2)+f;
g2=@(x,y,d) mu.*y+d.*x-y.*(x.^2 + y.^2);
syms x y;
a=0;
b=1;
n=11;
M=zeros(n);
xax=linspace(-0.8,0.8,n);
yax=linspace(0,1,n);

for de=xax
    a=a+1;
    for F=yax
        [xf, yf]=solve(g1(x,y,de,F)==0, g2(x,y,de)==0,x,y);
        xf=double(xf);        xf=double(xf);

        yf=double(yf);
        npf=0;
        for i=1:length(xf)
            if abs(imag(xf(i))) < 0.0001 && abs(imag(yf(i))) < 0.0001
%             j=[1-(xf(i)^2+yf(i)^2)-2*xf(i)^2 -de-2*yf(i)*xf(i); de-2*yf(i)*xf(i) 1-(xf(i)^2+yf(i)^2)-2*yf(i)^2];
%             t=trace(j);
%             ei=eig(j);
%             D=ei(1)*ei(2);
%             if D>0
%                 if t<0
                    npf=npf+1;
%                 end
%             end
            end
        end
        M(b,a)=npf;
        b=b+1;
    end
    b=1;
end
size(xax)
size(yax)
size(M)
surf(xax,yax,M);
axis tight;
xlabel('∆');
ylabel('F');
title('Arnold tongues in (∆,F) plane');
view(0,90);
colorbar;


end

