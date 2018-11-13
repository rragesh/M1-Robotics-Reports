%mArticulatedBody.rne Recursive Newton Euler Algorithm
% Compute the inverse dynamic model of the articulated chain by the use of
% Newton Euler algorithm [Luth et al., 1980] and taking into account the
% standard inertial parameters of the bodies, mass, cg and inertia.
%
%     Gamma = A(q)*qddot + H(q, qdot)
%
% with:
%   Gamma       joint torques
%   A(q)        complete inertia matrix of the system
%   H(q, qdot)  coriolis and centrifugal forces acting on the system
%   q, qdot, qddot joint pos, speed and acceleration
%
% Gamma[nx1] = obj.rne( q[nx1], qdot[nx1], qddot[nx1], G[3x1], Fe[6xn]) is
% the std call, return the joint torques of the system.
%
% Gamma[nx1] = obj.rne( q[nx1], qdot[nx1], qddot[nx1] ) will return
% the joint torques, assuming there are no gravity and external forces
% acting on the system. 

% Gamma[nx1] = obj.rne( q[nx1], qdot[nx1], qddot[nx1], G[3x1])
% will return the joint torques, assuming there is no external forces
% acting on the system.
%
% Gamma[nx1] = obj.rne( ..., Fe[nx1]) will return the joint torques,
% with only an external forces acting on the end effector, assuming
% Fe = [0 ... 0 Fen] where Fen is the input proposed by user.
%
% TODO: voir pourquoi les eq de Khalil ne fonctionne pas reprendre les equations Cork/Khalil
% TODO: passer � la syntaxe spatiale
% TODO: impl�menter mobile base
%
% See also mArticulatedBody.idym mArticulatedBody.ddym

function Gamma = rne(ab, q, qdot, qddot, G, Fe)


% manage the inputs
if nargin==3, 
  G = zeros(3,1) ;
  Fe = zeros(6, ab.n) ;
elseif nargin==4, 
  Fe = zeros(6, ab.n) ;
end


% Different calls management
% Gamma[nx1] = obj.rne( ..., Fe[nx1])
if numcol(Fe)==1,
  Fe = [zeros(6,ab.n-1) Fe] ;
end


% NE: Vars initialization
n = ab.n ;        % number of joints
aj_j = [0;0;1] ;  % a vector of j wrt j

R = cell(1,6) ;
P = cell(1,6) ;
for j=1:n, [~, R{j}, P{j}] = ab.body(j).T(q(j)) ; end

Fj_  = zeros(3,n) ;
Mj_  = zeros(3,n) ;
Gamma = zeros(n,1) ;

wi_i  = zeros(3,1) ;
wdi_i = zeros(3,1) ;
Ui_i  = skew(wdi_i) + skew(wi_i)*skew(wi_i) ;
Vdi_i = -G ;

% NE: Forward loop
for j=1:n
  
  s   = ab.body(j).sigma ;
  if( ab.body(j).m>0 ), 
      Mj  = ab.body(j).m ;
      CGj = ab.body(j).cg ;  
      MSj = Mj.*CGj ;
  else
      MSj = ab.body(j).MS ;
  end
  Jj  = ab.body(j).inertia() ;
  Rj_i = R{j}.' ;
  Pi_j = P{j} ;      
  
  wj_i  = Rj_i*wi_i ;
  wj_j  = wj_i + not(s)*qdot(j).*aj_j ;      
  wdj_j = Rj_i*wdi_i + ...
    not(s)*( qddot(j).*aj_j + cross(wj_i, qdot(j).*aj_j) ) ;

  Uj_j = skew(wdj_j) + skew(wj_j)*skew(wj_j) ;
     
  Vdj_j = Rj_i*( Vdi_i + Ui_i*Pi_j ) + ...
    s*( qddot(j).*aj_j + 2*cross(wj_i, qdot(j).*aj_j) ) ;   
  
  Fj_(:,j) = Mj.*Vdj_j + Uj_j*MSj ;
  Mj_(:,j) = Jj*wdj_j + cross( wj_j, Jj*wj_j ) + cross(MSj,Vdj_j) ; 
  
  % End of the loop
  % Prepare the next iteration
  wi_i  = wj_j ;
  wdi_i = wdj_j ;
  Vdi_i = Vdj_j ;
  Ui_i  = Uj_j ;
  
end % fw loop

% NE: Barckward loop

for j=n:-1:1
  
  s   = ab.body(j).sigma ;
  Fc  = ab.body(j).Fc ;
  Fv  = ab.body(j).Fv ;
  Ia  = ab.body(j).Ia ;
  CGj = ab.body(j).cg ;  
  Fj_j = Fj_(:,j) ;
  Mj_j = Mj_(:,j) ;   
   
  if j==n,
    fj_j   = Fj_j + Fe(1:3,j) ;
    mj_j   = Mj_j + Fe(4:6,j) ; 
    
  else    
    [~, ~, Pj_jp1] = ab.body(j+1).T(q(j+1)) ;    
    fj_j   = Fj_j + fj_jp1 + Fe(1:3,j) ;
    mj_j   = Mj_j + mj_jp1 + ...
      cross( Pj_jp1, fj_jp1 ) + cross(CGj, Fe(4:6,j)) ;
    
  end
  
  [~, Rjm1_j] = ab.body(j).T(q(j)) ;
  fjm1_j = Rjm1_j*fj_j ;
  mjm1_j = Rjm1_j*mj_j ;
  
  Gamma(j) = (s*fj_j + not(s)*mj_j).'*aj_j + ...
    Fc*sign(qdot(j)) + Fv*qdot(j) + Ia*qddot(j) ;
  
  % End of loop
  % Prepare the next iteration
  fj_jp1   = fjm1_j ;
  mj_jp1 = mjm1_j ;
  
end % bw loop

return % rne()

