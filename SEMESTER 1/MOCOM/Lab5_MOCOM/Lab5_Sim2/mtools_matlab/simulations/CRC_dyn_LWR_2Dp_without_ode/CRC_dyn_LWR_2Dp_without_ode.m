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

% Emit sound signal when simulation's done
if(~exist('GONG','var')),
    GONG = 0 ;
end

% Spawn graphics only
if(~exist('SPAWN_GRAPHICS_ONLY', 'var'))   
    SPAWN_GRAPHICS_ONLY = false ;
end
if( SPAWN_GRAPHICS_ONLY )
    disp 'Warning: simulation will not run. Option SPAWN_GRAPHICS_ONLY is set. Will spawn only graphics in their initial state.'
end

clearvars -except MOVING_TG* DYNAMIC FULL_MODEL GONG SPAWN_GRAPHICS_ONLY

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
cam.pp =    [618.10328, 521.865261] ;
cam.rho =   [1/1625.308838, 1/1631.275635] ;
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

nTs = eye(4) ;

nTs(r,r) = e2R([-.019 -.041 1.556]) ;
nTs(r,4) = [.043 .008 .179]' ;

% nTs(r,r) = rotz(pi/2) ;
% nTs(r,4) = [ .0 ; .0; .179] ;

lwr4.E = nTs ;
%%

wTn = lwr4.Z*lwr4.T(0,lwr4.n,qz) ;
wTn_d = wTn ;
% wTn_d(rxy,4) = wTn_d(rxy,4) + [.05; .1] ;
% wTn_d(rz,4) = wTn_d(rz,4) + .1 ;
% wTn_d(r,r) = wTn_d(r,r)*rotz(-pi*.99) ;


uv_d = cam.project(wP(r,:), 'Tcam', wTn_d*nTs) ;
uvd_d = zeros(size(uv_d)) ;
% s_d = uv_d(:) ;

sP = (wTn_d*nTs)\wP ;
s_d = zeros(m,1) ;
for i=1:4
    s_d(2*i-1) = sP(1,i)/sP(3,i) ;
    s_d(2*i)   = sP(2,i)/sP(3,i) ;
end

sd_d = zeros(size(s_d)) ;
sdd_d = zeros(size(s_d)) ;

%% Init display.001, .006, .708, .707

figure(1); clf ; hold on ;

scatter3(wP(1,:), wP(2,:), wP(3,:), 'k*') ;
ws = [-.6 .2 -.2 .2 0 1] ;
lwr4.plot(qz, 'workspace', ws, 'maguser', 2) ;
wTn = lwr4.Z*lwr4.T(0,lwr4.n,qz) ;

% cam.plot_camera('Tcam', wTn*nTs, 'scale', .03) ;
% camera = mArticulatedBody(mBody(0, [0 0 0 0]), 'name', 'camera') ;
% camera.Z = wTn*nTs ;
% camera.plot(0, 'model', false, 'workspace', ws, 'maguser', 2) ;

world = mArticulatedBody(mBody(0,[0 0 0 0]), 'name', 'world') ;
world.plot(0, 'model', false, 'workspace', ws, 'maguser', 2) ;

view([50 30]) ;

figure(2);  clf ; hold on ;

uv = cam.project(wP(r,:),   'Tcam', wTn*nTs, '*r') ;
uv_d = cam.project(wP(r,:), 'Tcam', wTn_d*nTs, '*g') ;

scatter(uv(1,:), uv(2,:), '*r') ;
scatter(uv_d(1,:), uv_d(2,:), '*g') ;

set(gca,'Ydir', 'reverse') ;
axis equal ;
axis([0 cam.npix(1) 0 cam.npix(2)])

if( SPAWN_GRAPHICS_ONLY ) 
    return ; 
end

%% Main loop: prepare
% time
tStep = .005 ;

if( MOVING_TG )
    target_start = .1 ;
    target_stop  = target_start + 2*2*pi ;
    tEnd = target_stop + 4 ;
    
    rampe_start_end = target_start +1 ;
    rampe_start_dt = rampe_start_end - target_start ;
    rampe_stop_begin = target_stop - 1 ;
    rampe_stop_dt = target_stop - rampe_stop_begin ;
    
else
    tEnd = 5 ;
end

tt = 0:tStep:tEnd ;
nStep = length(tt) ;

% data
data_q   = zeros(n, nStep) ;
data_qd  = zeros(n, nStep) ;
data_qdd = zeros(n, nStep) ;
data_tau = zeros(n, nStep) ;

data_uv = zeros(2,4,nStep) ;
data_uvd = zeros(2,4,nStep) ;
data_s =  zeros(m, nStep) ;
data_e =  zeros(m, nStep) ;
data_ed = zeros(m, nStep) ;

data_wTo = zeros(4,4,nStep) ;

data_rampe = zeros(1, nStep) ;

% local vars
q = qz ; % zeros(n,1) ;20
qd = zeros(n,1) ;

lambda = 2 ;
Kv = eye(m).*20 ;
Kp = eye(m).*100 ;
Vmax = .5 ;

s_prev  = [] ;
uv_prev = [] ;
sP_prev = [] ;

rampe = 0 ;

sTTn = invVelocityTwistMatrix( inv(nTs) ) ;
nTTs = velocityTwistMatrix( nTs ) ;

