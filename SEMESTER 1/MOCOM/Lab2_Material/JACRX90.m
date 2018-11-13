function J06 = JACRX90(q)
 D3=0.45;
 RL4=0.45; 
 
q1=q(1);
q2=q(2);
q3=q(3);
q4=q(4);
q5=q(5);
q6=q(6);

J36=[0,-RL4+sin(q3)*D3, -RL4, 0, 0, 0;
    0, cos(q3)*D3, 0,0,0,0;
    (sin(q2+q3)*RL4-cos(q2)*D3), 0, 0, 0, 0, 0;
    sin(q2+q3), 0,0,0,sin(q4), -sin(q5)*cos(q4);
    cos(q2+q3),0,0,1,0,cos(q5);
    0,1,1,0,cos(q4),sin(q5)*sin(q4)];
R01=[cos(q1), -1*sin(q1),0;
    sin(q1), cos(q1),0;
    0,0,1];
R12=[cos(q2) -1*sin(q2), 0;
    0,0,-1;
    sin(q2),cos(q2),0];
R23=[-1*sin(q3), -1*cos(q3),0;
    cos(q3), -1*sin(q3),0;
    0,0,1];
R03=R01*R12*R23;
J03=[R03, zeros(3);
    zeros(3), R03];

J06=J03*J36

end