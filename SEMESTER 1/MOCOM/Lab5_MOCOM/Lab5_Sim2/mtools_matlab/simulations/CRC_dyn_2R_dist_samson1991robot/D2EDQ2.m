function d2edq2 = D2EDQ2(L, q, P)

q_1 = q(1) ; 
q_2 = q(2) ; 

x_p = P(1) ; 
y_p = P(2) ; 

d2edq2 = [ 
    2*L*(x_p*cos(q_1 + q_2) + y_p*sin(q_1 + q_2) + x_p*cos(q_1) + y_p*sin(q_1)),                  2*L*x_p*cos(q_1 + q_2) + 2*L*y_p*sin(q_1 + q_2) ; 
                              2*L*x_p*cos(q_1 + q_2) + 2*L*y_p*sin(q_1 + q_2),      2*L*x_p*cos(q_1 + q_2) - 2*L^2*cos(q_2) + 2*L*y_p*sin(q_1 + q_2)   ] ;

end