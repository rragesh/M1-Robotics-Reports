function dedq = DEDQ(L, q, P)

q_1 = q(1) ; 
q_2 = q(2) ; 

x_p = P(1) ; 
y_p = P(2) ; 

dedq = zeros(1,2) ; 
dedq(1) = -2*L*(y_p*cos(q_1 + q_2) - x_p*sin(q_1 + q_2) + y_p*cos(q_1) - x_p*sin(q_1)) ;
dedq(2) = 2*L*x_p*sin(q_1 + q_2) - 2*L*y_p*cos(q_1 + q_2) - 2*L^2*sin(q_2) ;   

endn