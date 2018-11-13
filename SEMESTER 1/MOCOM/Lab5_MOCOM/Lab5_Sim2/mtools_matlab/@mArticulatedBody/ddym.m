%mArticulatedBody.ddym Direct Dynamic Model
% Compute the acceleration components of joints knowing torques that are
% acting on the joint, the configurationof the articulated chain, gravity 
% and perturbation forces and torques acting on bodies. This uses Walkin 
% and Orin concept, by computing total inertia matrix of the system A(q), 
% Coriolis and centrifugal forces and torques using Recurisve Newton Euler 
% algorithm. 
% Note that gravity components are ones that was specified at creation of
% the mAB object.
% 
%   qddot = A(q)\( Gamma - H(q, qdot) )
%
% with: 
%     forall i, A(:,i) = RNE(q, 0, ui, 0, 0) ; ui(i) = 1, 0 otherwise.
%     H(q, qdot) = RNE(q, qdot, 0, G, Fe) ; 
%
% qddot[nx1] = obj.ddym( Gamma[nx1], q[nx1], qdot[nx1], Fe[nx6] )
% is the standard call, will return the nx1 acceleration joint vector, with
% n the number of joints. 
%
% See also mArticulatedBody.idym mArticulatedBody.rne

function qddot_o = ddym(ab, Gamma, q, qdot, Fe)

% Gamma, q, qdot

% Local Vars 
n    = ab.n ;       % number of joints
A    = zeros(n) ;   % Complete inertia matrix A
H    = []       ;   % Coriolis and centrifugal forces, does not need to init.
Znx1 = zeros(n,1) ; % zeros stuff, avoid multiple calls of zeros()
Z6xn = zeros(6,n) ; % zeros stuff, avoid multiple calls of zeros()
Z3x1 = zeros(3,1) ; % zeros stuff, avoid multiple calls of zeros()

% Get A

for i=1:n,   
  ui = Znx1 ;
  ui(i) = 1 ;
  A(:,i) = ab.rne( q, Znx1, ui, Z3x1, Z6xn )  ;
end

% q
% A
% 
% Get H 
H = ab.rne( q, qdot, Znx1, ab.gravity, Fe ) ;

% Compute joint acceleration

qddot_o = A\( Gamma - H ) ; 


end