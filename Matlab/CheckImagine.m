function [ realX ] = CheckImagine( x )
%CHECKIMAGINE exchanges any imaginary number of the input matrix with NaN
realX=x;
[a,b]=size(x);
for j=1:a
for i=1:b
    if ~isreal(x(j,i))
        realX(j,i)=NaN;
    end
end
end

end