function TT = velocityTwistMatrix(T)

persistent Z3
if isempty(Z3), Z3 = zeros(3) ; end

[R, t] = splitHomogeneousTransform(T) ; 
TT = [
        R   skew(t)*R
        Z3  R           ] ; 

end