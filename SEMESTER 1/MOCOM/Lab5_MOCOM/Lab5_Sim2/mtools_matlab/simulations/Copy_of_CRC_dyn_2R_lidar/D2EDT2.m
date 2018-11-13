function d2edt2 = D2EDT2(L, q, dq, ddq, P, dP, ddP)

q_1 = q(1) ; 
q_2 = q(2) ; 

dq_1 = dq(1) ; 
dq_2 = dq(2) ; 

ddq_1 = ddq(1) ; 
ddq_2 = ddq(2) ; 

x_p = P(1) ; 
y_p = P(2) ; 

dx_p = dP(1) ; 
dy_p = dP(2) ; 

ddx_p = ddP(1) ; 
ddy_p = ddP(2) ; 

S1 = sin(q_1) ; 
C1 = cos(q_1) ; 
S12 = sin(q_1+q_2) ; 
C12 = cos(q_1+q_2) ; 

d2edt2 = 2*(dx_p  + L*dq_1 *S1 + L*S12*(dq_1  + dq_2 ))^2 ...
    + 2*(L*dq_1 *C1 - dy_p  + L*C12*(dq_1  + dq_2 ))^2 ...
    - 2*(L*C12 - x_p  + L*C1)*(ddx_p  + L*C12*(dq_1  + dq_2 )^2 ...
    + L*S1*ddq_1  + L*dq_1 ^2*C1 + L*S12*(ddq_1  ...
    + ddq_2 )) - 2*(L*S1 - y_p  + L*S12)*(ddy_p  + L*S12*(dq_1  + dq_2 )^2 ...
    - L*C1*ddq_1  - L*C12*(ddq_1  + ddq_2 ) + L*dq_1 ^2*S1) ;

end