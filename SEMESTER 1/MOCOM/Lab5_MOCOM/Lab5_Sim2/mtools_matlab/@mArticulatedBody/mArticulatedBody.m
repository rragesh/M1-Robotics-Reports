%mArticulatedBody Articulated Rigid Body class definition
%
% This class will implements all rigid body kinematics and dynamics methods
% to simulate and display robots and all kind of rigid body systems.
%
% Methods:
%   mArticulatedBody class constructor
%   char      display parameters of the chain in a readable form
%   plot      display the chain in Matlab graphics
%
%   T         homogeneous transform from joint to joint
%   J         jacobian of the chain
%   igm       numerical inverse geometric model, based on jacobian
%   rne       recursive newton euler algorithm
%   ddym      direct dynamic model, based on recursive NE
%   idym      inverse dynamic model, based on recursive NE
%
%   jtraj     TODO: trajectory in joint space
%   ctraj     TODO: trajectory in cartesian coordinates/workspace
%
% Properties (Read/Write):
%
%   name      name of the robot
%   comment   comments about robot opt. and/or parameters
%   body      mBody objects list that models the chain
%
%   Z         base transform, from the world to the 1st body
%   E         tool transform, from the end effector to the tool
%   TCP       Tool Center Point, from the end effector to the interest
%             point of the robot
%
% Properties (Read only):
%
%   n         number of body/joints in the chain.
%
% TODO: impl�menter rob parallele (get_path, dgm/T, rne)
% TODO: impl�menter une classe pour les HT et les rotations
%
% References:
% - "Modeling and Control of Manipulator", Khalil and Dombre, 2002
% - Khalil's teaching at IRCCyN, Ecole Centrale de Nantes during EMARO/ASP
%   Master (2010/2012).
% - "Robotics, Vision and Control", Peter Cork, Springer 2011
%
% See also mBody mArticulatedBody.mArticulatedBody

%
% Feuille de route :
%
% dgm/T               ok, voir rob para
% graphiques n1       ok, voir vrml
% dkm/J               ok,
% rne idym ddym       ok, voir rob para
% g�n�ration q/ctraj 	non, mais compatible avec RVCtool
% graphiques n2       ok, supporte le vrml, maj prop mB et mAB, ok
% graphique n2 : q, qdot, qddot en fonction du temps avec une barre pr l'�volution
% q chart             .
% fixed tstep & slk   .
%

classdef mArticulatedBody < hgsetget
  properties (SetAccess=public)
    
    % Generals
    name    % name of the robot
    comment % comments about the robot/articulated chain
    
    % Structural
    first_body
    body    % list of body(ies)
    
    E       % Tool transform (i.e. from the last body to the tool)
    TCP     % Tool Center Point (i.e from ee to TCP frame)
    Z       % Base transform (i.e. from world frame to first body)
    
    gravity % gravity vector [gx gy gz]
    
    % Plot and display options
    plotopt
    
  end % properties (public)
  
  properties (SetAccess=private)
    
    n       % number of body(ies)
    
  end % prop (private, visible)
  
  methods
    
    function ab = mArticulatedBody(bodies, varargin)
      %mArticulatedBody.mArticulatedBody Articulated Body Class Constructor
      % Return an mArticulatedBody object.
      %
      % ab = mArticulatedBody(bodies)
      %     where bodies is a list of mBody objects.
      %
      % Constructor supports setter functions for the object. Thus user can
      % specify property in constrcutor call, as follows :
      %
      % ab = mArticulatedBody(bodies, 'E', eye(4))
      %     specify the E matrix from the last body to the tool (if there
      %     is) as an identity matrix.
      %
      % See also mBody
      
      switch nargin
        case 1
          % FIXME: mAB copy does not work, see how to copy matlab class instance.
          if isa(bodies, 'mArticulatedBody')
            ab = copy(bodies) ;
          end
          
        otherwise
          ab.n    = length(bodies) ;          
          ab.body = bodies ;          
          ab.Z    = eye(4) ;
          ab.E    = eye(4) ;
          ab.TCP  = eye(4) ; 
          ab.gravity = [0; 0; -9.81] ;
          ab.plotopt = {} ;
          
          
          for i=1:2:length(varargin)
            pn = varargin{i} ;
            pv = varargin{i+1} ;
            switch pn
              case {'vrml', 'VRML'}
                if isa(pv, 'struct') && numel(pv)==ab.n
                  for j=1:ab.n
                    ab.Body(j).vrml = pv(j) ;
                  end
                else
                  error('VRML data structure is incorrect') ;
                end
                
              otherwise
                if isprop(ab,pn),
                  set(ab,pn,pv)
                end
            end
          end
      end
      
    end % mArticulatedBody constructor
    
    function s = char(ab)
      %mArticulatedBody.char Display articulated body chain characteristics
      % Return a string that contains all characteristics of the robots/
      % articulated chain, based on the modified DH formalism of Khalil
      % and Dombre (2002).
      %
      % TODO: ajouter E et Z + gravit� dans l'affichage Command Window
      %
      % See also mArticulatedBody.display mBody.char
      
      s = sprintf(...
        ['%s (%d axis, %s)\n' ...
        '+---+---+---+-----------+-----------+-----------+-----------+\n' ...
        '| j |ant| mu|     alpha |         d |     theta |         r |\n' ...
        '+---+---+---+-----------+-----------+-----------+-----------+'], ...
        ab.name, ab.n, ab.body.RP() ) ;
      
      for i=1:ab.n,
        if ab.body(i).sigma,
          r   = sprintf('q%d+%4.4g', i, ab.body(i).offset) ;
          th  = sprintf('%.4g', ab.body(i).theta) ;
        else
          r   = sprintf('%.4g', ab.body(i).r) ;
          th  = sprintf('q%d+%.4g', i, ab.body(i).offset) ;
        end
        
        s = strcat(s,...
          sprintf(...
          '\n|%2d |%2d |%2d | %9.4g | %9.4g | %9s | %9s |', ...
          i, ab.body(i).parent, ab.body(i).mu, ab.body(i).alpha, ab.body(i).d, ...
          th, r) ) ;
      end
      
      s = strcat(s,sprintf(...
        '\n+---+---+---+-----------+-----------+-----------+-----------+')) ;            
      
    end % char()
    
    function display(ab)
      %mArticulatedBody.display Display parameters
      %
      % mArticulatedBody.display() displays the body parameters.
      %
      % Notes:
      % - This method is invoked implicitly at the command line when the result
      %   of an expression is a Link object and the command has no trailing
      %   semicolon.
      %
      % See also mArticulatedBody.char
      
      disp([inputname(1), ' = ']) ;
      disp(' ') ;
      disp( char(ab) );
    end % display()
    
  end % methods
  
end % classdef
