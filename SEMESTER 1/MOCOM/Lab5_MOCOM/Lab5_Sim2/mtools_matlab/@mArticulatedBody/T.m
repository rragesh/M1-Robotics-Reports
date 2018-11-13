%mArticulatedBody.T Homogeneous Transform T
% Return the HT from the body i to j respecting the smallest path in
% the articulated chain, knowing the joint value vector nx1 q.
% 
% Possible calls: 
% t         = obj.T(ab, i, j, q)
% [t, r]    = obj.T(ab, i, j, q)
% [t, r, p] = obj.T(ab, i, j, q)
% 
%     r: rotation 3x3 sub matrix of T
%     p: position 3x1 sub matrix of T
% 
% See also mBody.T

% TODO: Impl�mentation Mod�le g�om direct pour la robotique parall�le
% NOTE: le DGM pour la robotique parall�le n�cessite de calculer
% explicitement les valeurs des articulations passives (cf. morob ass2
% passive joint calculation), bas�e sur la jacobienne de la structure. Il
% est possible de passer outre pour les structures simples en
% choississant un chemin qui ne comporte pas d'articulations passives, mais
% �a ne r�gle pas le probl�me.

function [t, r, p] = T(ab, i, j, q)

path = getPath(ab,i,j); 

% Test if there are passive joint in the body chain.
if any(~[ab.body(path).mu]), 
  error(['This current version does not allow the '...
    'use of passive joint. Should be implemented with parallel robotics' ...
    'support.']) ;
end

t = eye(4) ;

for pp=path,     
    t = t*ab.body(pp).T(q(pp)) ; 
end

r = t(1:3, 1:3) ; 
p = t(1:3, 4) ; 

end % T()

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

