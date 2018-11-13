%% CRC_dyn_3d_points
% Commande réérencée capteur dynamique (calcul de sdd)
% Feature: 4 points 3D mesurés par capteur de points 3D dont le repère est
% confondu avec l'effecteur du robot

%%% NOT WORKING ! %%%

clear 
clc

%% Robot : définition LWR4
mdl_lwr4 ;
q_stdby = qz ; q_stdby(4) = pi/2 ; q_stdby(6) = -pi/2 ;
q_d = q_stdby ; 
q = q_d ;% start in desired conf

q = q_stdby ;
q(1) = pi/12 ; % start in initial conf


%% Features : définitions
global wTo oP % les rend accessible dans la fonction ode à intégrer
a = .05 ;
oP = [  a a -a -a ; 
        -a a -a a ; 
        0  a  a 0 ] ;
oP(4,:) = 1 ;

wTo = eye(4) ; wTo(1,4) = .39 ; 
Obj = mArticulatedBody(mBody(), 'name', 'O') ; 
Obj.Z = wTo ;

ns = size(oP,2) ;


%% World scene display
figure(1) ; clf ; 
hold on ;

ws = [-.2 .6 -.2 .2 -.2 .6 ] ; 

% Plot Robot
lwr4.plot(q_d, 'workspace', ws) ;

% Plot object
Obj.plot(0, 'tool', false, 'jaxis', false, 'model', false, 'baselabel', '   ', 'maguser', .5, 'workspace', ws) ; 
P = wTo*oP ; 
scatter3(P(1,:), P(2,:), P(3,:), 'k*') ;


%% features trajectory
global eP_d

wTe = lwr4.T(0,7,q)*lwr4.E ; 
wTe_d = lwr4.T(0,7,q_d)*lwr4.E ;

eP = wTe\wTo*oP ;
eP_d = wTe_d\wTo*oP ;

s_traj = zeros(3*ns,2) ;
for i=1:4
    r = [1 2 3]+3*(i-1) ;
    s_traj(r,1) = eP([1 2 3],i) ;
    s_traj(r,2) = eP_d([1 2 3],i) ;
end

kv = ones(3*ns,1).*.0 ;
ka = ones(3*ns,1).*.1 ;
 
trajs = mTrajectory(s_traj, kv, ka) ; 


%% ODE Simulator 
Y0 = [q; zeros(size(q)) ] ;
Tstep = .001 ; % 10ms ;
Tf = 10 ;
% Tf = traj.t(end) + 2*traj.T(end) ; % 10s ;
T = 0:Tstep:Tf ;
options = odeset('MaxStep', .05) ;
tic
[T,Y] = ode45(  @(t,y) CRC_dyn_3d_points_dynamics(t, y, lwr4, trajs), ...
                T, Y0, options) ;
toc
q = Y(:,1:lwr4.n)' ;


%% Display results
figure(1) ;
lwr4.plot(q, 'timevect', T, 'loop', true) ;

