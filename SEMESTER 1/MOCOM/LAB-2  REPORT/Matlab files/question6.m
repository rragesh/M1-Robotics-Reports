q = [0.2, -0.3, -pi/2, 0.6, 0, 0.7];
J = JACRX90(q);
[m n] = size(J);
[U,S,V] = svd(J);
    display(U);
    display(S);
    display(V);
    
 r = rank(S);
 display('the null space of J');
 nullspace = V(:,r+1:n)
 display('The subspace generating Cartesian velocities');
 cartesianvel = V(:,1:r)
 display('The subspace of the achievable Cartesian velocity');
 AV = U(:,1:r)
 display('The subspace of the Cartesian velocities that cannot be generated');
 UAV = U(:,r+1:m)
  