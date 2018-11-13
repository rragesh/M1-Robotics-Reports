%% mArticulatedBody
clear % need to clear anytime the class has been changed.
clc

%% Puma 560
% Geom parameters
mdl_puma560 ;
puma560.E = eye(4) ; puma560.E(3,4) = .1 ;

puma560.body(1).Fc = 2 ;
puma560.body(2).Fc = 2 ;
puma560.body(3).Fc = 2 ;
puma560.body(4).Fc = .1;
puma560.body(5).Fc = .1;
puma560.body(6).Fc = .1;

puma560.body(1).Fv = .02 ;
puma560.body(2).Fv = .05 ;
puma560.body(3).Fv = .02 ;
puma560.body(4).Fv = .02 ;
puma560.body(5).Fv = .02 ; 
puma560.body(6).Fv = .02 ;

%% 
figure(1) ;  hold on ; clf ;
% puma560.plot(qz) ;

a  = 1 ; 
ws = [-a a -a a -a a] ;
puma560.plot(qz, 'workspace', ws) ;



%%
Y0 = [qz; zeros(size(qz))] ;
Tstep = .005 ; % 10ms ;
Tf = 10 ; % 10s ;
T = 0:Tstep:Tf ;


tic
% [T Y] = ode45( @(t,y) DYN(t, y, R3), T, Y0 ) ;
Y = ode4( @(t,y) DYN(t, y, puma560), T, Y0 ) ;
toc
q = Y(:,1:puma560.n)' ;

%%
puma560.plot(q, 'delay', Tstep,  'loop', true) ;
% puma560.plot(q,  'loop', true) ;
% 