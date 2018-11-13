clc
% Compute DGM of a 3R planar robot
% input section
disp('entre the value Q');
q1=input('q1 = ');
q2=input('q2 = ');
q3=input('q3 = ');

disp('Link lengths');
l1=input('l1 = ');
l2=input('l2 = ');
l3=input('l3 = ');
q=[q1;q2;q3];

% To be modified
Px = l2*cos(q1 + q2) + l1*cos(q1) + l3*cos(q1 + q2 + q3); 
Py = l2*sin(q1 + q2) + l1*sin(q1) + l3*sin(q1 + q2 + q3); 
alpha = q1 + q2 + q3;


disp('Displaying the results')
xf=[Px;Py;alpha]

qsol=[q1;
      q2;
      q3]


nbsolution=1

