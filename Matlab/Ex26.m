%%EX26 plots the bifurcation diagram
%if the computation takes to long reduce the values of n,k and ne
% respectively lines 5,6 and 13

n=50000;
k=2000;
w = 2*pi/22.5;
T = 24;
epsilon = linspace(-5,0,k);
M=zeros(n,k);
theta(1) = 0;
M(1,:) = theta(1);
 ne=1000;
 edges=linspace(0,1,ne);
 B=zeros(ne,k);
 for j = 1:k-1        % it�ration sur les diff�rents epsilon
    for i=1:(n-1)   % it�ration sur les diff�rents thetas
    
 theta(i+1) = theta(i) + w*T+epsilon(j)*sin(theta(i));
 M(i+1,j) = mod(theta(i+1),2*pi)/(2*pi);
 
    end
    for i=1:n
        %ceil(ne*(M(i,j)+0.000001))
        B(ceil(ne*(M(i,j)+0.00000001)),j)=B(ceil(ne*(M(i,j)+0.00000001)),j)+1;
    end
 end

 
 imagesc(epsilon,linspace(0,1,ne),B);
 colormap(FireColor/255);
 caxis([0 50])
 %zoom on;
 set(gca,'YDir','normal');


xlabel('\epsilon','FontSize',14)
 ylabel('\theta / 2\pi','FontSize',14)
 title('Bifurcation diagramm','FontSize',14,'FontWeight','bold')
