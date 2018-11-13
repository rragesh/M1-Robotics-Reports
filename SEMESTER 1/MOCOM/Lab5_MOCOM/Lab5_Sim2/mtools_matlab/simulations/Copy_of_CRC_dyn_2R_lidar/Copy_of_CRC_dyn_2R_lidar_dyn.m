function dy = Copy_of_CRC_dyn_2R_lidar_dyn(t, y, ab, wP)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
q = y(1:2) ;
qd = y(3:4) ;
qdd = [0 ;0 ] ;


persistent n Znx1 Z6x1 Z3x1 eP_prev l
persistent x_p y_p xd_p yd_p 
if( isempty(n) )
    n=2 ;
    l=ab.body(2).d ;
    
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ; 
    
    [x_p, y_p, ~, ~] = splitrow(wP) ;
    xd_p = 0 ;
    yd_p = 0 ; 
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

% xdd = xd - xd_prev ;
% ydd = yd - yd_prev ;
xd_prev = xd ;
yd_prev = yd ;

% C1 = cos(q(1)) ;
% C2 = cos(q(2)) ;
% S1 = sin(q(1)) ;
% S2 = sin(q(2)) ;
% C12 = cos(q(1)+q(2)) ;
% S12 = sin(q(1)+q(2)) ;

%% kinematics

% d2 = (x_p-x)^2 + (y_p-y)^2 ;
% th = atan( abs(eP(2))/(eP(1)) ) ;
% s = [d2; th] ;
% 
% s_d = [0.01^2 ; 0] ;
% 
% dsdX = [    2*x - 2*x_p,     2*y - 2*y_p ;
%             -(y - y_p)/((x - x_p)^2*((y - y_p)^2/(x - x_p)^2 + 1)), 1/((x - x_p)*((y - y_p)^2/(x - x_p)^2 + 1)) ] ;
% dXdq =      J2R(ab,q) ;
% J = dsdX*dXdq ;
% 
% % control law - kine
% lambda = 1 ;
% 
% qd = -lambda*J\(s-s_d) ;
% qdd = [0;0] ;


%% dynamics - try 7
% let's try now with the dynamic model of the robot, in the sens of mansard

s_d   = [0.01^2 ; 0] ;
sd_d  = [0;0] ;
sdd_d = [0;0] ;

d2 = (x_p-x)^2 + (y_p-y)^2 ;
th = atan2( (eP(2)),(eP(1)) ) ;
s = [d2; th] ;

persistent s_prev
if isempty( s_prev ), s_prev = s ; end
sd = s - s_prev ;
s_prev = s ;

Kv = 100 ;
Kp = 1 ;
Vmax = 10 ;

sd_d = Kp/Kv.*(s_d-s) ;
nu = min([1, Vmax/sqrt(sd_d.'*sd_d)]) ;
sdd_star =  Kv.*(nu.*sd_d - sd) ; 

dsdX = [    2*x - 2*x_p,     2*y - 2*y_p ;
            -(y - y_p)/((x - x_p)^2*((y - y_p)^2/(x - x_p)^2 + 1)), 1/((x - x_p)*((y - y_p)^2/(x - x_p)^2 + 1)) ] ;

d2sdXdt = [ 2*xd - 2*xd_p, 2*yd - 2*yd_p ; 
    (((2*(yd - yd_p)*(y  - y_p ))/(x  - x_p )^2 - (2*( xd - xd_p)*(y  - y_p )^2)/(x  - x_p )^3)*(y  - y_p ))/((x  - x_p )^2*((y  - y_p )^2/(x  - x_p )^2 + 1)^2) - (yd - yd_p)/((x  - x_p )^2*((y  - y_p )^2/(x  - x_p )^2 + 1)) + (2*( xd - xd_p)*(y  - y_p ))/((x  - x_p )^3*((y  - y_p )^2/(x  - x_p )^2 + 1)), - ((2*(yd - yd_p)*(y  - y_p ))/(x  - x_p )^2 - (2*( xd - xd_p)*(y  - y_p )^2)/(x  - x_p )^3)/((x  - x_p )*((y  - y_p )^2/(x  - x_p )^2 + 1)^2) - ( xd - xd_p)/((x  - x_p )^2*((y  - y_p )^2/(x  - x_p )^2 + 1)) ] ;

dXdq =      J2R(ab,q) ;
d2Xdqdt =   Jd2R(ab,q,qd) ;

JJ = dsdX*dXdq ;
A = A2R(ab,q) ;

tau = pinv(JJ)*( sdd_star ) ; %  -dsdX*d2Xdqdt*qd -d2sdXdt*dXdq*qd ) ;


qdd = ab.rne(q,qd,tau,ab.gravity,Z6x1) ; 


%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end