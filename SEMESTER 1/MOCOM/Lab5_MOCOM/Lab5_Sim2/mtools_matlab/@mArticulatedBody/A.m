%%mArticulatedBody.A Kinetic energy matrice of the articulated system
% Compute the generalized inertia matrice of the complete system, using the
% RNE algorithm. 
% Warning: this is not supposed to be computional efficient !
% Sylvain Vandernotte, 20140731, IRTJV

function a = A(ab,q)

persistent Znx1 Z3x1 Z6xn
if( isempty(Znx1) ), 
    Znx1 = zeros(ab.n,1) ;
    Z3x1 = zeros(3,1) ;
    Z6xn = zeros(6,ab.n) ;
end
a = zeros(ab.n) ;

for i=1:ab.n,   
  ui = Znx1 ;
  ui(i) = 1 ;
  a(:,i) = ab.rne( q, Znx1, ui, Z3x1, Z6xn )  ;
end
  
end