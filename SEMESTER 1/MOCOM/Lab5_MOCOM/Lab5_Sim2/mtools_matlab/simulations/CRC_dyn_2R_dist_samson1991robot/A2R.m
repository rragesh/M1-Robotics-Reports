function A = A2R(ab,q)

t2 = q(2) ;
ZZ1 = ab.body(1).I(3) ; 
ZZ2 = ab.body(2).I(3) ;  
L1 = ab.body(2).d ;
[MX2, MY2, ~] = splitrow( ab.body(2).m.*ab.body(2).cg ); 
M2 = ab.body(2).m ;

% A is taken from mocom_assignment_6_cr, 201101xx, sylvain Vandernotte,
% Master ASP1
A = zeros(2) ;
A(1,1) = ZZ1 + ZZ2 + L1^2*M2 + 2*L1*MX2*cos(t2) - 2*L1*MY2*sin(t2) ; 
A(1,2) = ZZ2 + L1*MX2*cos(t2) - L1*MY2*sin(t2) ; 
A(2,1) = ZZ2 + L1*MX2*cos(t2) - L1*MY2*sin(t2) ; % A(1,2) = A(2,1) 
A(2,2) = ZZ2 ;


end