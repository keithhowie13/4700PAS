winstyle = 'docked';
% winstyle = 'normal';

set(0,'DefaultFigureWindowStyle',winstyle)
set(0,'defaultaxesfontsize',18)
set(0,'defaultaxesfontname','Times New Roman')
% set(0,'defaultfigurecolor',[1 1 1])

% clear VARIABLES;
clear
global spatialFactor;
global c_eps_0 c_mu_0 c_c c_eta_0
global simulationStopTimes;
global AsymForcing
global dels
global SurfHxLeft SurfHyLeft SurfEzLeft SurfHxRight SurfHyRight SurfEzRight



dels = 0.75;
spatialFactor = 1;

c_c = 299792458;                  % speed of light
c_eps_0 = 8.8542149e-12;          % vacuum permittivity
c_mu_0 = 1.2566370614e-6;         % vacuum permeability
c_eta_0 = sqrt(c_mu_0/c_eps_0);


tSim = 200e-15
f = 500e12;
lambda = c_c/f;

xMax{1} = 20e-6;
nx{1} = 200;
ny{1} = 0.75*nx{1};

Reg.n = 1;

% Permittivity and Permeability of the simulation space
mu{1} = ones(nx{1},ny{1})*c_mu_0;
epi{1} = ones(nx{1},ny{1})*c_eps_0;

% Establish scattering object
epi{1}(60:160,40:110)= c_eps_0*11.3;
epi{1}(62:158,41:109)= c_eps_0;
epi{1}(60:62,73:77)= c_eps_0;

epi{1}(70:160,45:105)= c_eps_0*11.3;
epi{1}(72:158,46:104)= c_eps_0;
epi{1}(153:158,45:105)= c_eps_0;

epi{1}(80:160,50:100)= c_eps_0*11.3;
epi{1}(82:165,51:99)= c_eps_0;
epi{1}(80:88,50:100)= c_eps_0;


sigma{1} = zeros(nx{1},ny{1});
sigmaH{1} = zeros(nx{1},ny{1});

% Set simulation time and spatial steps
dx = xMax{1}/nx{1};             
dt = 0.25*dx/c_c;
nSteps = round(tSim/dt*2);
yMax = ny{1}*dx;
nsteps_lamda = lambda/dx

movie = 1;
Plot.off = 0;
Plot.pl = 0;
Plot.ori = '13';
Plot.N = 100;
Plot.MaxEz = 1.1;
Plot.MaxH = Plot.MaxEz/c_eta_0;
Plot.pv = [0 0 90];
Plot.reglim = [0 xMax{1} 0 yMax];

% Establish source vector
bc{1}.NumS = 1;
bc{1}.s(1).xpos = nx{1}/(4) + 1;
bc{1}.s(1).type = 'ss';
bc{1}.s(1).fct = @PlaneWaveBC;
% bc{1}.s(2).xpos = nx{1}/(4) + 10;
% bc{1}.s(2).type = 'ss';
% bc{1}.s(2).fct = @PlaneWaveBC;
% % mag = -1/c_eta_0;
mag = 5;
phi = 0;
omega1 = f*2*pi;
omega2 = 1.2*f*2*pi;
betap = 1;
t0 = 30e-15;
st = 15e-15;
s = 0;
y0 = yMax/2;
sty = 1.5*lambda;
bc{1}.s(1).paras = {mag,phi,omega1,betap,t0,st,s,y0,sty,'s'};
bc{1}.s(2).paras = {mag,phi,omega2,betap,t0,st,s,y0,sty,'s'};

Plot.y0 = round(y0/dx);

% Configure 4 boudary types
bc{1}.xm.type = 'a';
bc{1}.xp.type = 'a';
bc{1}.ym.type = 'a';
bc{1}.yp.type = 'a';

pml.width = 20 * spatialFactor;
pml.m = 3.5;

Reg.n  = 1;
Reg.xoff{1} = 0;
Reg.yoff{1} = 0;

RunYeeReg






