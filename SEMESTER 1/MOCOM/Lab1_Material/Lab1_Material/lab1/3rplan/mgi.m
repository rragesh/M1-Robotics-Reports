% Computing IGM of a 3R planar robot
% 10

disp('entrer les valeurs des variables operationnelles');
Px = input('Px = ');
Py = input('Py = ');
alpha = input('alpha = ');

% To be modified
% Complete the code to compute the two solutions for theta1 and theta2

Z1 = Px -cos(alpha).*L3;
Z2 = Py -sin(alpha).*L3;
X = L1; Y = L2;
Cth = (Z1^2 + Z2^2 -X^2 -Y^2)/(2*X*Y);

q21=atan2(sqrt(1-Cth^2),Cth);
q22=atan2(-sqrt(1-Cth^2),Cth);

B11 = X + Y*cos(q21);
B12 = Y*sin(q21);

B21 = X + Y*cos(q22);
B22 = Y*sin(q22);

sth11 = (B11*Z2 - B12*Z1)/(B11^2+B12^2);
cth11 = (B11*Z1 + B12*Z2)/(B11^2+B12^2);

sth12 = (B21*Z2 - B22*Z1)/(B21^2+B22^2);
cth12 = (B21*Z1 + B22*Z2)/(B21^2+B22^2);

q11=atan2(sth11,cth11);
q12=atan2(sth12,cth12);

% Computing theta3
q31=alpha-q21-q11;
q32=alpha-q22-q12;

% Putting solutions together in one matrix
qsol=[q11,q12;
      q21,q22;
      q31,q32]

if (q21 == 0 & q22 == 0 )
    nbsolution = 1
else
    nbsolution = 2
end;

