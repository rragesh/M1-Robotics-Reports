clc;
syms l1 l2 l3 q1 q2 q3 px py alp;
alpha = [0 0 0 0];
d = [0 l1 l2 l3];
theta = [q1 q2 q3 0];
r = [0 0 0 0];
DHSym(alpha, d, theta, r)


T=[ cos(q1 + q2 + q3), -sin(q1 + q2 + q3), 0, l2*cos(q1 + q2) + l1*cos(q1) + l3*cos(q1 + q2 + q3); 
    sin(q1 + q2 + q3),  cos(q1 + q2 + q3), 0, l2*sin(q1 + q2) + l1*sin(q1) + l3*sin(q1 + q2 + q3);
    0,0,1,0;
    0,0,0,1 ];
    
px = T(1,4)
py = T(2,4)
alp = q1 + q2 + q3