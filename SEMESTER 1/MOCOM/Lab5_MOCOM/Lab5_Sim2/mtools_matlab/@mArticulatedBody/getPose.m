function [x, xd] = getPose(ab, q)

persistent x_prev p o
if(isempty(p)), 
    p = 1:3 ;
    o = 4:6 ;
end

[~, R, t] = ab.T(0,ab.n,q) ;

if(isempty(x_prev)), 
    x_prev(p) = t ;
    x_prev(o) = R2e(R) ;    
end

x(p) = t ; 
x(o) = R2e(R) ; 

xd = x-x_prev ;

x = x(:) ;
xd = xd(:) ;

end