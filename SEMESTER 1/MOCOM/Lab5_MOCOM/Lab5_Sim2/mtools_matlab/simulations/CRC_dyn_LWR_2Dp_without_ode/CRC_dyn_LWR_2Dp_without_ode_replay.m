%% CRC Dyn with 2R robot and distance+angle sensor

addpath(genpath('/home/sylvain/Documents/Fichiers_ROS/hydro_catkin_workspace/src/mtools/mtools_matlab')) ;
addpath(genpath('/home/sylvain/Documents/Fichiers Matlab/Rvctools')) ;

%% Control vars for script

% DYNAMIC = 0 <=> use the kinematic framework
% DYNAMIC = 1 <=> use the dynamic framework
if(~exist('DYNAMIC','var')),
    DYNAMIC = 1 ;
end

% MOVING_TG = 0 <=> tg is fixed
% MOVING_TG = 1 <=> move tg as specified in loop
if(~exist('MOVING_TG','var')),
    MOVING_TG = 1 ;
    
    MOVING_TG_X = 0 ;
    MOVING_TG_Y = 1 ;
    MOVING_TG_YAW = 0 ;
    
end

% DOF7
if(~exist('FULL_MODEL','var')),
    FULL_MODEL = 0 ;        
end

clearvars -except MOVING_TG* DYNAMIC FULL_MODEL

%% Data load

if( DYNAMIC ) 
    load data_dynamic.mat
else
    load data_kinematic.mat
end

%%

Z6x1 = zeros(6,1) ;

rx = 1;
ry = 2 ;
rz = 3 ;
rxy = 1:2 ;
rxyz = 1:3 ;
r = 1:3 ;

%% Robot def

if( FULL_MODEL )
    mdl_lwr4 ;
    qz(4) = -pi/2 ;
    qz(6) = pi/2 ;
else
    mdl_lwr4_6dof ;
    qz(2) = pi/2 ;
    qz(5) = pi/2 ;
end

lwr4.Z(3,4) = .3125 ;
% lwr4.E(r,r) = rotz(pi/2) ;

% lwr4.E(r,4) = [.054; 0; .21] ;% lwr4.E(r,r) = rotz(pi/2) ;
% lwr4.E(r,4) = [.054; 0; .21] ;

n = lwr4.n ;

%% Scene def

a = .045 ;
oP = [  a  a -a -a ;
    a -a -a  a ;
    0  0  0  0 ] ;
oP(4,:) = 1 ;

wTo = eye(4) ;
wTo(rx,4) = -.4 ;
wP = wTo*oP ;

%% Sensor def

cam = CentralCamera() ;
cam.npix =  [1280,1024] ;
cam.pp =    [644.457, 495.157] ;
cam.rho =   [1/1570.500327, 1/1566.965158] ;
cam.distortion = [ -0.098405 0.118169 -0.001245 0.000480 0.000000 ] ; 
% cam.noise = [.02 .02] ;

m = 2*size(oP,2) ; % sensor dof

% This is the transformation got from ROS TF. 
% But it makes the control law diverging. 
% Need to have the perfect transform, at least better conditionned one.
% eTs = [-0.001203643425 -0.9999747757 0.006999942833      0.054
% 0.9999386836 -0.001280597856 -0.01099950867          0
% 0.01100819533 0.006986274136 0.9999150022       0.21
%          0          0          0          1] ;
eTs = eye(4) ;
eTs(r,r) = rotz(pi/2) ;
eTs(r,4) = [.054 .0 .21]' ;
lwr4.E = eye(4) ;
%%

wTe = lwr4.Z*lwr4.T(0,lwr4.n,qz)*lwr4.E ;
wTe_d = wTe ;
% wTe_d(rxy,4) = wTe_d(rxy,4) + [.05; .1] ;
% wTe_d(rz,4) = wTe_d(rz,4) + .1 ;
% wTe_d(r,r) = wTe_d(r,r)*rotz(pi/4) ;


