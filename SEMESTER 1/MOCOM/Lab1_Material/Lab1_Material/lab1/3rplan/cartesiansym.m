clc;
syms l2 q1 q2 q3 q4 q5 q6  px py alp pi;
alpha = [0 pi/2 pi/2 0 -pi/2 -pi/2];
d = [0 0 0 0 0 0];
theta = [0 pi/2 0 q4 q5 q6];
r = [q1 q2 q3 0 0 0];
DHSym(alpha, d, theta, r)

 T = [ -cos(q6)*sin(q5),  sin(q5)*sin(q6), -cos(q5),q3;
    cos(q4)*sin(q6) - cos(q5)*cos(q6)*sin(q4), cos(q4)*cos(q6) + cos(q5)*sin(q4)*sin(q6),  sin(q4)*sin(q5), -q2;
    sin(q4)*sin(q6) + cos(q4)*cos(q5)*cos(q6), cos(q6)*sin(q4) - cos(q4)*cos(q5)*sin(q6), -cos(q4)*sin(q5),  q1;
        0,   0, 0,1];
