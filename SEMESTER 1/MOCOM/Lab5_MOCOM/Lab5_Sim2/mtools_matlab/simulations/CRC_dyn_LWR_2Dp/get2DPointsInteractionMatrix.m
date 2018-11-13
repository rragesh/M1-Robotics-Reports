function [LL, LLd] = get2DPointsInteractionMatrix(cam, PP, PPd, ss, ssd)

n_points = size(ss,2) ;
LL = zeros(n_points*2,6) ;

[au, av] = splitcol(1./cam.rho) ;

% if( ~isempty(symvar(ss)) ), LL = sym(LL) ; end

for i=1:n_points,
%     [u, v] = splitrow(ss(:,i)) ;
%     [ud, vd] = splitrow(ssd(:,i)) ;
%     Z = PP(3,i) ;
%     Zd = PPd(3,i) ;            
    
    %     L = [   -au/Z    0       u/Z     u*v/av     -(au+u^2/au)    v*au/av ;
    %             0       -av/Z    v/Z     av+v^2/av   -u*v/au       -u*av/au ];
    %
    %     Ld = [ (au*Zd)/Z^2, 0,             ud/Z  - (u *Zd)/Z^2, (u *vd)/av + (v *ud)/av,   -(2*u *ud)/au,             (au*vd)/av ;
    %  0,           (av*Zd)/Z^2,   vd/Z  - (v *Zd)/Z^2, (2*v *vd)/av,              - (u *vd)/au - (v *ud)/au, -(av*ud)/au] ;
    
    
    [x, y, Z, ~] = splitrow(PP(:,i)) ;
    [xd, yd, Zd, ~] = splitrow(PP(:,i)) ;
    
    L = [ -1/Z 0    x/Z     x*y     -(1+x*x) y ;
        0 -1/Z y/Z  1+y*y   -x*y    -x ] ;
    
    Ld = [ Zd/Z, 0,      xd/Z - (x*Zd)/Z , x*yd + y*xd,  -2*x*xd,        yd ; 
          0,    Zd/Z ,  yd/Z - (y*Zd)/Z , 2*y*yd,       -x*yd-y*xd,     -xd] ;        
    
    LL([2*i-1, 2*i],:) = L ;
    LLd([2*i-1, 2*i],:) = Ld ;
end

end