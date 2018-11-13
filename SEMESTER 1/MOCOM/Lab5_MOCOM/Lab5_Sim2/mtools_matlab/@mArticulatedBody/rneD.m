%mArticulatedBody.rneD Direct dynamic model using recursive newton euler
%algorithm
% Compute the direct dynamic model of the articulated chain by the use of
% Newton Euler algorithm [Luth et al., 1980] and does not use explicitly
% the inertia matrix of the articulated chain [Amstrong 79], [Featherstone
% 83b], [Brandl 86]
%
%     qddot = f(q, qdot, Gamma, G, Fe)
%
%with:
%   Gamma       joint torques
%   q, qdot, qddot joint pos, speed and acceleration
%   G Gravity
%   Fe vector of forces and moments exerted by the chain on the envirenment
%   
% this Algorith is extracted from "Dombre, E. and Khalil, W. (eds) (2010)
% Frontmatter, in Modeling, Performance Analysis and Control of Robot 
% Manipulators, ISTE, London, UK. doi: 10.1002/9780470612286.fmatter"
% Khalid El-Azzouzi - IRT Jules Verne - May 2014

function qddot = rneD(ab, q, qdot, Gamma, G, Fe)

% % manage the inputs

switch nargin
    case 3
        Gamma = zero(ab.n,1);
        G = zeros(3,1);
        Fe = zeros(6,ab.n);
    case 4
        Fe = zeros(6,ab.n);
        G = zeros(ab.n,1);
    case 5
        Fe = zeros(6,ab.n);
end



%% NE: Vars initialization
n = ab.n ;        % number of joints
aj_j = [0;0;1] ;  % a vector of j wrt j


%% First Forward loop:

% screw transformation matrices
Rj_i     = cell(1,n) ;
Pi_j     = cell(1,n) ;
Tj_i     = cell(1,n);
for j=1:n
   
  [T, Ri_j, Pi_j{j}] = ab.body(j).T(q(j));  
  Rj_i{j} = Ri_j.';
  Tj_i{j} = velocityTwistMatrix( inv(T) ) ;
  
end
 
wi_i     = zeros(3,1);
Gammaj_j = cell(1,n);
Betaj_j  = cell(1,n);
%MSj_j   = cell(1,n);
JJj_j    = cell(1,n);

for j=1:n  

  % data bodies 
  s        = ab.body(j).sigma ;
  aaj_j    = [s*aj_j; not(s)*aj_j];
  Mj       = ab.body(j).m ;
  CGj      = ab.body(j).cg ;  
  Jj_j     = ab.body(j).inertia() ;
  MSj_j    = Mj*CGj;
 
  %   Computation of the inertia screw matrices, "JJ".
  JJj_j{j} = [Mj*eye(3,3), -Mj*skew(CGj); Mj*skew(CGj), Jj_j];
  
  % angular velocities
  wj_i  = Rj_i{j}*wi_i ;
  wj_j  = wj_i + not(s)*qdot(j).*aj_j ;
  
  % Computation of the acceleration tribute related to gamma.
  Gamma1 = Rj_i{j}*(cross(wi_i,cross(wi_i,Pi_j{j})))+2*s*cross(wj_i,qdot(j)*aj_j);
  Gamma2 = not(s)*cross(wj_i,qdot(j)*aj_j);
  Gammaj_j{j} = [Gamma1; Gamma2];
  
  % Computation of the Newton-Euler terms that are indpendent from the the mobile frame.
  Betaj_j{j} = -Fe(1:6,j) - [cross(wj_j,cross(wj_j,MSj_j)); ...
        cross(wj_j,Jj_j*wj_j)];
  
  % Prepare the next iteration
  wi_i  = wj_j ;
  
  
end %% First Forward loop


%% Backword loop:

JJcj_j    = cell(1,n);       % the inertia tensor of the composite links.
Betacj_j  = cell(1,n);       % the Newton-Euler terms that are indpendent from the the mobile frame, for composite links.
Hj        = cell(1,n);
KKj_j     = cell(1,n);
alphaj_j  = cell(1,n);
Tau       = zeros(n,1); 

%initialisation Betacj_j et JJcj_j
JJcj_j{n}  = JJj_j{n};
Betacj_j{n}= Betaj_j{n};

for j = n:(-1):1
    
    % data bodies 
    s     = ab.body(j).sigma ;
    aaj_j = [s*aj_j; not(s)*aj_j];
    Iaj   = ab.body(j).Ia ;
    Fc    = ab.body(j).Fc ;
    Fv    = ab.body(j).Fv ;
    
    % couple articulaire
    Tau(j,1) = Gamma(j,1) - Fc*sign(qdot(j)) - Fv*qdot(j);
    
    % Computation of the terms needed to compiute the inertia tensor of the composite links.
    Hj{j}     = transpose(aaj_j)*JJcj_j{j}*aaj_j + Iaj;
    
    KKj_j{j}     = JJcj_j{j} - ...
                        JJcj_j{j}*aaj_j/Hj{j}*transpose(aaj_j)*JJcj_j{j};
    
    
    alphaj_j{j} = KKj_j{j}*Gammaj_j{j}+JJcj_j{j}*aaj_j/Hj{j}*(Tau(j,1)+transpose(aaj_j)*Betacj_j{j})...
                 -Betacj_j{j};
    if j~=1
    % Computation of the inertia tensor of the composite links.
    JJcj_j{1,j-1} = JJj_j{1,j-1} + transpose(Tj_i{j})*KKj_j{j}*Tj_i{j};
 
    % computation of the Newton-Euler terms that are indpendent from the the mobile frame, for composite links.
    Betacj_j{1,j-1} = Betaj_j{1,j-1} - transpose(Tj_i{j})*alphaj_j{j};

    end

end %% Backword loop

%% Second Forward loop : 

%linear and angular acceleration
VVdotj_j = cell(1,n);
qddot    = zeros(n,1);
ffj_j    = cell(1,n);

%     %initialisation
VVdoti_i = [-G;0;0;0];

for j=1:n
    
    %acceleration 
    VVdotj_i = Tj_i{j}*VVdoti_i;

    qddot(j) = (1/Hj{j})*(-transpose(aaj_j)*JJcj_j{j}*(VVdotj_i + Gammaj_j{j}) + Tau(j,1)...
           + transpose(aaj_j)*Betacj_j{j});       
    VVdotj_j{j} = VVdotj_i + aaj_j*qddot(j) + Gammaj_j{j};
    
    %the reactions forces and moments on link j
    ffj_j{j} = KKj_j{j}*VVdotj_i + Gammaj_j{j};
    
    % Prepare the next iteration    
    VVdoti_i = VVdotj_j{j};
  
end
 
return