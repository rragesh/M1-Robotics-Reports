%mArticulatedBody.rotz Rotation around z-axis
% Return a 3x3 matrix image of the rotation around z-axis with an angle A 
function r = rotz(a) 

r = [...
  C(a) -S(a) 0 ; 
  S(a) C(a)  0 ; 
  0    0     1 ] ;

end

function c = C(a)
 c = cos(a)*( a~=pi/2&&a~=-pi/2 ) ;
end

function s = S(a)
 s = sin(a)*( a~=pi&&a~=-pi) ;
end