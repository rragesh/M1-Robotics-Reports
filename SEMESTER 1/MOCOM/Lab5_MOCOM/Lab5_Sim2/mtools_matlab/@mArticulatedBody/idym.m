%mArticulatedBody.idym Inverse Dynamic Model
% Compute the torques components of joints knowing the configuration 
% of the articulated chain, gravity and perturbation forces and torques 
% acting on bodies. This uses the recursive Newton Euler algorithm. 
% Note that gravity components are ones that was specified at creation of
% the mAB object.
% 
%   Gamma = A(q)*qddot + H(q, qdot) 
%
% with: 
%     q, qdot, qddot configuration of the ab
%     A   complete inertia matrix of the system
%     H   the coriolis and centrifugal forces acting on system
%
% Gamma[nx1] = obj.idym( q[nx1], qdot[nx1], qddot[nx1], G[3x1], Fe[nx6] )
% is the standard call, will return the nx1 torques vector, with
% n the number of joints. 
% 
% Gamma[nx1] = obj.idym( q[nx1], qdot[nx1], qddot[nx1] ) will return
% the joint torques, assuming there are no gravity and external forces
% acting on the system. 
%
% Gamma[nx1] = obj.idym( q[nx1], qdot[nx1], qddot[nx1], G[3x1])
% will return the joint torques, assuming there is no external forces
% acting on the system.
%
% Gamma[nx1] = obj.idym( ..., Fe[nx1]) will return the joint torques,
% considering only an external forces acting on the end effector, with
% Fe = [0 ... 0 Fen] where Fen is the input proposed by user.
%
% See also mArticulatedBody.idym mArticulatedBody.rne

function Gamma = idym(ab, q, qdot, qddot, G, Fe)

% The job is almost done in mArticulatedBody.rne
Gamma = ab.rne(q, qdot, qddot, G, Fe) ;

end