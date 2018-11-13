clear; clc;
syms L1 L2 L3 q1 q2 q3;

alpha = sym([0 0 0 0]);
d = [0 L1 L2 L3];
theta = [q1 q2 q3 0];
r = [0 0 0 0];

T0E = DHSym(alpha, d, theta, r);

Px = T0E(1,4);
Py= T0E(2,4);
alp = q1 + q2 + q3;