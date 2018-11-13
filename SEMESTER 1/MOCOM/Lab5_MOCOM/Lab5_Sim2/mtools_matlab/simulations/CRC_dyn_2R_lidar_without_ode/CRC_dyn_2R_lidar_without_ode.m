%% CRC Dyn with 2R robot and distance+angle sensor

clc
clear

addpath(genpath('/home/sylvain/Bureau/mtools_robot_model/matlRR')) ;

Z6x1 = zeros(6,1) ;

%% Robot def

clear b
d = .1 ;
m = 1 ;
r = .05 ;
XX = m*r*r/2 ;
YY = m*(r*r/4+d*d/3) ; ZZ = YY ;
b(1) = mBody(0, [0 0 0 0], 'm', m, 'cg', [d/2 0 0].', 'I', [ XX YY ZZ 0 0 0 ]) ;
b(2) = mBody(1, [0 d 0 0], 'm', m, 'cg', [d/2 0 0].', 'I', [ XX YY ZZ 0 0 0 ]) ;

RR = mArticulatedBody(b, 'name', 'RR') ;
RR.E(1,4) = d ;

% initial conf
qz = zeros(2,1) ;

% qz(2) = pi/2 ; % - pi/12 ;

qz(1) = 2*(rand-.5)*pi/8 +pi/2 ;
qz(2) = 2*(rand-.5)*pi/8 -pi/2 ;

% robot dof
n = RR.n ;

%% Scene def

wP = [.1; .15; 0 ; 1] ;
[x_p, y_p, ~, ~] = splitrow(wP) ;
xd_p = 0 ;
yd_p = 0 ;


%% Sensor def
m = 2 ; % sensor dof
s_d = [x_p ; y_p ] ;
sd_d = zeros(m,1) ; 
sdd_d = zeros(m,1) ;



%% Init display
figure(1) ; clf ;
hold on ;

a = .25 ;
ws = [-a a -a a -a a] ;

scatter(wP(1), wP(2), 'k*')


RR.plot(qz, 'workspace', ws, 'maguser', .5) ;


view(2) ;

% return

%% Main loop: prepare
% time
tStep = .01 ;
tEnd = 20 ;
tt = 0:tStep:tEnd ;
nStep = length(tt) ;

% data
data_q   = zeros(n, nStep) ;
data_qd  = zeros(n, nStep) ;
data_qdd = zeros(n, nStep) ;
data_tau = zeros(n, nStep) ;
data_s = zeros(m, nStep) ;
data_e = zeros(m, nStep) ;

% local vars
q = qz ; % zeros(n,1) ;
qd = zeros(n,1) ;

lambda = eye(m).*2 ;
Kv = eye(m).*100 ;
Kp = eye(m).*1 ;
Vmax = .05 ;

s_prev = [] ;
x_prev = [] ;
y_prev = [] ;

%% Main loop
tic
for i=1:nStep
    % set current time
    t = tt(i) ;
    disp(['t=' num2str(t)]) ;
    
    % read sensor
    wTe = RR.T(0,n,q)*RR.E ;
    x = wTe(1,4) ;
    y = wTe(2,4) ;
    
    if(isempty(x_prev)), 
        x_prev = x ; 
        y_prev = y ; 
    end ;
    xd = x - x_prev ;
    yd = y - y_prev ;
    x_prev = x ;
    y_prev = y ;
    
    eP = wTe\wP ;
        
    s = [x; y] ; 
    
    if(isempty(s_prev)), s_prev = s ; end ;
    sd = s - s_prev ;
    s_prev = s ; 
    
    % read model
    dsdX    = eye(m) ;
    d2sdXdt = zeros(m) ;
    dXdq    = J2R(RR,q) ;
    d2Xdqdt = Jd2R(RR,q,qd) ;
        
    % control law: kinematics
%     e = (s-s_d) ;
%     J = dsdX*dXdq ;
%     tau = zeros(m,1) ;
%     qdd = zeros(m,1) ;
%     qd = -lambda*pinv(J)*e ;
%     q = q + qd*tStep ;
    
    % control law: dynamics, operational space classic
%     sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
    sd_d = Kp/Kv*(s_d-s) ; 
    nu = min([ 1, Vmax/sqrt(s_d.'*s_d) ]) ;
    sdd_star = Kv*(nu*sd_d -sd) ; 
    
    JJ = dsdX*dXdq ;    
    A = A2R(RR,q) ; 
    Delta = JJ'\A/JJ ;
    tau = JJ.'*Delta*( sdd_star -dsdX*d2Xdqdt*qd -d2sdXdt*dXdq*qd ) ;
           
    qdd = RR.rneD(q,qd,tau,RR.gravity) ; 
    qd = qd + qdd*tStep ;
    q = q + qd*tStep ;    
    
    % store data
    data_q(:,i) = q ;
    data_qd(:,i) = qd ;
    data_qdd(:,i) = qdd ;
    data_tau(:,i) = tau ;
    
    data_s(:,i) = s ;        
    
end
toc

%% Display

figure(2); hold on ; %  clf ;
% subplot(211) ; 
% plot(tt, data_e') ;
% subplot(212) ; 
plot(tt, data_s') ;

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

%%

figure(1) ; 
RR.plot(data_q, 'timevect', tt) ;

