function Jd = Jd2R(ab, q, qd) 

L1 = ab.body(2).d ; 
L2 = ab.E(1,4) ; 

Jd = zeros(2) ;
Jd(1,1) = - L2*cos(q(1) + q(2))*(qd(1) + qd(2)) - L1*cos(q(1))*qd(1) ;
Jd(1,2) = - L1*cos(q(1) + q(2))*(qd(1) + qd(2)) ;
Jd(2,1) = - L2*sin(q(1) + q(2))*(qd(1) + qd(2)) - L1*sin(q(1))*qd(1) ; 
Jd(2,2) = - L2*sin(q(1) + q(2))*(qd(1) + qd(2)) ; 

end