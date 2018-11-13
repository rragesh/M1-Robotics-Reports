mdl_lwr4; % Initializing KUKA model

qq = zeros(7,1)
Td = lwr4.T(0,lwr4.n,qq);
qo = lwr4.igm(Td)
To = lwr4.T(0,lwr4.n,qo);

To-Td