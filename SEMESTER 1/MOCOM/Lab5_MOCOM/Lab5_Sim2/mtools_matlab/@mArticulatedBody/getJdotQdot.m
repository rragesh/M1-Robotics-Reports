%getJdotQdot - Product of Jdot*qdot
% Get product necesseray to compute control law in operational space. 
% Base no Appendix 10 of "Modelling, Identification and Control of Robots",
% Khalil, Dombre, 2002.

function Jdqd = getJdotQdot(ab, q, qd)

persistent Z3x1
if isempty(Z3x1), Z3x1 = zeros(3,1) ; end 

% vars for control law : Xdot and Jdot*qdot (appendix 10)
aj_j = [0 0 1].' ;
Vjm1_jm1 = Z3x1 ;
Wjm1_jm1 = Z3x1 ; % robot base is fixed
PSIjm1_jm1 = Z3x1 ;
PHIjm1_jm1 = Z3x1 ;
Ujm1_jm1   = skewsym(PSIjm1_jm1) + skewsym(Wjm1_jm1)*skewsym(Wjm1_jm1) ;

for j=1:ab.n
    [~, Ajm1_j, Pjm1_j] = ab.body(j).T(q(j)) ;

    % eq [A10.{10,11,12}]
    Vj_j = Ajm1_j\( Vjm1_jm1 + cross(Wjm1_jm1,Pjm1_j) ) ;
    Wj_jm1 =  Ajm1_j\Wjm1_jm1 ;
    Wj_j = qd(j).*aj_j + Wj_jm1  ;

    % eq [A10.{15,16,17}]
    PSIj_j = Ajm1_j\PSIjm1_jm1 + cross( Wj_jm1, qd(j).*aj_j ) ;
    Uj_j = skewsym(PSIj_j) + skewsym(Wj_j)*skewsym(Wj_j) ;
    PHIj_j = Ajm1_j\( PHIjm1_jm1 + Ujm1_jm1*Pjm1_j ) ;

    % prepare next iteration
    Vjm1_jm1 = Vj_j ;
    Wjm1_jm1 = Wj_j ;

    PSIjm1_jm1 = PSIj_j ;
    Ujm1_jm1 = Uj_j ;
    PHIjm1_jm1 = PHIj_j ;
end

Jdqd(1:3,1) = PSIj_j ;
Jdqd(4:6,1) = PHIj_j ;

end