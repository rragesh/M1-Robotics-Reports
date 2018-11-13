    q = [0.6 1.25 -0.3 0.6 0.3 2.0]';
    dq= [0.08 .012 -0.02 0.006 -0.03 0.03]';
    sigma = [0,0,0,0,0,0]';
    alpha = [0 pi/2 0 -pi/2 pi/2 -pi/2]';
    theta = [q(1) q(2) q(3) q(4) q(5) q(6)]';
    d = [0 0 0.45 0 0 0]';
    r = [0 0 0 0.45 0 0]';
    J=genjac(sigma,alpha,d,theta,r,q)
    dX=J*dq
    dX2=DGMRX(q+dq)-DGMRX(q)
    
  
 