
syms au av
u = sym('u(t)') ; 
v = sym('v(t)') ; 
Z = sym('Z(t)') ; 


L = [   -au/Z    0       u/Z     u*v/av     -(au+u^2/au)    v*au/av ;
            0       -av/Z    v/Z     av+v^2/av   -u*v/au       -u*av/au ];    

diff(L,'t')

Ld = [ (au*Zd)/Z^2, 0,             ud/Z  - (u *Zd)/Z^2, (u *vd)/av + (v *ud)/av,   -(2*u *ud)/au,             (au*vd)/av ;
 0,           (av*Zd)/Z^2,   vd/Z  - (v *Zd)/Z^2, (2*v *vd)/av,              - (u *vd)/au - (v *ud)/au, -(av*ud)/au] ;