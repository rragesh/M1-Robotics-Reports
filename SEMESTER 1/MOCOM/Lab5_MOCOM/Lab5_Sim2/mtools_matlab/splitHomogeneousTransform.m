function [R, p] = splitHomogeneousTransform(T)

persistent r 
if(isempty(r)), r = 1:3 ; end 
R = T(r,r) ; 
p = T(r,end) ;

end