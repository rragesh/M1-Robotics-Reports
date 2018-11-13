%SKEWSYM Skew-symetric matrix for 3x1 vector
% Return the skew symetric matrix for 3x1 vector.
% [q]x = skewsym(q) = [...
%      0   -q3  q2   ; 
%     q3  0    -q1   ; 
%      -q2  q1  0    ]; 
%
% The property of SS matrix allow to transform cross product in matrix
% product: 
%   cross(a,b) = skewsym(a)*b

function m = skew(v)

[v1, v2, v3] = splitrow(v) ;
m = [...
   0 -v3  v2 ; 
  v3   0 -v1 ; 
 -v2  v1   0 ] ;

end