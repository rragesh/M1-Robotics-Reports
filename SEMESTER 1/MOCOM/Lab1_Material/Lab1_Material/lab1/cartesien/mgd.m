% Calcul du Modèle géométrique Direct
disp('entrer les valeurs articulaires');
q1 = input('q1 = ');
q2 = input('q2 = ');
q3 = input('q3 = ');
q4 = input('q4 = ');
q5 = input('q5 = ');
q6 = input('q6 = ');
q = [q1;q2;q3;q4;q5;q6];

% Calcul du MGD
% Extraction des coordonnees operationnelles (cosinus-directeur)
T = [ -cos(q6)*sin(q5),  sin(q5)*sin(q6), -cos(q5),q3;
    cos(q4)*sin(q6) - cos(q5)*cos(q6)*sin(q4), cos(q4)*cos(q6) + cos(q5)*sin(q4)*sin(q6),  sin(q4)*sin(q5), -q2;
    sin(q4)*sin(q6) + cos(q4)*cos(q5)*cos(q6), cos(q6)*sin(q4) - cos(q4)*cos(q5)*sin(q6), -cos(q4)*sin(q5),  q1;
        0,   0, 0,1];
sx = T(1,1);
nx = T(1,2);
ax = T(1,3);
Px = T(1,4);
sy = T(2,1);
ny = T(2,2);
ay = T(2,3);
Py = T(2,4);
sz = T(3,1);
nz = T(3,2);
az = T(3,3);
Pz = T(3,4);

% Sauvegarde tampon des cosinus directeurs
s = [sx;sy;sz];
n = [nx;ny;nz];
a = [ax;ay;az];
P = [Px;Py;Pz];
% Application de la transformation dans le repere atelier
% Par rapport au repére atelier, il faut effectuer successivement
%	- une rotation rot(y0,90°)
%	- une rotation rot(z0,180°)
% L origine du repère atelier se trouve au point O0
% Soit une matrice de transformation homogène comme suit
%
%   [  0  0  1  0  ]		k= i
%   [  0 -1  0  0  ]		j=-j
%   [  1  0  0  0  ]		i= k
%   [  0  0  0  1  ]        Pz=Px;Py=-Py;Px=Pz;

% L'Orientation  A finir
tetaz=atan2(sy,sx);
tetay=atan2(-sz,(cos(tetaz).*sx)+(cos(tetaz).*sy));
tetax=atan2(((sin(tetaz).*ax)-(cos(tetaz).*ay)),((-sin(tetaz).*nx)-(cos(tetaz).*ny)));


%config robot
xf = [Px;Py;Pz;tetax;tetay;tetaz]
qsol = [q1;q2;q3;q4;q5;q6]

nbsolution = 1

