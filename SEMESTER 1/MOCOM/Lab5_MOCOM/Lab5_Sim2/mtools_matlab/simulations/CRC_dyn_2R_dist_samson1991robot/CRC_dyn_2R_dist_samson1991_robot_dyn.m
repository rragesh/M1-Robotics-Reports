function dy = CRC_dyn_2R_dist_samson1991_robot_dyn(t, y, ab, wP)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
% state vector is y = [e ed].'
q = y(1:2) ;
qd = y(3:4) ;
qdd = [0 ;0 ] ;


persistent n Znx1 Z6x1 Z3x1 eP_prev l
persistent x_d y_d xd_d yd_d 
if( isempty(n) )
    n=2 ;
    l=ab.body(2).d ;
    
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ; 
    
    [x_d, y_d, ~, ~] = splitrow(wP) ;
    xd_d = 0 ;
    yd_d = 0 ; 
end

%% read sensors
wTe = ab.T(0,n,q)*ab.E ;
x = wTe(1,4) ;
y = wTe(2,4) ;

eP = wTe\wP ;

persistent x_prev y_prev xd_prev yd_prev
if isempty(x_prev), 
    x_prev = x ;
    y_prev = y ;
    xd_prev = 0 ;
    yd_prev = 0 ;
end

xd = x - x_prev ;
yd = y - y_prev ;
x_prev = x ;
y_prev = y ;

xdd = xd - xd_prev ;
ydd = yd - yd_prev ;
xd_prev = xd ;
yd_prev = yd ;

C1 = cos(q(1)) ;
C2 = cos(q(2)) ;
S1 = sin(q(1)) ;
S2 = sin(q(2)) ;
C12 = cos(q(1)+q(2)) ;
S12 = sin(q(1)+q(2)) ;

%% kinematics

% % s = (x-x_d)^2 + (y-y_d)^2 ; 
% s = sum( eP(1:2).^2 ) ;
% s_d = 0 ;
% 
% dsdq = [ -2*l*( y_d*(C1+C12) - x_d*(S1+S12) )  2*l*( x_d*S12 - y_d*C12 - l*S2 ) ] ;
% 
% % control law - kine
% lambda = 10 ;
% 
% qd = -lambda*pinv(dsdq)*(s-s_d) ;
% qdd = [0;0] ;
        
%% dynamics - try 1

% s_d = 0 ;
% sd_d = 0 ;
% 
% s = sum( eP(1:2).^2 ) ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% sdd = 0 ; 
% Kv = 0 ;
% Kp = 100 ;
% lambda = 1 ;
% 
% sdd_star =  +( sdd + Kv*(sd-sd_d) + Kp*(s-s_d) ) ;
% 
% dsdq = [ -2*l*( y_d*(C1+C12) - x_d*(S1+S12) )  2*l*( x_d*S12 - y_d*C12 - l*S2 ) ] ;
% 
% d2sdq2 = [
%     2*l*( x_d*(C1+C12) + y_d*(S1+S12) )       2*l*( x_d*C12 + y_d*S12 )
%     2*l*( x_d*C12 + y_d*S12 )                 2*l*x_d*C12 - 2*l*l*C2 + 2*l*y_d*S12     ] ;
% 
% d2sdqdt = [  
%      2*l* S12*xd_d - 2*l*C12*yd_d - 2*l*C1*yd_d + 2*l*S1*xd_d + 2*l*C12*x_d *(qd(1) + qd(2)) + 2*l* S12*y_d *(qd(1) + qd(2)) + 2*l*C1*x_d *qd(1) + 2*l*S1*y_d *qd(1), 2*l* S12*xd_d - 2*l*C12*yd_d - 2*l^2*C2*qd(2) + 2*l*C12*x_d *(qd(1) + qd(2)) + 2*l* S12*y_d *(qd(1) + qd(2)) ] ;
% 
% d2sdt2 = 2*(x_d - l*(C1 + C12))*...
%         (l*(C12*(qd(1) + qd(2))^2 + S12*(qdd(1) + qdd(2)) + C1*qd(1)^2 + S1*qdd(1)) + xdd) ...
%     +2*(l*(S12*(qd(1) + qd(2))^2 - C12*(qdd(1) + qdd(2)) + S1*qd(1)^2 - C1*qdd(1)) + ydd)*...
%         (y_d   - l*(S1 + S12)) ...
%     +2*(l*(C1*qd(1) + C12*(qd(1) + qd(2))) - yd)^2 ...
%     +2*(l*(S1*qd(1) + S12*(qd(1) + qd(2))) + xd)^2 ;
% 
% qdd = -lambda.*dsdq\( sdd_star  -d2sdt2); % -qd.'*d2sdq2*qd  -2*d2sdqdt*qd ) ;
% % qd = qd -lambda*pinv(dsdq)*(s-s_d) ;

