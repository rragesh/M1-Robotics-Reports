function dy = ode_func(t, y, ab, traj)

%% user feedback - pre comp
disp(['t=' num2str(t)])

%% in loop vars
n     = ab.n ;
q     = y(1:n)  ;
qd  = y(n+1:2*n) ;

persistent Znx1 Z6x1 Z3x1 Fe F Fd tprev
if( isempty(Z3x1) )
    Z3x1  = zeros(3,1) ;
    Znx1  = zeros(n,1) ;
    Z6x1  = zeros(6,1) ;
    Fe    = zeros(6,n) ;
    
    Fd = Z6x1 ; 
    F = Z6x1 ;
    tprev = 0 ;
end

%% command I : gravity compensation
% % external forces
% if( .05 < t && t <= .5 ),
%     Fe(3,end) = 100 ;
% end
% if( .55 < t && t <= 1.5 ),
%     Fe(3,4) = 100 ;
% end
%
% % control law
% Kv = eye(ab.n).*100 ;
% w = -Kv*qd ;
% Gamma = ab.rne(q, qd, w, ab.gravity, Z6x1) ;

%% command II : computed torque rl - pd
% vars for command
% persistent omega Kp ksi Kv
% omega = ones(n,1)*2 ;
% Kp = diag(omega.^2) ;6500
% ksi = ones(n,1)*1 ;
% Kv = diag(2.*ksi.*omega) ;
%
% % control inputs
% [q_d, qd_d, qdd_d] = traj.update(t) ;
%
% % control law
% w = qdd_d + Kv*(qd_d - qd) + Kp*(q_d - q) ;
% Gamma = ab.rne(q, qd, w, ab.gravity, Z6x1) ;

%% command III : operationnal space ctrl
% vars for ctrl
% persistent omega Kp ksi Kv
% omega = ones(6,1)*10 ;
% Kp = diag(omega.^2) ;
% ksi = ones(6,1)*1 ;
% Kv = diag(2.*ksi.*omega) ;
%
% % control inputs
% [X_d, Xd_d, Xdd_d] = traj.update(t) ;
%
% % vars for control law : dX = X_d - X
% [~, A0_n, P0_n] = ab.T(0,ab.n,q) ;
% A0_n_d = e2R(X_d(4:end)) ;
% [s_d, n_d, a_d] = splitcol(A0_n_d) ;
% [s, n, a] = splitcol(A0_n) ;
%
% dX(1:3,1) = X_d(1:3) - P0_n ; % eq [A10.3]
% dX(4:6,1) = .5*( cross(s,s_d) + cross(n,n_d) + cross(a,a_d) ) ; % eq [A10.8]
%
% % vars for control law : Xdot and Jdot*qdot (appendix 10)
% aj_j = [0 0 1].' ;
% Vjm1_jm1 = Z3x1 ;
% Wjm1_jm1 = Z3x1 ; % robot base is fixed
% PSIjm1_jm1 = Z3x1 ;
% PHIjm1_jm1 = Z3x1 ;
% Ujm1_jm1   = skewsym(PSIjm1_jm1) + skewsym(Wjm1_jm1)*skewsym(Wjm1_jm1) ;
%
% for j=1:ab.n
%     [~, Ajm1_j, Pjm1_j] = ab.body(j).T(q(j)) ;
%
%     % eq [A10.{10,11,12}]
%     Vj_j = Ajm1_j\( Vjm1_jm1 + cross(Wjm1_jm1,Pjm1_j) ) ;
%     Wj_jm1 =  Ajm1_j\Wjm1_jm1 ;
%     Wj_j = qd(j).*aj_j + Wj_jm1  ;
%
%     % eq [A10.{15,16,17}]
%     PSIj_j = Ajm1_j\PSIjm1_jm1 + cross( Wj_jm1, qd(j).*aj_j ) ;
%     Uj_j = skewsym(PSIj_j) + skewsym(Wj_j)*skewsym(Wj_j) ;
%     PHIj_j = Ajm1_j\( PHIjm1_jm1 + Ujm1_jm1*Pjm1_j ) ;
%
%     % prepare next iteration
%     Vjm1_jm1 = Vj_j ;
%     Wjm1_jm1 = Wj_j ;
%
%     PSIjm1_jm1 = PSIj_j ;
%     Ujm1_jm1 = Uj_j ;
%     PHIjm1_jm1 = PHIj_j ;
% end
%
% Xd(1:3,1) = A0_n*Vj_j ; % because j = n
% Xd(4:6,1) = A0_n*Wj_j ;
%
% Jdqd(1:3,1) = PSIj_j ;
% Jdqd(4:6,1) = PHIj_j ;
%
% J = ab.J(0,ab.n,q) ;
%
% % control law
% w = Xdd_d + Kv*(Xd_d - Xd) + Kp*dX ;
% % comments below eq [14.37]
% Gamma = ab.rne(q, qd, J\(w - Jdqd), ab.gravity, Z6x1) ;

