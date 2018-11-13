%mBody.inertia TODO: remplir l'aide INERTIA
% chai pas pourquoi j'ai fais ca

function i = inertia(bb)

if numel(bb)==1
  [Ixx, Iyy, Izz, Ixy, Ixz, Iyz] = splitcol(bb.I) ;
  i=[...
    Ixx Ixy Ixz ;
    0   Iyy Iyz ;
    0   0   Izz ] ;
else
  i = cell(1,numel(bb)) ;
  for j=1:numel(bb)
    [Ixx, Iyy, Izz, Ixy, Ixz, Iyz] = splitcol(bb(j).I) ;
    i{j}=[...
      Ixx Ixy Ixz ;
      0   Iyy Iyz ;
      0   0   Izz ] ;
  end
end

end % inertia()