%% CRC Dyn with 2R robot and distance sensor
% Implementation of eq 5.2.2 from Robot control, the task function
% approach, samson1991robot.
clc
clear
% clear functions

addpath(genpath('/home/sylvain/Bureau/mtools_robot_model/matlab')) ;

rx = 1; 
ry = 2 ; 
rz = 3 ;
rxy = 1:2 ;
rxyz = 1:3 ;
r = 1:3 ; 

%% Robot definition
mdl_lwr4 ;
mdl_lwr4_6dof ;
lwr4.E(r,r) = rotz(-pi/2) ;
q = qz ;
q(4) = pi/2 ;
q(6) = -pi/2 ;

cam = CentralCamera() ;
cam.npix =  [640,480] ;
cam.pp =    [320, 240] ;
cam.rho =   [1/500, 1/500] ;

%% Scene

a = .05 ;
oP = [  a  a -a -a ;
        a -a -a  a ; 
        0  0  0  0 ] ;
oP(4,:) = 1 ;

wTo = eye(4) ; 
wTo(rx,4) = .4 ;
wP = wTo*oP ;

wTe = lwr4.T(0,lwr4.n,q)*lwr4.E ;
wTe_d = wTe ; 
wTe_d(rxy,4) = wTe_d(rxy,4) + [.05; .1] ;
% wTe_d(rz,4) = wTe_d(rz,4) + .1 ;
% wTe_d(r,r) = wTe_d(r,r)*rotz(pi/4) ; 


%% Init display

figure(1); clf ; hold on ;

scatter3(wP(1,:), wP(2,:), wP(3,:), 'k*') ;

ws = [-.2 .6 -.2 .2 0 .5] ;
lwr4.plot(q, 'workspace', ws, 'maguser', 2) ;

% cam.plot_camera('Tcam', lwr4.T(0,lwr4.n,q)*lwr4.E, 'scale', .03) ;

view([50 30]) ;

figure(2);  clf ; hold on ; 

wTe = lwr4.T(0,lwr4.n,q)*lwr4.E ;
uv = cam.project(wP(r,:),   'Tcam', wTe, '*r') ;
uv_d = cam.project(wP(r,:), 'Tcam', wTe_d, '*g') ;

scatter(uv(1,:), uv(2,:), '*r') ;
scatter(uv_d(1,:), uv_d(2,:), '*g') ;

set(gca,'Ydir', 'reverse') ;
axis equal ;
axis([0 cam.npix(1) 0 cam.npix(2)])

% return

%% ODE Simulator
Y0 = [q; zeros(size(q)) ] ;
Tstep = .02 ; % 10ms ;
Tf = 10 ;
theta = .5 ; 
precision = 1e-3 ;
nmax = 1000 ; 
% Tf = traj.t(end) + 2*traj.T(end) ; % 10s ;
T = 0:Tstep:Tf ;

% options = odeset('MaxStep', .1) ;
options = odeset() ;

tic
% [T,Y] = ode45(  @(t,y) CRC_dyn_LWR_2Dp_dyn(t, y, lwr4, cam, wP, wTe_d), ...
%     T, Y0, options) ;
[T,Y] = theta_method(  @(t,y) CRC_dyn_LWR_2Dp_dyn(t, y, lwr4, cam, wP, wTe_d), ...
    T, Y0, theta, precision, nmax) ;
toc

q = Y(:,1:lwr4.n)' ;

%% Replay
figure(1) ; lwr4.plot(q,'timevect', T) ;

n_points = size(q,2) ; 
uv = zeros(2,4,n_points) ; 
X = zeros(3,n_points) ;

for i=1:n_points, 
    wTe = lwr4.T(0,lwr4.n,q(:,i))*lwr4.E ;
    uv(:,:,i) = cam.project(wP(r,:),  'Tcam', wTe) ;  
    X(:,i) = wTe(r,4) ;
end

figure(1) ; plot3(X(1,:), X(2,:), X(3,:), 'k') ;

figure(2) ; hold on ; 
for i=1:4, 
    uv_i = squeeze(uv(:,i,:)) ;
    plot(uv_i(1,:), uv_i(2,:), 'b') ;
end

% plot( uv(1,1,:), uv(2,1,:), 'b') ;
figure(3) ; plot(T,q')


