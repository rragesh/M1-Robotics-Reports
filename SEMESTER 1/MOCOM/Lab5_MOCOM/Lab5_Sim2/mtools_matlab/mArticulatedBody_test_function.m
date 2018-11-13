%% mArticulatedBody
clear % need to clear anytime the class has been changed.
clc

%% Puma 560
% Geom parameters
% mdl_puma560 ;
% puma560.E = eye(4) ; puma560.E(3,4) = .1 ;
% 
% puma560.body(1).Fc = 5 ;
% puma560.body(2).Fc = 5 ;
% puma560.body(3).Fc = 2 ;
% puma560.body(4).Fc = 0 ;
% puma560.body(5).Fc = 0 ;
% puma560.body(6).Fc = 0 ;

%% 3R

mdl_R3 ;
R3.Z = rotx(pi/2) ;
R3.gravity = [0 -9.81 0].' ;

n=10 ;
for i=1:n, 
    R3.body(i).Fv = .05 ;
    R3.body(i).k = 2 ;
end


%% 
figure(1) ;  hold on ; clf ;

% qz(1) = pi/2 ;

a  = .15 ; 
ws = [-a a -a a -a a] ;
R3.plot(qz, 'workspace', ws) ; 

 

%%
Y0 = [qz; zeros(size(qz))] ;
Tstep = .005 ; % 10ms ;
Tf = 2 ; % 10s ;
T = 0:Tstep:Tf ;

tic
[T Y] = ode45( @(t,y) DYN(t, y, R3), T, Y0 ) ;
% Y = ode4( @(t,y) DYN(t, y, R3), T, Y0 ) ;
toc
q = Y(:,1:R3.n)' ;

%%
R3.plot(q, 'delay', Tstep/2 , 'loop', true) ;
