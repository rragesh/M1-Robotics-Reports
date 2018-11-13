
for i = 1:3
    
    q = rand(1:6);    
    sigma = [0,0,0,0,0,0];
    alpha = [0 pi/2 0 -pi/2 pi/2 -pi/2];
    theta = [q(1) q(2) q(3) q(4) q(5) q(6)];
    d = [0 0 0.45 0 0 0];
    r = [0 0 0 0.45 0 0];
    Q1=JACRX90(theta)
    Q2= genjac(sigma,alpha,d,theta,r,q)
    Q3=Q2-Q1
    
end