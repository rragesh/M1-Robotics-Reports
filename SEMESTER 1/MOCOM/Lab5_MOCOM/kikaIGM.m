clc;
clear b p560 kuka
addpath(genpath('mtools_matlab')) ; 
b(1) = mBody(0,[  0     0       0   0     ]);
b(2) = mBody(1,[  pi/2  0       0   0     ]);
b(3) = mBody(2,[ -pi/2  0       0   0.4   ]);
b(4) = mBody(3,[ -pi/2  0       0   0     ]);
b(5) = mBody(4,[  pi/2  0       0   0.39  ]);
b(6) = mBody(5,[  pi/2  0       0   0     ]);
b(7) = mBody(6,[ -pi/2  0       0   0     ]);

kuka = mArticulatedBody(b, 'name', 'KUKA');

qd = 2*pi*rand(kuka.n,1) 
Td = kuka.T(0,kuka.n,qd)
qo = kuka.igm(Td) 
To = kuka.T(0,kuka.n,qo)
error = Td-To