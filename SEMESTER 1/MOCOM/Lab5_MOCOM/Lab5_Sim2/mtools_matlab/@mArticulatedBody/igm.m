%mArticulatedBody.igm Inverse Geometric Model
% Compute the joint variables knowing the pose of the end effector. It uses
% the numerical solution of the inverse geometric model proposed by Khalil
% [Khalil & Dombre, 2002] based on the use of the jacobian of the chain.
%
% See also mArticulatedBody.J
%
% TODO: implementer les crit�res d'�vitement limite art. et singularit�

function qf = igm(ab,Tf,varargin)

% local vars
n = ab.n ;        % number of joints
qc = rand(n,1) ;  % initial random configuration
p = 1:3 ;         % [1 2 3] range
r = 4:6 ;         % [4 5 6] range
Sp = .1 ;
Sr = .1 ;

% loop control vars
tr      = 1 ;       % current try
ntries  = 5 ;       % number of tries to look for solution
itout   = 1000 ;    % iteration limit to drop the solution
it      = 1 ;       % number of iteration

% variable input management
for i=1:2:length(varargin)
  switch varargin{i}
    case {'qi', 'init'}
      qc = varargin{i+1} ;
    otherwise
      error('Unkown argument %s.', varargin{i}) ;
  end
end

% main loop
while true
  
  % get HT of the end effector knowing the current configuration.
  Tc = ab.Z*ab.T(0,n,qc)*ab.E ;
  % get rotational data u, alpha from the 3D rotation matrix.
  [alpha, u] = q2au(R2q( Tf(p,p)*Tc(p,p).' )) ;
  
  % error
  dX = [...
    Tf(p,4)-Tc(p,4) ;
    u.*alpha        ] ;
  
  % the computation is valable only for little displacement.
  % if the error step is too large, reduce it.
  if norm(dX(p))>Sp, dX(p) = dX(p)/norm(dX(p))*Sp ; end
  if norm(dX(r))>Sr, dX(r) = dX(r)/norm(dX(r))*Sr ; end
  
  % get little displacement in joint space using the pseudo inverse of
  % jacobian.
  dq = pinv( ab.J(0,n,qc) )*dX  ;
  
  % update the configuration.
  qc = qc + dq;
  
  
  % if the desire pose and the current one are equal, then stop.
  if all(all( abs(Tf-Tc)<1e-6 )), break ; end
  
  % loop control
  % loop control stuffs are necessary: since the computation start from a
  % random set, we don't known how the random set correspond to the actual
  % situation of the robot/ab. Then a try is supposed to converge in ITOUT
  % iterations maximum. The loop is able to restart over NTRIES tries, in
  % case of the system has not converged because of the paticular random
  % set.
  if it>=itout,
    
    tr = tr +1 ;
    if tr>=ntries,
      warning(['The Inverse Geometric Model function could not find a' ...
        ' suitable solution for requested input. Maybe the desired pose' ...
        ' is not reachable.'])
      qc = NaN(n,1) ;
      break ;
    end
    
    % the current try already did itout iterations to converge and
    % unfortunately cannot. Recharge a new random configuration to perform
    % a new try.
    it = 1 ;
    qc = rand(n,1) ;
    
  else 
      it = it + 1; 
  end
  
end % while

% if some joits are revolute, need to express this in interval [-*pi, 2*pi]
for i=1:n,
  if ~ab.body(i).sigma
    if qc(i)<0
      qc(i) = mod(qc(i), -pi*2);
    else
      qc(i) = mod(qc(i), pi*2) ;
    end
  end
end

qf = qc ;

return % igm()

%%
% test code for mArticulatedBody.igm
% Puma 560
% Geometric parameters
clc;
clear b p560
b(1) = mBody(0,[  0     0       0   0     ]);
b(2) = mBody(1,[ -pi/2  0       0   .2435 ]);
b(3) = mBody(2,[  0     .4318   0  -.0934 ]);
b(4) = mBody(3,[  pi/2  -.0203  0   .4331 ]);
b(5) = mBody(4,[ -pi/2  0       0   0     ]);
b(6) = mBody(5,[  pi/2  0       0   0     ]);

p560 = mArticulatedBody(b, 'name', 'Puma 560');

qd = 2*pi*rand(p560.n,1) 
Td = p560.T(0,p560.n,qd)
qo = p560.igm(Td) 
To = p560.T(0,p560.n,qo)
Td-To

