%mBody.T Homogeneous Transform of the Body
% Return the Homogeneous Transform of the body based on the modified DH
% parameters [alpha, d, th, r]
% T = Rot('x',a)*Trans('x',d)*Rot('z',t)*Trans('z',r)
%
% T = [ C(th)        -S(th)       0     d       ;
%       C(a)*S(th)   C(a)*C(th)   -S(a) -r*S(a) ;
%       S(a)*S(th)   S(a)*C(th)   C(a)  r*C(a)  ;
%       0           0             0     1       ] ;
%
% avec  th = /sigma*( q+offset ) + sigma*(th)
%       r = sigma*( q+offset ) + /sigma*(r) ;
%
% Possible calls:
% t         = obj.T(q)
% [t, r]    = obj.T(q)
% [t, r, p] = obj.T(q)
%
%     r: 3x3 sub matrix of T corresponding to the rotation matrix
%     p: 3x1 sub matrix of T corresponding to the position
%
% See also mArticulatedBody/T

function [t, r, p] = T(b, q)


if b.sigma, rr = q + b.offset ;  th = b.theta ;
else        th = q + b.offset ;  rr = b.r ;
end

r = [...
  C(th)              -S(th)             0             ;
  C(b.alpha)*S(th)   C(b.alpha)*C(th)   -S(b.alpha)   ;
  S(b.alpha)*S(th)   S(b.alpha)*C(th)   C(b.alpha)    ];

p = [...
  b.d             ;
  -rr*S(b.alpha)  ;
  rr*C(b.alpha)   ] ;

t = [...
  r     p ;
  0 0 0 1 ] ;
end % T()

function c = C(a), c = cos(a)*( a~=abs(pi/2) ) ; end
function s = S(a), s = sin(a)*( a~=abs(pi) ) ; end