%% command IV : external hybrid ctrl
% vars for ctrl
persistent omega Kp ksi Kv
if( isempty(omega) )
    omega = ones(6,1)*10 ;
    Kp = diag(omega.^2) ;
    ksi = ones(6,1)*1 ;
    Kv = diag(2.*ksi.*omega) ;
end

persistent Kf Kfi Ke sum_dF
if( isempty(Kf) )
    Kf  = eye(6)*2e3 ;
    Kfi = eye(6)*10 ;
    Ke  = eye(6)*5000 ;
    sum_dF = Z6x1 ;
end

% control inputs
[X_d, Xd_d, Xdd_d] = traj.update(t) ;

% vars for control law : dX = X_d - X
[~, A0_n, P0_n] = ab.T(0,ab.n,q) ;
A0_n_d = e2R(X_d(4:end)) ;
[s_d, n_d, a_d] = splitcol(A0_n_d) ;
[s, n, a] = splitcol(A0_n) ;

dX(1:3,1) = X_d(1:3) - P0_n ; % eq [A10.3]
dX(4:6,1) = .5*( cross(s,s_d) + cross(n,n_d) + cross(a,a_d) ) ; % eq [A10.8]

% vars for control law : Xdot and Jdot*qdot (appendix 10)
aj_j = [0 0 1].' ;
Vjm1_jm1 = Z3x1 ;
Wjm1_jm1 = Z3x1 ; % robot base is fixed
PSIjm1_jm1 = Z3x1 ;
PHIjm1_jm1 = Z3x1 ;
Ujm1_jm1   = skewsym(PSIjm1_jm1) + skewsym(Wjm1_jm1)*skewsym(Wjm1_jm1) ;

for j=1:ab.n
    [~, Ajm1_j, Pjm1_j] = ab.body(j).T(q(j)) ;
    
    % eq [A10.{10,11,12}]
    Vj_j = Ajm1_j\( Vjm1_jm1 + cross(Wjm1_jm1,Pjm1_j) ) ;
    Wj_jm1 =  Ajm1_j\Wjm1_jm1 ;
    Wj_j = qd(j).*aj_j + Wj_jm1  ;
    
    % eq [A10.{15,16,17}]
    PSIj_j = Ajm1_j\PSIjm1_jm1 + cross( Wj_jm1, qd(j).*aj_j ) ;
    Uj_j = skewsym(PSIj_j) + skewsym(Wj_j)*skewsym(Wj_j) ;
    PHIj_j = Ajm1_j\( PHIjm1_jm1 + Ujm1_jm1*Pjm1_j ) ;
    
    % prepare next iteration
    Vjm1_jm1 = Vj_j ;
    Wjm1_jm1 = Wj_j ;
    
    PSIjm1_jm1 = PSIj_j ;
    Ujm1_jm1 = Uj_j ;
    PHIjm1_jm1 = PHIj_j ;
end

Xd(1:3,1) = A0_n*Vj_j ; % because j = n
Xd(4:6,1) = A0_n*Wj_j ;

Jdqd(1:3,1) = PSIj_j ;
Jdqd(4:6,1) = PHIj_j ;

J = ab.J(0,ab.n,q) ;

% external force 
if( P0_n(1) > .5)
    DeltaX = P0_n(1) - .5 ;
    F(1) = 5000*DeltaX ;
end

% control law - task space
wx = Xdd_d + Kv*(Xd_d - Xd) + Kp*dX ;

% control law - force space
sum_dF = sum_dF + (Fd - F)*(t-tprev) ;
tprev = t ;

wf = Ke\( Kf*( Fd - F) + Kfi*sum_dF ) ;

% comments below eq [14.37]
Gamma = ab.rne(q, qd, J\(wx + wf - Jdqd), ab.gravity, F); 


%% robot simulation (direct dynamics)
Fe(:,end) = F ;
qdd = ab.rneD(q, qd, Gamma, ab.gravity, Fe) ;
% qddot = ab.ddym(q, qd, Gamma, Fe) ;

%% integration
dy = [qd; qdd] ;

%% user feedback - post compute
% ab.plot(q) ;

end