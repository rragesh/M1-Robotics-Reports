
%MENU	TP de Robotique Genie Electrique
%	Copyright (C) D. Khadraoui , P. Martinet
%	Novembre 1996%	ROBOT 3RPLAN

% Initialisation des donnees specifiques au robot
close all
clc

r3plan
while 1,	

which = menu('Geometric model of 3RPLAN',...
	'Direct Geometric model', ...
	'Inverse Geometric Model', ...
	'Validation : MGD puis MGI', ...
	'Visualisation', ...		
	'Exit');	

if which == 1,		
	mgd
elseif which == 2,		
	mgi
elseif which == 3,		
	mgdmgi
elseif which == 4,
	visuart
	pause
elseif which == 5,
	break;	
end
end
