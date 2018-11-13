function OUT = slk_idym(IN)

% maps inputs
q   = IN(1:7) ;
qd  = IN((1:7)+7) ;
qdd_star = IN((1:7)+7*2) ;

% static vars
persistent Z6xn Znx1 %#ok
if(isempty(Z6xn)), 
    Z6xn = zeros(6,7) ; 
    Znx1 = zeros(7,1) ; 
end

% global vars
global robot 

% idym
tau = robot.rne(q, qd, qdd_star, robot.gravity, Z6xn) ;
% tau = robot.rne(q, qd, qdd_star, robot.gravity, Z6xn) ;

% maps outputs
OUT = tau ;

end
