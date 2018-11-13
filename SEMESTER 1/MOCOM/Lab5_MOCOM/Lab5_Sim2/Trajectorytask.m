function T = taskTraj( Ti, Tf, t)
Ri = Ti(1:3,1:3);
Rf = Tf(1:3,1:3);

Pi = Ti(1:3,4);
Pf = Tf(1:3,4);

D = norm(Pf-Pi);

kv = 1; %max joint vel
ka = 3; %max joint acc


tf = max(1.5*(D/kv),sqrt(6*D/ka)); % tf for cubic interpolation
rt = 3*(t/tf).^2 - 2*(t/tf).^3; % interpolation function

P = Pi + rt.*(Pf-Pi); % calculating change in position

uth = vrrotmat2vec(Ri'*Rf); % calculating change in orientation
u = uth(1:3);
th = uth(4);

r = [ones(length(rt),1)*u (rt.*th)'];
R = Ri*vrrotvec2mat(r);

T = [R P; 0 0 0 1];


end