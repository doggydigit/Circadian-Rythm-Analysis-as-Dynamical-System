function Ex15(varargin)
%EX15 Creates a .gif of the varying phase portrait of the model with
%different constant  and changing parameters corresponding to the Exercises
%of the miniproject.
%The input should consist of an integer describing the Exercise number that
%the user wants to study. The covered exercises are 11, 12, 13 and 14.
%
%Example:
%
%>>Ex15(11);

switch nargin
    case 0
        Exo=14;
    case 1
        Exo=varargin{1};
    otherwise
        disp('Too many input arguments');
end

n=101;
h=figure(1);
winsize = get(h,'Position');
winsize(1:2) = [0 0];
A=moviein(n,h,winsize);
set(h,'NextPlot','replacechildren');
filename=strcat('Ex',num2str(Exo),'.gif');
Fs=linspace(0,1,n);
des=linspace(-0.8,0.8,n);
for k=1:n
    mu=1;
    switch Exo
        case 11
            de=0.2;
            F=Fs(k);
        case 12
            de=0.4;
            F=Fs(k);
        case 13
            de=des(k);
            F=0.2;           
        case 14
            de=des(k);
            F=0.5;
            
        otherwise
            disp('Bad Input Argument... You must type 11,12,13 or 14... Comon! You can do it :D');
    end
    clf;
    dx=@(x,y) mu.*x-de.*y-x.*(x.^2 + y.^2)+F;
    dy=@(x,y) mu.*y+de.*x-y.*(x.^2 + y.^2);
    [x2,y2] = meshgrid(-2:0.0404:2,-2:0.0404:2);
    u=dx(x2,y2);
    v=dy(x2,y2);
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
    x1=linspace(-2,2,1000);
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
    plot(x21,ax11,'r',x22,ax12,'r',by11,x21,'b',by12,x22,'b',x21,bx11,'r',x22,bx12,'r',ay11,x21,'b',ay12,x22,'b');
    axis([-2.5 2.5 -2.5 2.5]);
    
    if Exo > 12.5
        title(strcat('∆ = ',num2str(de)));
    else
        title(strcat('F = ',num2str(F)));
    end
    A(:,k)=getframe(h,winsize);
    im=frame2im(A(:,k));
    [B,map] = rgb2ind(im,256); 
    if k == 1;
		imwrite(B,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
	else
		imwrite(B,map,filename,'gif','WriteMode','append','DelayTime',1);
	end

    
end

%movie(h,A,1,10,winsize)

end

