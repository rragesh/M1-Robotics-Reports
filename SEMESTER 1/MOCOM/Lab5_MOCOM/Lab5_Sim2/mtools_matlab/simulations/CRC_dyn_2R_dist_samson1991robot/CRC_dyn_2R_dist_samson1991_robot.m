%% CRC Dyn with 2R robot and distance sensor
% Implementation of eq 5.2.2 from Robot control, the task function
% approach, samson1991robot.
clc
clear
% clear functions

addpath(genpath('/home/sylvain/Bureau/mtools_robot_model/matlab')) ;

%% Robot definition

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

qz = zeros(2,1) ;
q = qz ; % start in std by pos
% q(1) = 2*(rand-.5)*pi/8 +pi/2 ; 
% q(2) = 2*(rand-.5)*pi/8 -pi/2 ; 
q(2) = pi/2 ; % - pi/12 ;

%% scene
global wP
% wP = [.1 ; .1 ; 0 ; 1] ;
wP = [.0707 ; .0707 ; 0 ; 1] ;
q_d = [-0.2619 ; 2.0946 ] ;     % desired position in joint space

%% Init display
figure(1) ; clf ;
hold on ;

a = .25 ;
ws = [-a a -a a -a a] ;

RR.plot(q, 'workspace', ws, 'maguser', .5) ;

scatter(wP(1), wP(2), 'k*')

view(2) ;

%% ODE Simulator
Y0 = [q; zeros(size(q)) ] ;
Tstep = .02 ; % 10ms ;
Tf = 30 ;
% Tf = traj.t(end) + 2*traj.T(end) ; % 10s ;
T = 0:Tstep:Tf ;

options = odeset('MaxStep', .1) ;
% options = odeset() ;


tic
[T,Y] = ode45(  @(t,y) CRC_dyn_2R_dist_samson1991_robot_dyn(t, y, RR, wP), ...
    T, Y0, options) ;
toc

q = Y(:,1:2)' ;


%%

figure(2) ; % hold on ; 
plot(T, q') ;

%%

e = zeros(1,size(q,2)) ;
s = zeros(2,size(q,2)) ;
[x_d,y_d] = splitrow(wP(1:2)) ;

for i=1:size(q,2)
    wTe = RR.T(0,RR.n,q(:,i))*RR.E ;
    eP = wTe\wP ;
    [x, y] = splitrow(wTe(1:2,4)) ;
    
    
    s(:,i) = [   (x-x_d)   ;
            (y-y_d)   ] ;
    
    e(i) = sqrt( sum( eP(1:2).^2 ) ) ;
end

figure(3) ; 
subplot(211) ; % hold on ; 
plot(T,e)
subplot(212) ; % hold on ; 
plot(T,s')

%%

figure(1) ; RR.plot(q ,'timevect', T) ;
% figure(1) ; RR.plot(q(:,end)) ;

%%
return

%%

q   = [0 ; pi/2] ;
q_d = [-0.2619 ; 2.0946 ] ;     % desired position in joint space

[x_d, y_d, ~, ~] = splitrow(wP) ;

q_traj = [ q q_d ] ;
kv = [ .05 ; .05 ] ;
ka = [ .10 ; .10 ] ;

traj = mTrajectory(q_traj, kv, ka) ; 

tStep = 0.01 ;
tEnd = traj.t(end)+2*traj.T(end) ;
tt=0:tStep:tEnd ;

q   = zeros(2,length(tt)) ;
qd  = zeros(2,length(tt)) ;
qdd = zeros(2,length(tt)) ;

s   = zeros(2,length(tt)) ;
sd  = zeros(2,length(tt)) ;
sdd = zeros(2,length(tt)) ;

for i=1:length(tt)
    [q(:,i), qd(:,i), qdd(:,i)] = traj.update(tt(i)) ;
    
    wTe = RR.T(0,RR.n,q(:,i))*RR.E ;    
    [x, y] = splitrow(wTe(1:2,4)) ;        
    
    dsdx =      eye(2).*2 ;
    d2sdxdt =   zeros(2) ;
    dxdq =      J2R(RR,q) ;
    d2xdqdt =   Jd2R(RR,q,qd) ;
    
    s(:,i) = [  2*(x-x_d)   ;
                2*(y-y_d)   ] ;
            
    sd(:,i) = dsdx*dxdq*qd(:,i) ;
    sdd(:,i) = dsdx*dxdq*qdd(:,i) ...
                    +dsdx*d2xdqdt*qd(:,i) +d2sdxdt*dxdq*qd(:,i) ;     
end

figure(4) ; 
subplot(321) ; plot(tt,q') ;
subplot(322) ; plot(tt,s') ;

subplot(323) ; plot(tt,qd') ;
subplot(324) ; plot(tt,sd') ;

subplot(325) ; plot(tt,qdd') ;
subplot(326) ; plot(tt,sdd') ;
xaxis([0 tt(end)]) ;
