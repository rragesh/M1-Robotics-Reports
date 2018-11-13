%% LWR4 Control Function
clear functions % need to clear anytime the class has been changed.
clc

%%
mdl_lwr4 ;

%%
figure(1) ;  hold on ;  clf ;

q = qz ;

q(4) = pi/2 ;
q(6) = -pi/2 ;

ws = [-.2 .8 -.4 .4 -.2 .6 ] ;

lwr4.plot(q, 'workspace', ws) ;
view([40 22])


for b=lwr4.body
%     b.Fv = .01 ;   
end

%% trajectory : joint traj
% jtraj = [ ...
%     0 0 0 pi/2 0 -pi/2 0  ;
%     0 0 0 0 0 0 0  ;
%     0 0 0 pi/2 0 -pi/2 0  ] ;
% jtraj = jtraj.' ;
% kv =      .25.*[ 1 1 1 1 1 1 1 ].' ; % rad.s-1, Xd_d, Xdd_d] = traj.update(t) ;
% 
% ka =     .5*[ 1 1 1 1 1 1 1 ].' ; % rad.s-2
% traj = mTrajectory(jtraj, kv, ka) ;

%% trajectory : cart traj
[~, A, P0] = lwr4.T(0,lwr4.n,q) ; 
E = R2e(A) ;
P1 = P0  + [.2 0  0].' ;
P2 = P1  + [ 0 .2 0].' ;
P3 = P2  + [-.2 0 0].' ;

% ctraj = [ 
%     P0 P1 P2 P3 P0 ; 
%     E  E  E  E  E  ; 
%     ] ;

ctraj = [ 
    P0 P1 P0 ; 
    E  E  E  ; 
    ] ;


kv = .05.*[ 1 1 1 1 1 1 ].' ;
ka = .5*[ 1 1 1 1 1 1 ].' ;
traj = mTrajectory(ctraj, kv, ka) ;

%%
time_step = .01 ;
time = -time_step ;
time_end = traj.t(end) + 2*traj.T(end) - time_step ;

n_step = length(time:time_step:time_end) ;
n_dof = 6 ;

data_q = zeros(n_dof, n_step) ;
data_qd = zeros(n_dof, n_step) ;
data_qdd = zeros(n_dof, n_step) ;
i=0 ;


while time<=time_end
    
    time = time + time_step ;
    i = i +1 ;
    
    [a, ad, add] = traj.update(time) ;
    data_q(:,i) = a ;
    data_qd(:,i) = ad ;
    data_qdd(:,i) = add ;
    
end
% 
% figure(2) ; clf ;
% 
% subplot(311) ; plot(0:time_step:time, d1e3ata_q(:,1:end-1)') ;
% xaxis([0 time]) ;
% subplot(312) ; plot(0:time_step:time, data_qd(:,1:end-1)') ;
% xaxis([0 time]) ;
% subplot(313) ; plot(0:time_step:time, data_qdd(:,1:end-1)') ;
% xaxis([0 time]) ; 

%%
Y0 = [q; zeros(size(q)) ] ;
Tstep = .001 ; % 10ms ;
% Tf = 5 ;
Tf = traj.t(end) + 2*traj.T(end) ; % 10s ;
T = 0:Tstep:Tf ;

options = odeset('MaxStep', .001) ;
traj.init() ;

tic
[T Y] = ode45( @(t,y) ode_func(t, y, lwr4, traj), T, Y0) ; % , options) ;
% Y = ode3( @(t,y) ode_func(t, y, lwr4, traj), T, Y0 ) ;
toc
q = Y(:,1:lwr4.n)' ;

%%
figure(1) ; % clf ; 
lwr4.plot(q, 'timevect', T) ; % ,'loop', true) ;

%%
% figure(2) ; 
% 
% hold on ;
% plot(T,q) ;
% plot(0:time_step:time, data_q(:,1:end-1)')

%%
figure(2) ; % clf ;

x = zeros(6,numcol(q)) ;
for j=1:numcol(q)
    [~, A, P] = lwr4.T(0,lwr4.n,q(:,j)) ;
    x(1:3,j) = P ;
    x(4:6,j) = R2e(A) ;
end
hold on ; 
plot(T,x(1,:), 'linewidth', 2) ;
plot(0:time_step:time, data_q(1,1:end-1)')
xaxis([0 T(end)]) ;

xlabel('time [s]') ; 
ylabel('^0x_e [m]') ; 
legend('actual', 'desired')
