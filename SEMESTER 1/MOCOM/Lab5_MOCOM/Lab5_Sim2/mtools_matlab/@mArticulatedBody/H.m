%%mArticulatedBody.H Vector of Coriolis and Centrifugal Force
% Compute the coriolis, centrifugal and gravity force vector for an
% articulated body, by the use of the recursive newton-euler algorithm
% Sylvain Vandernotte, 20140731, IRTJV
%
% See also mArticulatedBody/rne mArticulatedBody/ddym mArticulatedBody/A

function h = H(ab,q,qdot,Fe)

persistent Znx1 Z6xn
if( isempty(Znx1) ), 
    Znx1 = zeros(ab.n,1) ;
    Z6xn = zeros(6,ab.n) ;
end

if nargin<=3, Fe = Z6xn ; end ;

h = ab.rne( q, qdot, Znx1, ab.gravity, Fe ) ;
  
end