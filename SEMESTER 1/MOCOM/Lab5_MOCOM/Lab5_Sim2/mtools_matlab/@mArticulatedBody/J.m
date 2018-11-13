%mArticulatedBody.J Kinematic Model, Jacobian based.
% Return the jacobian matrix refered to the inverse kinematic model of the
% robot/articulated body chain, from body i to j in current configuration
% q.
% 
%     Xdot = J*qdot
% 
% with: 
%   Xdot  velocity component of the end effector 
%   qdot  the joint speeds, 
%
% Warning : dos not support parallel structure.
% 
% See also mArticulatedBody.igm

function j = J(ab, i, j, q)

path = getPath(ab,i,j) ;

% Test if there are passive joint in the body chain.
if any(~[ab.body(path).mu]), 
  error(['This current version does not allow the '...
    'use of passive joint. Should be implemented with parallel robotics' ...
    'support.']) ;
end

n = length(path) ;
a = cell(1,n) ;
p = cell(1,n) ;

% 1st : get a0_i and p0_i from the direct geometric model
for i=1:n, 
%   i;
  [~, oR, oP{i}] = ab.T(0, path(i), q) ; 
  oA{i} = oR(:,3) ;
%   t;
end
% 
% disp '---';
% p{n};
% disp '---';

% 2nd : Using the equation [5.15] in Advanced Modelling of Robots, [Khalil
% and Dombre, 2002] depending on the joint type, we build each column i of 
% the matrix J.
j = zeros(6,n) ; 
for k=1:n
%     i-1;
%     p{i};
%     a{i};
    
  if ab.body(path(k)).sigma
    j(1:3,k) = oA{k} ;
  else    
    j(:, k) = [skew(oA{k})*(oP{n}-oP{k}) ; oA{k}] ;
  end
end

end % J()

%GetPath Private func Get the Path 
% Find paths from the ith jth joint, in order to select the correct HT to
% compute.
function p = getPath(ab, i, j)

p = zeros(1,10) ;
n = 10 ;
p(end)=j ; 

while true
  parent = ab.body(p(n)).parent ;
  
  if any(parent==[0 i]), break ; end  
  n=n-1 ; 
  p(n) = parent ;
end  

p = p(p~=0) ;

end % path()

