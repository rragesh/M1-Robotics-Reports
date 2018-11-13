%mArticulatedBody.simulate_task Simulation Task definitions 
% Middle-function to link user data to simulink model.  
% Task block in the SLK model is linked to a Clock block as input and
% Controller block as output.
% 
% Defaut behavior is there's no special task such as visual servoing or
% monitoring on on a sensor. It returns only the last configuration
% specified in SIMULATE_TRAJECTORY container.
%

function out = simulate_task(in)

fprintf('simulate_task call ! my name is %s', ab.name) ;
fprintf('t=%d', in(1)) ;

return

persistent t
if isempty(t), t=1 ; end ;

q = simulate_trajectory(1:ab.n, t) ; 
qd = simulate_trajectory(ab.n+(1:ab.n), t) ;  

out = [q ; qd] ;

end

