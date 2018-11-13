function TT = invVelocityTwistMatrix(T)

persistent Z3
if isempty(Z3), Z3 = zeros(3) ; end

[R, t] = tr2rt(T) ; 
TT = [
        R   -R*skew(t)
        Z3  R           ] ; 

end