%mArticulatedBody.roty Rotation around y-axis
% Return a 3x3 matrix image of the rotation around y-axis with an angle A 
function r = roty(a) 

r = [...
  C(a) 0  S(a) ; 
  0    1  0 ; 
 -S(a) 0  C(a) ] ;

end

function c = C(a)
 c = cos(a)*( a~=pi/2&&a~=-pi/2 ) ;
end

function s = S(a)
 s = sin(a)*( a~=pi&&a~=-pi) ;
end