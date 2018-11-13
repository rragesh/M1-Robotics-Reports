sigma=[0 0 0 0 0 0];
alpha=[0 pi/2 0 -pi/2 pi/2 -pi/2];
d=[0 0 .45 0 0 0 ];
r=[0 0 0 .45 0 0];
q=[0.6  1.25  -0.3  0.6  0.3  2.0];
theta=q;

J0N = genjac (sigma, alpha, d, theta, r, q)