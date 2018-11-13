function dy = CRC_dyn_3d_points_dynamics(t, y, ab, trajs)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
n     = ab.n ;
q     = y(1:n)  ;
qd  = y(n+1:2*n) ;

global wTo oP eP_d

persistent Znx1 Z6x1 Z3x1 eP_prev
if( isempty(Z3x1) )
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ;    
end

%% reading sensors
% get 3D points in effector frame
wTe = ab.T(0,7,q)*ab.E ;
eP = wTe\wTo*oP ;

%% control law
% get jacobian and twist transform
wTTe = velocityTwistMatrix(wTe) ;
wJe = ab.J(0,7,q) ; 

% get interaction from features
[Ls, Lsd] = get3DPointInteractionMatrix(eP, ePd) ;
% [Ls, Lsd] = get3DPointInteractionMatrix(eP, ePd, 1) ;
JJ = Ls/wTTe*wJe ; % task jacobian

% get Jdqd
Jdqd = ab.getJdotQdot(q,qd) ;

%% tau - operationnal space formulation
% % get robot dynamics 
% H = ab.rne( q, qd, Znx1, ab.gravity, Z6x1 ) ;
% A = zeros(7) ;
% for i=1:n,   
%   ui = Znx1 ;
%   ui(i) = 1 ;
%   A(:,i) = ab.rne( q, Znx1, ui, Z3x1, Z6x1 )  ;
% end
% % Omega = JJ/A*JJ.' ;  % Delta = inv(Omega)
% 
% JJpiv = pinv(JJ) ; 
% Delta = JJpiv.'*A*JJpiv ;
% 
% % get Jdqd
% Jdqd = ab.getJdotQdot(q,qd) ;
% 
% % cl
% % tau = JJ.'*Delta*( sdd_star - Lsd/wTTe*wJe*qd - Ls/wTTe*Jdqd + JJ/A*H) ; 
% tau = JJ.'*Delta*( sdd_star + JJ/A*H) ; 


%% robot simulation (direct dynamics)
Fe = zeros(6,7) ;
qdd = ab.rneD(q, qd, tau, ab.gravity, Fe) ;
% qddot = ab.ddym(q, qd, Gamma, Fe) ;

%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end