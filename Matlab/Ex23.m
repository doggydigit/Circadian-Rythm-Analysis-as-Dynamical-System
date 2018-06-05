function [t,nepsilon,T]=Ex23(varargin)
%EX23 returns a nxm matrix with n thetas and m epsilons
%   Detailed explanation goes here
t0=0;
switch nargin
    case 0
        ntheta=100;
        nepsilon=100;
    case 1
        ntheta=varargin{1};
        nepsilon =100;
    case 2
        ntheta=varargin{1};
        nepsilon =varargin{2};
    otherwise   
        disp('Error: Too many input arguments');
        return
end
t=zeros(ntheta,nepsilon);
T=27.437;
wT=2*pi*T/24.5;
e=linspace(-5,0,nepsilon);
for i=1:nepsilon
    t(1,i)=t0;
    for j=2:ntheta
        t(j,i)=t(j-1,i)+wT+e(i)*sin(t(j-1,i));
    end
end


end