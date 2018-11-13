function [L, Ld] = get3DPointInteractionMatrix(P, Pd, idx)

n = size(P,2) ;
if nargin<=2
    idx = 1:n ;
end

r = [1 2 3] ;
L = [] ;
Ld = [] ;

for i=idx 
    
    l = [-eye(3) skew(P(r,i))] ;
    ld = [ zeros(3) skew(Pd(r,i))] ; 
    
    L  = [ L ; l ] ; 
    Ld = [ Ld ; ld ] ;
    
end

end