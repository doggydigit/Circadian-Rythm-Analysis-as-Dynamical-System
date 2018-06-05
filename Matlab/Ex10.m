function Ex10(varargin)
%%Ex10 plots the phase portrait of our model.
% The input should consist of 3 parameters.
% The first should define Δ, the second F and the third μ.

switch nargin
    case 0
        de=0;
        F=0;
        p0=1;
        mu=1;
    
    case 1
        de=varargin{1};
        F =0;
        p0=1;
        mu=1;
        
    case 2
        de=varargin{1};
        F =varargin{2};
        mu=1;
        p0=1;
        
    case 3
        de=varargin{1};
        F =varargin{2};  
        mu=varargin{3};
        p0=1;
        
    otherwise   
        disp('Error: Too many input arguments');
        return
end

dx=@(x,y) mu.*x-de.*y-x.*(x.^2 + y.^2)+F ;
dy=@(x,y) mu.*y+de.*x-y.*(x.^2 + y.^2);
[x2,y2] = meshgrid(-2:0.0404:2,-2:0.0404:2);
u=dx(x2,y2);
v=dy(x2,y2);

%[nu,nv]=NormalizeVector(u,v);

nu=u;
nv=v;
for i=1:length(u)
    for j=1:length(v)
        nu(i,j)=u(i,j)/sqrt(u(i,j)^2+v(i,j)^2);
        nv(i,j)=v(i,j)/sqrt(u(i,j)^2+v(i,j)^2);
    end
end

quiver(x2,y2,nu,nv);

hold on;
ax=@(y) (-de + sqrt(de.^2 +4.*y.* (-y.^3 + mu.*y +F)))/(2.*y);
bx=@(y) (-de - sqrt(de^2 +4.*y.* (-y.^3 + mu.*y +F)))/(2.*y);
ay=@(x) (de + sqrt(de.^2 +4.*x.* (-x.^3 + mu.*x)))/(2.*x);
by=@(x) (de - sqrt(de.^2 +4.*x.* (-x.^3 + mu.*x)))/(2.*x);


x1=linspace(-2,2,10001);
x21=linspace(-2,0);
x22=linspace(0,2);
for i=1:length(x1)
    ax1(i)=ax(x1(i));
    bx1(i)=bx(x1(i));
    ay1(i)=ay(x1(i));
    by1(i)=by(x1(i));
end
for i=1:length(x21);
    bx11(i)=bx(x21(i));
    bx12(i)=bx(x22(i));
    ay11(i)=ay(x21(i));
    ay12(i)=ay(x22(i));
    ax11(i)=ax(x21(i));
    ax12(i)=ax(x22(i));
    by11(i)=by(x21(i));
    by12(i)=by(x22(i));
end
ax1=CheckImagine(ax1);
bx11=CheckImagine(bx11);
bx12=CheckImagine(bx12);
ay11=CheckImagine(ay11);
ay12=CheckImagine(ay12);
ax11=CheckImagine(ax11);
ax12=CheckImagine(ax12);
by11=CheckImagine(by11);
by12=CheckImagine(by12);
bx1=CheckImagine(bx1);
ay1=CheckImagine(ay1);
by1=CheckImagine(by1);

Pf(mu, de, F);
if(p0)
    plot(x1,ax1,'r',ay1,x1,'b',x1,bx1,'r',by1,x1,'b');
else
    plot(x21,ax11,'r',x22,ax12,'r',by11,x21,'b',by12,x22,'b',x21,bx11,'r',x22,bx12,'r',ay11,x21,'b',ay12,x22,'b');
end
hold on;

axis([-2.5 2.5 -2.5 2.5]);

end

