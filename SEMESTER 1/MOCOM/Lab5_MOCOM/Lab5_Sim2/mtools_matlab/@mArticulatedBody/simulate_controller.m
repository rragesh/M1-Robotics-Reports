%mArticulatedBody.simulate_controller Simulation Controller definitions 
% Middle-function to link user data to simulink model.  


function out = simulate_controller(ab, in )

fprintf('simulate_controller call ! my name is %s', ab.name) ;

out = zeros(3*ab.n,1) ; 

return

% Map for input
persistent rq_d rqd_d rq_r rqd_r
if isempty([rq_d, rqd_d, rq_r, rqd_r])
  rq_d  = 0*ab.n + (1:ab.n) ;
  rqd_d = 1*ab.n + (1:ab.n) ;
  rq_r  = 2*ab.n + (1:ab.n) ;
  rqd_r = 3*ab.n + (1:ab.n) ;
end

%% 

% --(!)
% Cette partie sera destinée à être intégrée pour accepter les fonctions
% utilisateurs. 

% Control Law
persistent Kd Ki Kp ei
if isempty([Kd Ki Kp])
  omega = 5.*ones(ab.n,1); 
  a     = .01*ones(ab.n,1); 
  
	Kp = 3.*a.*omega.^2 ; 
	Kd = 3.*a.*omega ; 
	Ki = a.*omega.^3 ; 
  
  ei = 0 ;
end

q_desired  = in( rq_d  ) ; 
qd_desired = in( rqd_d ) ;  
q_real     = in( rq_r  ) ; 
qd_real    = in( rqd_r ) ;  

e  = q_desired - q_real ; 
ed = qd_desired - qd_real ;

ei = Ki.*e.*tStep + ei ; 
Gamma = Kp.*e + ei + Kd.*ed ;

%%

% Map for outputs
out = [Gamma ; q_real ; qd_real ] ;

end

