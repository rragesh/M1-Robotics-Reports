syms q2 q3
%CASE 1
D3 = 0.45;
RL4 = 0.45;
figure(1);
ezplot((RL4*sin(q2+q3) - D3*cos(q2)),[-pi pi -pi pi]);
hold on;
ezplot(cos(q3)*(RL4*sin(q2+q3) - D3*cos(q2)),[-pi pi -pi pi]);

%CASE 2
D3 = 0.55;
RL4 = 0.45;
figure(2);
ezplot((RL4*sin(q2+q3) - D3*cos(q2)),[-pi pi -pi pi]);
hold on;
ezplot(cos(q3)*(RL4*sin(q2+q3) - D3*cos(q2)),[-pi pi -pi pi]);