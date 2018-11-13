%% mArticulatedBody
clear % need to clear anytime the class has been changed.
clc

%% Puma 560
% Geom parameters
clear b
% b(1) = mBody(0,[  0     0       0   0     ], 'm', 0,    'cg', [0     0     0    ]', 'I', [ .0      .0      .35    0 0 0],'k', 100) ;
% b(2) = mBody(1,[ -pi/2  0       0   .2435 ], 'm', 17.4, 'cg', [.068  .006 -.016 ]', 'I', [ .13     .524    .539   0 0 0],'k', 100);
% b(3) = mBody(2,[  0     .4318   0  -.0934 ], 'm', 4.8,  'cg', [0    -.07   .014 ]', 'I', [ .066    .0125   .066   0 0 0],'k', 100);
% b(4) = mBody(3,[  pi/2  -.0203  0   .4331 ], 'm', .82,  'cg', [0     0    -.019 ]', 'I', [1.8e-3  1.8e-3  1.3e-3  0 0 0],'k', 100) ;
% b(5) = mBody(4,[ -pi/2  0       0   0     ], 'm', .34,  'cg', [0     0     0    ]', 'I', [ .3e-3   .3e-3   .4e-3  0 0 0],'k', 100) ;
% b(6) = mBody(5,[  pi/2  0       0   0     ], 'm', .09,  'cg', [0     0     .032 ]', 'I', [ .15e-3  .15e-3  .04e-3 0 0 0],'k', 100) ;

d = .3 ; 
m = .250 ;
r = .01 ;
h = .1 ; 
k=5 ;
Fc = 2 ;
Fv = .5 ;
b(1) = mBody(0, [ 0 0 0 0 ], 'm', m, 'cg', [d/2 0 0]', 'I', [m*(r*r/4 + h*h/12) m*(r*r/4 + h*h/12)  m*r*r/2 0 0 0], 'k', k, 'Fc', Fc, 'Fv', Fv) ;
b(2) = mBody(1, [ 0 d 0 0 ], 'm', m, 'cg', [d/2 0 0]', 'I', [m*(r*r/4 + h*h/12) m*(r*r/4 + h*h/12)  m*r*r/2 0 0 0], 'k', k, 'Fc', Fc, 'Fv', Fv) ;
b(3) = mBody(2, [ 0 d 0 0 ], 'm', m, 'cg', [d/2 0 0]', 'I', [m*(r*r/4 + h*h/12) m*(r*r/4 + h*h/12)  m*r*r/2 0 0 0], 'k', k, 'Fc', Fc, 'Fv', Fv) ;
b(4) = mBody(3, [ 0 d 0 0 ], 'm', m, 'cg', [d/2 0 0]', 'I', [m*(r*r/4 + h*h/12) m*(r*r/4 + h*h/12)  m*r*r/2 0 0 0], 'k', k, 'Fc', Fc, 'Fv', Fv) ;
b(5) = mBody(4, [ 0 d 0 0 ], 'm', m, 'cg', [d/2 0 0]', 'I', [m*(r*r/4 + h*h/12) m*(r*r/4 + h*h/12)  m*r*r/2 0 0 0], 'k', k, 'Fc', Fc, 'Fv', Fv) ;

test = mArticulatedBody(b, 'name', 'test');
test.E = eye(4) ; test.E(1,4) = d ;
test.Z = rotx(pi/2) ;
test.gravity = [0 -9.81 0].' ;
% test.Z(1:3,1:3) = rotx(pi/2) ; 
 
%% Useful pos
% qs = [0; -pi/2; pi/2; 0; 0; 0] ;
qz = zeros(test.n,1) ;

a = 2 ; 
ws =  [-a a -a a -a a ] ; 

test.plot(qz, 'workspace', ws) ; 

% return 

%%
Y0 = [qz; zeros(size(qz))] ;
Tstep = .005 ; % 10ms ;
Tf = 2 ; % s ;
T = 0:Tstep:Tf ;

tic
% Y = o(de4( @(t,y) DYN(t, y, test), T, Y0 ) ;
[T Y] = ode45( @(t,y) DYN(t, y, test), T, Y0 ) ;
toc
q = Y(:,1:test.n)' ;

test.plot(q) ;