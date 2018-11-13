%% 3R - Robot definition

clear B 
d = .01 ;
n=10 ;
B(1) = mBody(0,[ 0 0 0 0 ], 'm', .001, 'cg', [ d/2 0 0 ]', 'I', [ 1e-3 1e-3 1e-3 0 0 0 ]) ;
for i=2:n
    B(i) = mBody(i-1,[ 0 d 0 0 ], 'm', .001, 'cg', [ d/2 0 0 ]', 'I', [ 1e-3 1e-3 1e-3 0 0 0 ]) ;
end


clear R3
R3 = mArticulatedBody(B, 'name', '3R') ; 

R3.E(1,4) = d ;

qz = zeros(n,1) ;