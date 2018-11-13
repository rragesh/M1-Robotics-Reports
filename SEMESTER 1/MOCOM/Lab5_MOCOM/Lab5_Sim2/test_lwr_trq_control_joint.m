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

qz = zeros(7,1) ; 

a = [10 20 30 40 50 60 70]' ; a = deg2rad(a) ;
q_traj = [  qz a -a qz ] ; % waypoints
        
global traj
kv = 1*ones(7,1) ;  % max vel
ka = 3.*kv ;        % max acc
traj = mTrajectory(q_traj, kv, ka) ; % objet traj <=> quintic interp with waypoints 
tEnd = traj.getEndTime() ;

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
%%Initialize your ADAMS Plant Add the name of your exported adams plant
Controls_Plant_33;  

%% simulink environnement

traj.init() ;

q_init = qz ;
qd_init = zeros(n_dof,1) ;

stopTime = tEnd+.5 ;

%% simulation
% Your Control scheme from simulink is initialized here

%Example:
sim('slk_test_lwr_trq_control_joint_space') ; 

