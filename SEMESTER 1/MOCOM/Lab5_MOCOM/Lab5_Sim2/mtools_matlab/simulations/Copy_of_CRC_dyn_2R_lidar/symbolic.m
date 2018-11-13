%% 

clear

syms x_p y_p x y

d2 = (x_p-x)^2 + (y_p-y)^2 ;

th = atan( (y_p-y)/(x_p-x) ) ;

s = [d2; th] ;
X = [x ; y] ; 

dsdX = simplify(jacobian(s,X))

syms L q_1 q_2 x y 

q = [q_1 ; q_2]

C1 = cos(q_1) ;
C12 = cos(q_1+q_2) ;
S1 = sin(q_1) ;
S12 = sin(q_1+q_2) ;

x = L*(C1+C12) ; 
y = L*(S1+S12) ;
X = [x;y] ;

dXdq = simplify(jacobian(X, [q_1;q_2]))


%%

clear 

x_p = sym('x_p(t)'); 
y_p = sym('y_p(t)'); 
x   = sym('x(t)'); 
y   = sym('y(t)'); 

dsdX = [    2*x - 2*x_p,     2*y - 2*y_p ;
            -(y - y_p)/((x - x_p)^2*((y - y_p)^2/(x - x_p)^2 + 1)), 1/((x - x_p)*((y - y_p)^2/(x - x_p)^2 + 1)) ] ;

d2sdXdt = diff(dsdX, 't') 

