function Pf( varargin )
%PF plots fixed points

if nargin > 3.5
    disp('Error: Too many input arguments');
    return;
end

g1=@(x,y,p) p(1)*x-p(2)*y-x.*(x.^2 + y.^2)+p(3);
g2=@(x,y,p) p(1)*y+p(2)*x-y.*(x.^2 + y.^2);
syms x y;
p=squeeze(zeros(3,1));
pftype=[NaN NaN NaN];

for i=1:nargin
    p(i)=varargin{i};
end

[xf, yf]=solve(g1(x,y,p)==0, g2(x,y,p)==0,x,y);xf=double(xf); yf=double(yf);

for i=1:length(xf)
    if abs(imag(xf(i)))<0.0001 && abs(imag(yf(i)))<0.0001
        j=[p(1)-(xf(i)^2+yf(i)^2)-2*xf(i)^2 -p(2)-2*yf(i)*xf(i); p(2)-2*yf(i)*xf(i) p(1)-(xf(i)^2+yf(i)^2)-2*yf(i)^2];
        t=trace(j);
        ei=eig(j);
        D=ei(1)*ei(2);
        if D>0
            if t<0
                pftype(i)=-1; %stable
            else
                pftype(i)=1; %unstable
            end
        else
            pftype(i)=0; %saddle
                        xf(i)
            yf(i)
        end
    end
end
for i=1:3
    switch pftype(i)
        case 1
            plot(real(xf(i)),real(yf(i)),'.m','Markersize',25);
            hold on;
        case 0
            plot(real(xf(i)),real(yf(i)),'.k','Markersize',25);
            hold on;
        case -1
            plot(real(xf(i)),real(yf(i)),'.g','Markersize',25);
            hold on;
    end
end

end

