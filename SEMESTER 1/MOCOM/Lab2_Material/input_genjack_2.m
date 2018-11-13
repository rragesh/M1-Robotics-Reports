sigma=[0 0 0 0 0 0];
alpha=[0 pi/2 0 -pi/2 pi/2 -pi/2];
d=[0 0 .45 0 0 0 ];
theta=[.1 .3 .6 .5 .4 .8];
r=[0 0 0 .45 0 0];
q=[.3 .3 .3 .3 .3 .3];
J0N = genjac (sigma, alpha, d, theta, r, q)