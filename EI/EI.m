
L = 50;
nx = 50;
ny = 50;

dx = L/nx;
dy = L/ny;

m = nx*ny;

G = sparse(m,m);

for i = 1:nx
    for j = 1:ny
        k = j+(i-1)*ny;
        if i == 1
            G(k,k)=1;
        elseif i == nx
            G(k,k)=1;
        elseif j == 0
            G(k,k)=1;
        elseif j == ny
            G(k,k)=1;
%         elseif i>10 && i<20 && j>20 && j<30
%             G(k-ny,k) = 1/dy^2;
%             G(k-1,k) = 1/dx^2;
%             G(k,k) = -1/dx^2-1/dy^2;
%             G(k+1,k) = 1/dx^2;
%             G(k+ny,k) = 1/dy^2;
        else
            G(k-ny,k) = 1/dy^2;
            G(k-1,k) = 1/dx^2;
            G(k,k) = -2/dx^2-2/dy^2;
            G(k+1,k) = 1/dx^2;
            G(k+ny,k) = 1/dy^2;
        end
    end
end
spy(G)
[Em,D] = eigs(G,9,'SM');

alpha = diag(D)
E = zeros(nx,ny,9);
for i = 1:nx
    for j = 1:ny
        n = j+(i-1)*ny;
        E(i,j,:) = Em(n,:);
    end
end
       
surf(E(:,:,5))
