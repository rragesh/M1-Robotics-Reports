%mArticulatedBody.rotx Rotation around x-axis
% Return a 3x3 matrix image of the rotation around x-axis with an angle A 
function r = rotx(a) 

r = [...
  1    0     0     0
  0    C(a) -S(a)  0 ; 
  0    S(a) C(a)   0 ; 
  0     0     0    1 ] ;


end

function c = C(a)
 c = cos(a)*( a~=pi/2&&a~=-pi/2 ) ;
end

function s = S(a)
 s = sin(a)*( a~=pi&&a~=-pi) ;
end