function dy = DYN(t, y, ab)

persistent Fe %Gamma 
disp(['t=' num2str(t)])  

n     = ab.n ;
q     = y(1:n)  ;
qdot  = y(n+1:end) ;
% Gamma = zeros(n,1) ;
Gamma = -diag([ab.body.k])*q ;
Fe    = zeros(6,n) ;

% if( .2 < t && t <= .21 ), Fe(2,n) = .5 ; end 

% qddot = ab.ddym(Gamma, q, qdot, Fe) ; 
qddot = ab.rneD(q, qdot, Gamma, ab.gravity, Fe) ; 


dy = [qdot; qddot] ;

ab.plot(q) ;

end