uv_d = cam.project(wP(r,:), 'Tcam', wTe_d*eTs) ;
uvd_d = zeros(size(uv_d)) ;
s_d = uv_d(:) ;
sd_d = zeros(size(s_d)) ;
sdd_d = zeros(size(s_d)) ;

%% Init display.001, .006, .708, .707

figure(1); clf ; hold on ;

scatter3(wP(1,:), wP(2,:), wP(3,:), 'k*') ;
ws = [-.6 .2 -.2 .2 0 1] ;
lwr4.plot(qz, 'workspace', ws, 'maguser', 2) ;
wTe = lwr4.Z*lwr4.T(0,lwr4.n,qz)*lwr4.E ;

% cam.plot_camera('Tcam', lwr4.Z*lwr4.T(0,lwr4.n,qz)*lwr4.E*eTs, 'scale', .03) ;
% camera = mArticulatedBody(mBody(0, [0 0 0 0]), 'name', 'camera') ;
% camera.Z = wTe*eTs ;
% camera.plot(0, 'model', false, 'workspace', ws, 'maguser', 2) ;
% 

world = mArticulatedBody(mBody(0,[0 0 0 0]), 'name', 'world') ;
world.plot(0, 'model', false, 'workspace', ws, 'maguser', 2) ;

view([50 30]) ;

figure(2);  clf ; hold on ;



uv = cam.project(wP(r,:),   'Tcam', wTe*eTs, '*r') ;
uv_d = cam.project(wP(r,:), 'Tcam', wTe_d*eTs, '*g') ;

scatter(uv(1,:), uv(2,:), '*r') ;
scatter(uv_d(1,:), uv_d(2,:), '*g') ;

set(gca,'Ydir', 'reverse') ;
axis equal ;
axis([0 cam.npix(1) 0 cam.npix(2)])

%% Display

figure(2) ; hold on ;
for i=1:4,
    uv_i = squeeze(data_uv(:,i,:)) ;
    plot(uv_i(1,:), uv_i(2,:), 'b') ;
end

figure(3); clf;
subplot(411) ;
plot(tt, data_q') ;
title('Joint profile') ;
subplot(412) ;
plot(tt, data_qd') ;
subplot(413) ;
plot(tt, data_tau') ;
subplot(414) ;
plot(tt, data_qdd') ;
xlabel('time [s]') ;
xaxis([tt(1) tt(end)]) ;

figure(4); clf ;
subplot(211) ;
plot(tt, data_e') ;
subplot(212) ;
plot(tt, data_ed') ;
xaxis([tt(1) tt(end)]) ;

%%

X = zeros(3,nStep) ;

for i=1:nStep,
    wTe = lwr4.Z*lwr4.T(0,lwr4.n,data_q(:,i))*lwr4.E ;
    X(:,i) = wTe(r,4) ;
end

P = squeeze(data_wTo(rxyz,4,:)) ;

figure(1) ; hold on ;
plot3(X(1,:), X(2,:), X(3,:), 'k') ;
plot3(P(1,:), P(2,:), P(3,:), 'k') ;

%%
if( MOVING_TG_Y )
    figure(5) ;
    plot(tt,P(1,:), tt, P(2,:), tt, P(3,:)) ;
    xaxis([tt(1) tt(end)]) ;
else
    close 5
end

%%
figure(1) ;
lwr4.plot(data_q, 'timevect', tt) ;

%%
figure(6) ;

uv1 = squeeze(data_uv(:,1,:)) ;
uvd1 = squeeze(data_uvd(:,1,:)) ;

plot(uv1(1,:)-uv_d(1,1), uvd1(1,:)) ;

gpoint = line('parent',gca, 'marker', '*', 'markeredgecolor','r', ...
    'linestyle', 'none', ...
    'xdata', uv1(1,1), 'ydata', uvd1(1,1) ) ;

for i=1:nStep
    set(gpoint, 'xdata', uv1(1,i)-uv_d(1,1), 'ydata', uvd1(1,i) ) ;
    drawnow() ;
    pause(tStep) ;
    
end