%% Main loop
tic
for i=1:nStep
    % set current time
    t = tt(i) ;
    disp(['t=' num2str(t)]) ;
    
    % moving target
    if(MOVING_TG)
        if( target_start<= t && t < target_stop )
            
            if( target_start <= t && t < rampe_start_end )
                rampe = (t-target_start)/rampe_start_dt ...
                    -sin(2*pi*(t-target_start)/(rampe_start_dt))/(2*pi);
            elseif( rampe_start_end <= t && t < rampe_stop_begin)
                rampe = 1 ;
            elseif( rampe_stop_begin <= t && t < target_stop )
                rampe = 1-((t-rampe_stop_begin)/rampe_stop_dt ...
                    -sin(2*pi*(t-rampe_stop_begin)/(rampe_stop_dt))/(2*pi)) ;
            else
                rampe = 0 ;
            end
            
            if(MOVING_TG_Y), wTo(ry,4) = rampe*.1*sin(2*(t-target_start)) ; end
            if(MOVING_TG_YAW),
                angle_z = rampe*pi/4*sin(2*(t-target_start)) ;
                wTo(r,r) = rotz(angle_z) ;
            end
            wP = wTo*oP ;
        end
    end
    
    % read sensor
    bTn = lwr4.T(0,n,q) ;
    wTn = lwr4.Z*bTn ;    
    
    sP = (wTn*nTs)\wP ;
    
    uv = cam.project(wP(r,:), 'Tcam', wTn*nTs) ;
%     s = uv(:) ;
    
    s = zeros(m,1) ;
    for k=1:4
        s(2*k-1) = sP(1,k)/sP(3,k) ;
        s(2*k)   = sP(2,k)/sP(3,k) ;
    end
            
    if isempty( s_prev ),
        s_prev = s ;
        uv_prev = uv ;
        sP_prev = sP ;
    end
    uvd     = uv - uv_prev ;
    sd      = uvd(:) ;
    uv_prev = uv ;
    sPd     = sP - sP_prev ;
    sP_prev = sP ;
    
    % read model
    [Ls, Lsd] = get2DPointsInteractionMatrix(cam, sP, sPd, uv, uvd) ;
    bJn = lwr4.J(0,n,q) ;
%     bJn = J(q) ;
    nAAb = [ bTn(r,r)' zeros(3) ; zeros(3) bTn(r,r)' ] ; % note the transpose !
    nJn = nAAb*bJn ;
    
    if(~DYNAMIC),
        % control law: kinematics
        JJ = Ls*sTTn*nJn ;        
        qd = -lambda*pinv(JJ)*(s-s_d) ;

%         sV = -lambda*pinv(Ls)*(s-s_d);
%         nV = nTTs*sV ;
%         qd = nJn\nV ;
        
        q = q + qd*tStep ;
        
        tau = zeros(n,1) ;
        qdd = zeros(n,1) ;
        
    else
        % control law: dynamics
        sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
        %             sd_d = Kp/Kv*(s_d-s) ;
        %         %     nu = min([1, Vmax/(sd_d'*sd_d)]) ;
        %             nu = 1 ;
        %             sdd_star = Kv*(nu*sd_d - sd) ;
        
        JJ = Ls*sTTn*nJn ;
        Jdqd = lwr4.getJdotQdot(q,qd) ;
        A = lwr4.A(q) ;
        H = lwr4.H(q,qd) ;
        
        Delta = pinv(JJ/A*JJ') ;
        tau =  JJ'*Delta*( sdd_star -Ls*sTTn*nAAb*Jdqd -Lsd*sTTn*nJn*qd  + JJ/A*H ); %
        
        qdd = lwr4.rneD(q,qd,tau,lwr4.gravity) ;
        qd = qd + qdd*tStep ;
        q = q + qd*tStep ;
    end
    
    % store data
    data_q(:,i) = q ;
    data_qd(:,i) = qd ;
    data_qdd(:,i) = qdd ;
    data_tau(:,i) = tau ;
    
    data_s(:,i)     = s ;
    data_e(:,i)     = s-s_d ;
    data_ed(:,i)    = sd-sd_d ;
    data_uv(:,:,i)  = uv ;
    data_uvd(:,:,i) = uvd ;
    
    data_wTo(:,:,i) = wTo ;
    
    data_rampe(i) = rampe ;
    
end
toc

%% Gong at the end
if( GONG )
    load gong.mat;
    sound(y);
end

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
    wTs = lwr4.Z*lwr4.T(0,lwr4.n,data_q(:,i))*nTs ;
    X(:,i) = wTs(r,4) ;
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
fig6 = figure(6) ; hold on ; 
set(fig6,'defaulttextinterpreter','latex');

uv1 = squeeze(data_uv(:,1,:)) ;
uvd1 = squeeze(data_uvd(:,1,:)) ;

plot(uv1(1,:)-uv_d(1,1), uvd1(1,:), 'b') ;

legend('kin','dyn')
xlabel('$u_1$ [px]', 'fontsize', 20) ; 
ylabel('$\dot{u}_1$ [px]', 'fontsize', 20) ; 

gpoint = line('parent',gca, 'marker', '*', 'markeredgecolor','r', ...
    'linestyle', 'none', ...
    'xdata', uv1(1,1), 'ydata', uvd1(1,1) ) ;

for i=1:nStep
    set(gpoint, 'xdata', uv1(1,i)-uv_d(1,1), 'ydata', uvd1(1,i) ) ;
    drawnow() ;
    pause(tStep) ;
    
end