%% dynamics - try 2

% s_d = 0 ;
% sd_d = 0 ;
% 
% s = sum( eP(1:2).^2 ) ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% sdd = 0 ; 
% Kv = 1e3 ;
% Kp = 100 ;
% lambda = 1 ;
% 
% sdd_star =  +( sdd + Kv*(sd-sd_d) + Kp*(s-s_d) ) ;
% 
% dsdx = [ 2*(x-x_d)  2*(y-y_d) ] ;
% d2sdxdt = [ 2*(xd-xd_d)  2*(yd-yd_d) ] ;
% dxdq = J2R(ab,q) ;
% dxdqdt = Jd2R(ab,q,qd) ;
% 
% qdd = -pinv(dsdx*dxdq)*( sdd_star -dsdx*dxdqdt*qd -d2sdxdt*dxdq*qd) ; % -d2sdxdt*dxdq*qd

%% dynamics - try 3

% s = [x; y] ;
% sd = [xd; yd] ;
% 
% s_d = [x_d;y_d] ;
% sd_d = [0;0] ;
% sdd_d = [0;0] ;
% 
% Kv = 1000 ;
% Kp = 1 ;
% lambda = 1 ;
% 
% sdd_star =  +( sdd_d + Kv*(sd-sd_d) + Kp*(s-s_d) ) ;
% 
% dsdx = eye(2) ;
% d2sdxdt = zeros(2) ;
% dxdq = J2R(ab,q) ;
% dxdqdt = Jd2R(ab,q,qd) ;
% 
% qdd = -pinv(dsdx*dxdq)*( sdd_star -dsdx*dxdqdt*qd -d2sdxdt*dxdq*qd) ;

% notes (syl, 20140724): ok it converges. normal because it is the same
% kind of control as the operational space control. But, the convergence
% area is much more thicker than a kinematic scheme. The system is then
% more oscillatory and it needs to have an heavy velocity feedback in 
% order to stabilize. 

%% dynamics - try 4

% s_d = 0 ;
% sd_d = 0 ;
% sdd_d = 0 ; 
% 
% s = sum( eP(1:2).^2 ) ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% Kv = 1e3 ;
% Kp = 1 ;
% 
% sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
% 
% dsdx = [ 2*(x-x_d)  2*(y-y_d) ] ;
% d2sdxdt = [ 2*(xd-xd_d)  2*(yd-yd_d) ] ;
% dxdq = J2R(ab,q) ;
% d2xdqdt = Jd2R(ab,q,qd) ;
% 
% qdd = +pinv(dsdx*dxdq)*( sdd_star -dsdx*d2xdqdt*qd -d2sdxdt*dxdq*qd) ;

% notes (syl, 20140724): wouhou it converges \o/. As detailed below, the
% convergence area is much thicker than a kinematic scheme but it converges at
% least. Several things can be done after that: 1) a new error function to
% have a better behavior in operational space ; 2) test it with a
% trajectory generator in operational space, transformed into sensor space
% and applied to the control. Let's doing it.

%% dynamics - try 5

% s_d =   [0;0] ;
% sd_d =  [0;0] ;
% sdd_d = [0;0] ;
% 
% s = [
%     x*(x-x_d) - y*(y-y_d) ; 
%     l*C12*(y-y_d) - l*S12*(x-x_d) ] ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% Kv = 1e3 ;
% Kp = 1 ;
% 
% sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
% 
% dsdx = [  2*x-x_d    y_d-2*y ;
%          -S12*l      C12*l   ] ; 
% d2sdxdt = [  2*xd-xd_d               yd_d - 2*yd ;
%             -l*C12*(qd(1) + qd(2))  -l*S12*(qd(1) + qd(2)) ] ;
% dxdq = J2R(ab,q) ;
% d2xdqdt = Jd2R(ab,q,qd) ;
% 
% qdd = +pinv(dsdx*dxdq)*( sdd_star -dsdx*d2xdqdt*qd -d2sdxdt*dxdq*qd) ;

% notes (syl, 20140724): wouhou it converges \o/. As detailed below, the
% convergence area is much thicker than a kinematic scheme but it converges at
% least. Several things can be done after that: 1) a new error function to
% have a better behavior in operational space ; 2) test it with a
% trajectory generator in operational space, transformed into sensor space
% and applied to the control. Let's doing it.

%% dynamics - try 6
% notes (syl, 20140730): the gradient used below does not correspond to the
% real gradient of h. Let's try with it.

