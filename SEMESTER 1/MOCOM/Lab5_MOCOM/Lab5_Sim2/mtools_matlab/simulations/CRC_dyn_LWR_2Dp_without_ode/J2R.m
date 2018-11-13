function J = J2R(ab,q)

L1 = ab.body(2).d ; 
L2 = ab.E(1,4) ; 

S1 = sin(q(1)) ; 
S12 = sin(q(1)+q(2)) ;

C1 = cos(q(1)) ; 
C12 = cos(q(1)+q(2)) ;

J = [   -L1*S1-L2*S12  -S12*L1 ;   
        L1*C1+L2*C12   L2*C12 ] ;

end