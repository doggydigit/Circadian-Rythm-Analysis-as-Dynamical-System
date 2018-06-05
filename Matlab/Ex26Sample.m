function Ex26Sample
%EX26SAMPLE plots a chosen region of the bifurcation with the same algorithm than
%Ex26

n=20000;
k=5000;
w = 2*pi/24.5;
T = 27;
epsilon = linspace(-5,0,k);
M=zeros(n,k);
theta(1) = 0;
M(1,:) = theta(1);
ne=1000;
edges=linspace(0,1,ne);
ne1=round(k*2/5);
ne2=round(k*3/5);
dn=ne2-ne1+1;
eee=linspace(-3,-2,dn);
B=zeros(ne,dn);

for j = ne1:ne2
    for i=1:(n-1)       
        theta(i+1) = theta(i) + w*T+epsilon(j)*sin(theta(i));
        M(i+1,j) = mod(theta(i+1),2*pi)/(2*pi);
    end
    for i=1:n
        B(ceil(ne*(M(i,j)+0.00000001)),j-ne1+1)=B(ceil(ne*(M(i,j)+0.00000001)),j-ne1+1)+1;
    end
end

axis tight;
imagesc(eee,linspace(0,1,ne),B);
colormap(FireColor/255);
caxis([0 50]);
set(gca,'YDir','normal');
xlabel('\epsilon','FontSize',14);
ylabel('\theta / 2\pi','FontSize',14);
title('Bifurcation diagramm','FontSize',14,'FontWeight','bold');
 
end

