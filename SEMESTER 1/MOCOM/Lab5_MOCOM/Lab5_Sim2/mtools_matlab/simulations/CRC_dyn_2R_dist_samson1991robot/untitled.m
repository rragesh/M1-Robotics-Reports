

%% with t


% syms L1 L2 q1(t) q2(t) xp yp
syms L q_1 q_2 x_p y_p x_e y_e

q = [q_1 ; q_2]

C1 = cos(q_1) ;
C12 = cos(q_1+q_2) ;
S1 = sin(q_1) ;
S12 = sin(q_1+q_2) ;

return

%%

x_e = L*C1 + L*C12 ;
y_e = L*S1 + L*S12 ;
d = sqrt( sum( [x_p-x_e; y_p-y_e].^2 )) ;

e = sum( [x_p-x_e; y_p-y_e].^2 );

dedq = simplify(jacobian(e,q))

 X = [x_e ; y_e]
 
 return 
 %%
 
 dedq = ...
     [   -2*L*(y_p*cos(q_1 + q_2) - x_p*sin(q_1 + q_2) + y_p*cos(q_1) - x_p*sin(q_1)), 2*L*x_p*sin(q_1 + q_2) - 2*L*y_p*cos(q_1 + q_2) - 2*L^2*sin(q_2) ] ;
 

d2edq2 = [ 
    2*L*(x_p*cos(q_1 + q_2) + y_p*sin(q_1 + q_2) + x_p*cos(q_1) + y_p*sin(q_1)),                  2*L*x_p*cos(q_1 + q_2) + 2*L*y_p*sin(q_1 + q_2) ; 
                              2*L*x_p*cos(q_1 + q_2) + 2*L*y_p*sin(q_1 + q_2),      2*L*x_p*cos(q_1 + q_2) - 2*L^2*cos(q_2) + 2*L*y_p*sin(q_1 + q_2)   ] ;


d2edqdt = [
 2*L*(sin(q_1(t))*diff(x_p(t), t) - cos(q_1(t))*diff(y_p(t), t) - cos(q_1(t) + q_2(t))*diff(y_p(t), t) + sin(q_1(t) + q_2(t))*diff(x_p(t), t) + cos(q_1(t))*x_p(t)*diff(q_1(t), t) + sin(q_1(t))*y_p(t)*diff(q_1(t), t) + cos(q_1(t) + q_2(t))*x_p(t)*(diff(q_1(t), t) + diff(q_2(t), t)) + sin(q_1(t) + q_2(t))*y_p(t)*(diff(q_1(t), t) + diff(q_2(t), t)))
                                                                                         2*L*sin(q_1(t) + q_2(t))*diff(x_p(t), t) - 2*L^2*cos(q_2(t))*diff(q_2(t), t) - 2*L*cos(q_1(t) + q_2(t))*diff(y_p(t), t) + 2*L*cos(q_1(t) + q_2(t))*x_p(t)*(diff(q_1(t), t) + diff(q_2(t), t)) + 2*L*sin(q_1(t) + q_2(t))*y_p(t)*(diff(q_1(t), t) + diff(q_2(t), t)) ] ;
                                                                                     
d2edt2 = 2*(D(x_p)(t) + L*D(q_1)(t)*sin(q_1(t)) + L*sin(q_1(t) + q_2(t))*(D(q_1)(t) + D(q_2)(t)))^2 + 2*(L*D(q_1)(t)*cos(q_1(t)) - D(y_p)(t) + L*cos(q_1(t) + q_2(t))*(D(q_1)(t) + D(q_2)(t)))^2 - 2*(L*cos(q_1(t) + q_2(t)) - x_p(t) + L*cos(q_1(t)))*(D(D(x_p))(t) + L*cos(q_1(t) + q_2(t))*(D(q_1)(t) + D(q_2)(t))^2 + L*sin(q_1(t))*D(D(q_1))(t) + L*D(q_1)(t)^2*cos(q_1(t)) + L*sin(q_1(t) + q_2(t))*(D(D(q_1))(t) + D(D(q_2))(t))) - 2*(L*sin(q_1(t)) - y_p(t) + L*sin(q_1(t) + q_2(t)))*(D(D(y_p))(t) + L*sin(q_1(t) + q_2(t))*(D(q_1)(t) + D(q_2)(t))^2 - L*cos(q_1(t))*D(D(q_1))(t) - L*cos(q_1(t) + q_2(t))*(D(D(q_1))(t) + D(D(q_2))(t)) + L*D(q_1)(t)^2*sin(q_1(t)))

return

%%
syms L q_1(t) q_2(t) x_p(t) y_p(t)
