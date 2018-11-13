% mArticulatedBody.simulate
function simulate(ab)
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here

fprintf('ab.simulate call ! my name is %s.\n', ab.name) ;

open_system('simulate_simulink.mdl')
sim('simulate_simulink.mdl') ;


end

