%% CRC Dyn with 2R robot and distance sensor

clc
clear

addpath(genpath('/home/sylvain/Bureau/mtools_robot_model/matlab')) ;

%% Robot definition

clear b
d = .1 ;
m = .1 ;
r = .05 ;
XX = m*(3*r*r + d*d)/12 ; YY = XX ;
ZZ = m*r*r/12 ;
b(1) = mBody(0, [0 0 0 0], 'm', m, 'cg', [d/2 0 0].', 'I', [ XX YY ZZ 0 0 0 ]) ;
b(2) = mBody(1, [0 d 0 0], 'm', m, 'cg', [d/2 0 0].', 'I', [ XX YY ZZ 0 0 0 ]) ;

RR = mArticulatedBody(b, 'name', 'RR') ;
RR.E(1,4) = d ;

qz = zeros(2,1) ;
q = qz ; % start in std by pos

%% scene
global wP
wP = [.1 ; .1 ; 0 ; 1] ;

%% Init display
figure(1) ; clf ;
hold on ;

a = .25 ;
ws = [-a a -a a -a a] ;

RR.plot(qz, 'workspace', ws, 'maguser', .5) ;

scatter(wP(1), wP(2), 'k*')

view(2) ;

%% ODE Simulator
Y0 = [q; zeros(size(q)) ] ;
Tstep = .001 ; % 10ms ;
Tf = 10 ;
% Tf = traj.t(end) + 2*traj.T(end) ; % 10s ;
T = 0:Tstep:Tf ;
options = odeset('MaxStep', .05) ;
tic
[T,Y] = ode45(  @(t,y) CRC_dyn_2R_dist_dynamics(t, y, RR), ...
    T, Y0, options) ;
toc
q = Y(:,1:RR.n)' ;
qd = Y(:,3:4)' ;

%%

RR.plot(q, 'timevect', T) ;


