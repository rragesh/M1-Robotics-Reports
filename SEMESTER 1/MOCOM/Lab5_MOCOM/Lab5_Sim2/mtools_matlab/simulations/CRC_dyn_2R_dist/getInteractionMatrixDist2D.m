function [L, Ld] = getInteractionMatrixDist2D(P,Pd)

x = P(1) ; 
y = P(2) ;

xd = Pd(1) ; 
yd = Pd(2) ;

sqrtxy12 = sqrt(x^2+y^2)^(1/2) ;
sqrtxy32 = sqrt(x^2+y^2)^(3/2) ;

L = [ x/sqrtxy12  y/sqrtxy12] ;

Ld = [ -2*y*(x*yd-y*xd)/sqrtxy32 -2*x*(x*yd-y*xd)/sqrtxy32 ] ;

end