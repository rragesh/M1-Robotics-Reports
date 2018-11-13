function d2edqdt = D2EDQDT(L, q, dq, P, dP)

q_1 = q(1) ; 
q_2 = q(2) ; 

dq_1 = dq(1) ; 
dq_2 = dq(2) ; 

x_p = P(1) ; 
y_p = P(2) ; 

dx_p = dP(1) ; 
dy_p = dP(2) ; 

S1 = sin(q_1) ; 
C1 = cos(q_1) ; 
C2 = cos(q_2) ; 
S12 = sin(q_1+q_2) ; 
C12 = cos(q_1+q_2) ; 

d2edqdt = [ 2*L*(S1*dx_p - C1*dy_p - C12*dy_p + S12*dx_p + C1*x_p *dq_1 + S1*y_p *dq_1 + C12*x_p *(dq_1 + dq_2) + S12*y_p *(dq_1 + dq_2)) ;
            2*L*S12*dx_p - 2*L^2*C2*dq_2 - 2*L*C12*dy_p + 2*L*C12*x_p *(dq_1 + dq_2) + 2*L*S12*y_p *(dq_1 + dq_2) ] ;

end