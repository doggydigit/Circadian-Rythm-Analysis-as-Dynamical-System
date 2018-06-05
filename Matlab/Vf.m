function Vf(p)
%VF plots the vector field
dx=@(x,y,p) p(1).*x-p(2).*y-x.*(x.^2 + y.^2)+p(3) ;
dy=@(x,y,p) p(1).*y+p(2).*x-y.*(x.^2 + y.^2);
[x2,y2] = meshgrid(-2:0.0606:2,-2:0.0606:2);
u=dx(x2,y2,p);
v=dy(x2,y2,p);
nu=u;
nv=v;
for i=1:length(u)
    for j=1:length(v)
        nu(i,j)=u(i,j)/sqrt(u(i,j)^2+v(i,j)^2);
        nv(i,j)=v(i,j)/sqrt(u(i,j)^2+v(i,j)^2);
    end
end

quiver(x2,y2,nu,nv,'b');

end