% s_d =   [0;0] ;
% sd_d =  [0;0] ;
% sdd_d = [0;0] ;
% 
% s = [   2*(x-x_d)   ;
%         2*(y-y_d)   ] ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% Kv = 1e3 ;
% Kp = 1 ;
% 
% sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
% 
% dsdx =      eye(2).*2 ;
% d2sdxdt =   zeros(2) ;
% dxdq =      J2R(ab,q) ;
% d2xdqdt =   Jd2R(ab,q,qd) ;
% 
% qdd = +pinv(dsdx*dxdq)*( sdd_star -dsdx*d2xdqdt*qd -d2sdxdt*dxdq*qd ) ;

% Ok, we get close to the operational space control. 

%% dynamics - try 7
% let's try now with the dynamic model of the robot, in the sens of mansard

s_d =   [0;0] ;
sd_d =  [0;0] ;
sdd_d = [0;0] ;

s = [   2*(x-x_d)   ;
        2*(y-y_d)   ] ;

persistent s_prev
if isempty( s_prev ), s_prev = s ; end
sd = s - s_prev ;
s_prev = s ;

Kv = 1e3 ;
Kp = 10 ;

sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;

dsdx =      eye(2).*2 ;
d2sdxdt =   zeros(2) ;
dxdq =      J2R(ab,q) ;
d2xdqdt =   Jd2R(ab,q,qd) ;

JJ = dsdx*dxdq ;
A = A2R(ab,q) ;

tau = JJ.'*( JJ.'\A/JJ)*( sdd_star -dsdx*d2xdqdt*qd -d2sdxdt*dxdq*qd ) ;
qdd = ab.rne(q,qd,tau,ab.gravity,Z6x1) ;

% notes (syl, 20140801): ok... it converged but there was a pb in the
% operational space inertia matrix => does not correspond to the maths
% equation. 
% it converges also with the real inertia matrix equation, but it is far
% more oscillatory than previously try.

%% dynamics - try 8
% dynamic model + traj gen
% not working at all, totally wrong. generate traj in joint space, then
% tranform it into traj in sensor space and apply to the control, hugh. I
% don't know how it should work -_-.

% persistent traj
% if( isempty(traj) ), 
%     q_traj = [  0     -0.2619
%                 pi/2   2.0946] ;
%     kv = [ .05 ; .05 ] ;
%     ka = [ .10 ; .10 ] ;
%     traj = mTrajectory(q_traj, kv, ka) ; 
% end
% 
% [q_d, qd_d, qdd_d] = traj.update(t) ;
%     
% T = ab.T(0,ab.n,q_d)*ab.E ;    
% [x_d2, y_d2] = splitrow( T(1:2,4) ) ;        
% 
% dsdx =      eye(2).*2 ;
% d2sdxdt =   zeros(2) ;
% dxdq =      J2R(ab,q_d) ;
% d2xdqdt =   Jd2R(ab,q_d,qd_d) ;
% 
% s_d = [  2*(x_d2-x_d)   ;
%          2*(y_d2-y_d)   ] ;
% 
% sd_d = dsdx*dxdq*qd ;
% sdd_d = dsdx*dxdq*qdd +dsdx*d2xdqdt*qd +d2sdxdt*dxdq*qd ;
% 
% s = [  2*(x-x_d)   ;
%          2*(y-y_d)   ] ;
% 
% persistent s_prev
% if isempty( s_prev ), s_prev = s ; end
% sd = s - s_prev ;
% s_prev = s ;
% 
% Kv = 10 ;
% Kp = 1e3 ;
% 
% sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;
% 
% dsdx =      eye(2).*2 ;
% d2sdxdt =   zeros(2) ;
% dxdq =      J2R(ab,q) ;
% d2xdqdt =   Jd2R(ab,q,qd) ;
% 
% JJ = dsdx*dxdq ;
% A = A2R(ab,q) ;
% 
% tau = JJ.'/( JJ/A*JJ.')*( sdd_star -dsdx*d2xdqdt*qd -d2sdxdt*dxdq*qd ) ;
% qdd = ab.rne(q,qd,tau,ab.gravity,Z6x1) ;

%% dynamic - try 9 
% testing the operatinnal space control eq34 of khatib1987unified

Kp = eye(2)*1 ;
Kv = eye(2)*100 ;
Vmax = .05 ;

X = [x;y] ;
Xd = [xd; yd ] ;
X_d = [x_d; y_d] ;

Xd_d = Kp/Kv*(X_d - X) ;
nu = min([1, Vmax/sqrt(Xd.'*Xd)]) ;
Fm_star = -Kv*(Xd - nu*Xd_d) ;

J = J2R(ab,q) ;
Delta = J'\A/J ;
b_tilde = -J'*Delta*Jd2R(ab,q,qd)*qd ;
g = zeros(2,1) ;

tau = J'*Delta*Fm_star ; % + b_tilde + g ; 
qdd = ab.rneD(q,qd,tau,ab.gravity) ; 


%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end