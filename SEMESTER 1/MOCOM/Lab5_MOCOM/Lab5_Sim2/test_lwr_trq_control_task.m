%% 
clc
clear 

%% platform guard

if( ~strcmp(computer, 'PCWIN64') ),
    error('This script is not supposed to run on a non-windows platform. Sorry...') ;
end

%% mtools tb

addpath(genpath('mtools_matlab')) ; 

%% robot model

mdl_lwr4 ; % definition lwr
n_dof = 7 ;

global robot
robot = lwr4 ;
% robot.gravity = zeros(3,1) ;
robot.gravity(3) = -9.80665 ;

%% constants

Znx1 = zeros(n_dof,1) ;

%% trajecotry

Ri = eye(3);
Rf = [1 0 0; 0 0 -1; 0 1 0];
Pi = [0.3 0.1 0.2]';
Pf = [0.5 0.4 0.3]';

D = norm(Pf-Pi);

kv = 1; %max joint vel
ka = 3; %max joint acc

tf = max(1.5*(D/kv),sqrt(6*D/ka)); % tf for cubic interpolation

global Ti;
Ti = [Ri Pi; 0 0 0 1];
global Tf ;
Tf= [Rf Pf; 0 0 0 1];

global qc;
qc = rand(robot.n,1);

%% control law gains

omega = ones(n_dof,1).*7 ;
omega(1) = 7.8 ;
omega(3) = 8 ;
omega(5) = 7.4 ;
omega(7) = 7 ;

ksi = ones(n_dof,1).*1 ;
ksi(3) = 1 ;
ksi(5) = 1 ;

global Kp Kv
Kp = diag(omega.^2) ;
Kv = diag(2.*ksi.*omega) ;


%% adams environnement
%%Initialize your ADAMS Plant 
Controls_Plant_33;
%% simulink environnement

% traj.init() ;

% q_init = rrrrrqz ;
% qd_init = zeros(n_dof,1) ;

stopTime = tf ;

%% simulation
% Your Control scheme from simulink is initialized here
sim('slk_test_lwr_trq_control_Task_space') ;


