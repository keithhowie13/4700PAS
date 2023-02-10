
Iter = 4000;
nx = 50;
ny = 50;

Va = zeros(nx,ny);
Vb = zeros(nx,ny);

V1(1,:) = 1;

for k = 1:Iter
    for i = 1:nx
        for j = 1:ny
            if(i==1)
                Vb(i,j) = 1;
            elseif(i==nx)
                Vb(i,j) = 1;
            elseif(j<ny && j>1)
                Vb(i,j) = (Va(i+1,j) + Va(i-1,j) + Va(i,j+1) + Va(i,j-1))/4;
            elseif(j==ny)
                %Vb(i,j) = Vb(i,j-1);
                Vb(i,j) = 0;
            elseif(j==1)
                %Vb(i,j) = Vb(i,j+1);
                Vb(i,j) = 0;
            end     
        end
    end
    Va = Vb;
    [Ex,Ey] = gradient(Vb);

subplot(2,2,1)
        surf(Vb,'EdgeColor','none')
        title('V(x,y)')
        xlabel('Y')
        ylabel('X')
        xlim([0,nx])
        ylim([0,ny])
        view(90,90)
    subplot(2,2,2)
        quiver(Ey,Ex,10)
    subplot(2,2,3)
        plot(Vb(nx/2,:))
        title('V(x=25)')
        xlabel('Y')
        ylabel('V(y)')
        ylim([0,1])
        xlim([0,nx])
    subplot(2,2,4)
        plot(Vb(:,ny/2))
        title('V(y=25)')
        xlabel('X')
        ylabel('V(x)')
        ylim([0,1])
        xlim([0,ny])
    pause(0.01)
end

% [Ex,Ey] = gradient(Vb);
% 
% subplot(2,2,1)
%         surf(Vb,'EdgeColor','none')
%         title('V(x,y)')
%         xlabel('Y')
%         ylabel('X')
%         xlim([0,nx])
%         ylim([0,ny])
%         view(90,90)
%     subplot(2,2,2)
%         quiver(Ey,Ex,10)
%     subplot(2,2,3)
%         plot(Vb(nx/2,:))
%         title('V(x=25)')
%         xlabel('Y')
%         ylabel('V(y)')
%         ylim([0,1])
%         xlim([0,nx])
%     subplot(2,2,4)
%         plot(Vb(:,ny/2))
%         title('V(y=25)')
%         xlabel('X')
%         ylabel('V(x)')
%         ylim([0,1])
%         xlim([0,ny])
% %imboxfilt(Vb,3)
