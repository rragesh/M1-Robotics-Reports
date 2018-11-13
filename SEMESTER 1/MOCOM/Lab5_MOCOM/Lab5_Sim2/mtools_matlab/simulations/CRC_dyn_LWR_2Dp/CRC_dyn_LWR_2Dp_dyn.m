function dy = CRC_dyn_LWR_2Dp_dyn(t, y, ab, cam, wP, wTe_d)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
persistent n Znx1 Z6x1 Z3x1 l r
persistent x_d y_d xd_d yd_d 
if( isempty(n) )
    n=ab.n ;
    l=ab.body(2).d ;
    
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ; 
    
    [x_d, y_d, ~, ~] = splitrow(wP) ;
    xd_d = 0 ;
    yd_d = 0 ; 
    r = 1:3 ;
end

q = y(1:n) ;
qd = y(n+1:end) ;

%% read sensors

wTe = ab.T(0,ab.n,q)*ab.E ;
uv = cam.project(wP(r,:), 'Tcam', wTe) ;
s = uv(:) ;

eP = wTe\wP ;

persistent s_prev uv_prev eP_prev
if isempty( s_prev ), 
    s_prev = s ; 
    uv_prev = uv ;
    eP_prev = eP ;
end
uvd = uv - uv_prev ;
sd = uvd(:) ;
uv_prev = uv ;
ePd = eP - eP_prev ; 
eP_prev = eP ;

persistent uv_d uvd_d s_d sd_d sdd_d
if isempty(uv_d), 
    uv_d = cam.project(wP(r,:), 'Tcam', wTe_d) ;
    uvd_d = zeros(size(uv_d)) ;
    s_d = uv_d(:) ;
    sd_d = zeros(size(s_d)) ; 
    sdd_d = zeros(size(s_d)) ; 
end

%% kinematics

% lambda = .5 ;
% 
% L = get2DPointsInteractionMatrix(cam,eP,uv) ;
% 
% % Ls = get2DPointsInteractionMatrix(cam,eP,uv) ;
% % Lsd = get2DPointsInteractionMatrix(cam,eP,uv_d) ;
% % L = .5.*(Ls+Lsd) ;
% 
% oTe = wTe ; 
% oTTe = velocityTwistMatrix(oTe) ; 
% Jq = ab.J(0,ab.n,q);
% 
% qd = -lambda.*pinv(L/oTTe*Jq)*(s-s_d) ;
% qdd = Znx1 ;
        
%% dynamics
% dynamic model + interaction from try 5

Kv = 1e3 ;
Kp = 1 ;

sdd_star =  +( sdd_d + Kv*(sd_d-sd) + Kp*(s_d-s) ) ;

[Ls, Lsd] = get2DPointsInteractionMatrix(cam, eP, ePd, uv_d, uvd_d) ; 
J = ab.J(0,ab.n,q) ;
Jdqd = ab.getJdotQdot(q,qd) ; 
wTTe = velocityTwistMatrix(wTe) ; 
JJ = Ls/wTTe*J ;
A = ab.A(q) ; 
H = ab.H(q,qd) ;

% Delta = JJ.'\A/JJ ;
tau = JJ.'/(JJ/A*JJ.')*( ...
        sdd_star -Ls/wTTe*Jdqd -Lsd/wTTe*J*qd + JJ/A*H ) ;

qdd = ab.rneD(q,qd,tau,ab.gravity) ; 

%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end