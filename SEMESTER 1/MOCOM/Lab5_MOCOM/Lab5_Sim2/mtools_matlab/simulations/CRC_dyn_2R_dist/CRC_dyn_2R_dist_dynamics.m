function dy = CRC_dyn_2R_dist_dynamics(t, y, ab, replay)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
n     = ab.n ;
q     = y(1:n)  ;
qd  = y(n+1:2*n) ;

global wP

persistent Znx1 Z6x1 Z3x1 s_prev eP_prev
if( isempty(Z3x1) )
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ;    
end

%% reading sensors
% get 3D point in effector frame
wTe = ab.T(0,n,q)*ab.E ;
eP = wTe\wP ;
ePd = zeros( size(eP) ) ;

if isempty(eP_prev), eP_prev = [0;0;0;1] ; end
ePd = eP - eP_prev ;

s = sqrt( sum( eP(1:2).^2 ) ) ;
if isempty(s_prev), s_prev = 0 ; end
sd = s - s_prev ;

s_prev = s ;


%% reference behavior

Kp = .1 ;
Kv = .1 ;

sd_d = 0 ;
s_d = 1 ;

sdd_star = 0 + Kv*( sd_d - sd) +  Kp*( s_d - s ) ; 

%% control law
% get jacobian and twist transform
wTTe = velocityTwistMatrix(wTe) ;
wJe = J2R(ab,q) ; 

% get interaction from features
[Ls, Lsd] = getInteractionMatrixDist2D(eP, ePd) ;
% JJ = Ls/wTTe*wJe ; % task jacobian
JJ = Ls*wJe ; % task jacobian

% get Jdqd
Jd = Jd2R(ab, q, qd) ;

% get kinetic energy matrix
A = A2R(ab,q) ;

% tau 
tau =  A/JJ*( sdd_star  ) ;
% tau = A*pinv(JJ)*( sdd_star ) ;

%% robot simulation (direct dynamics)
Fe = zeros(6,7) ;
qdd = ab.rneD(q, qd, tau, ab.gravity, Fe) ;
% qddot = ab.ddym(q, qd, Gamma, Fe) ;

%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end