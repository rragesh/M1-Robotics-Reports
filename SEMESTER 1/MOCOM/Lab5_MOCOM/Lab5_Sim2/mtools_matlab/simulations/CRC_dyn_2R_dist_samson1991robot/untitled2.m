%%

syms x y x_d y_d l C12 S12

h = (x-x_d)^2 + (y-y_d)^2 ; 

gradient(h,[x;y]) 

s = [   2*(x-x_d)   ;
        2*(y-y_d)   ] ;

% s = [   x*(x-x_d) - y*(y-y_d) ; 
%         l*C12*(y-y_d) - l*S12*(x-x_d) ] ;
    
dsdx = jacobian(s,[x;y])


return

%%
clear

syms l 
q_1 = sym('q_1(t)') ;
q_2 = sym('q_2(t)') ;
x_d = sym('x_d(t)') ;
y_d = sym('y_d(t)') ;
x = sym('x(t)') ;
y = sym('y(t)') ;

C12 = cos(q_1+q_2) ; 
S12 = sin(q_1+q_2) ; 

dsdx = [  2*x - x_d  y_d - 2*y  ;
         -S12*l      C12*l      ] ;
     
d2sdxdt = simplify(diff(dsdx, 't'))