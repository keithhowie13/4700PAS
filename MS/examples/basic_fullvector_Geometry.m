% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rwN = [0.325,0.4,0.475,0.55,0.625,0.7,0.775,0.85,0.925,1]; % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)
% dx = 0.1;             % grid size (8 times less dense)(horizontal)
% dy = 0.1;             % grid size (8 timesless dense)(vertical)


lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute



for i=1:10
    
    rw = rwN(i);

[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');

fprintf(1,'neff = %.6f\n',neff);

neffN(i) = neff;

figure(1);
subplot(121);
contourmode(x,y,Hx);
title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

subplot(122);
contourmode(x,y,Hy);
title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)

% [Hx,Hy,neff] = wgmodes(lambda,n2,nmode,dx,dy,eps,'000S');
% 
% fprintf(1,'neff = %.6f\n',neff);
% 
% figure(2);
% subplot(121);
% contourmode(x,y,Hx(:,:,nmode));
% title('Hx (TM mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end
% 
% subplot(122);
% contourmode(x,y,Hy(:,:,nmode));
% title('Hy (TM mode)'); xlabel('x'); ylabel('y'); 
% for v = edges, line(v{:}); end

end

figure(2)
plot(rwN,neffN)
xlabel('Ridge Half-Width')
ylabel('Effective Index of Refraction')
