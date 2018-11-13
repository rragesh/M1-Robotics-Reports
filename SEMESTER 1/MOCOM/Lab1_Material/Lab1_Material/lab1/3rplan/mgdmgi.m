% Calcul du Modèle géométrique Directe
disp('entrer les valeurs articulaires');
q1=input('q1 = ');
q2=input('q2 = ');
q3=input('q3 = ');
q=[q1;q2;q3];

Px=0; 
Py=0; 
alpha=0;

%Affichage config robot
xf=[Px;Py;alpha]


q21=0;
q22=0;

q11=0;
q12=0;

%Calcul de Q3
q31=alpha-q21-q11
q32=alpha-q22-q12;

solution1=[q11,q21,q31]
solution2=[q12,q22,q32]

% Deux solutions
qsol=[q11,q12;
      q21,q22;
      q31,q32];

nbsolution=2;




