%mBODY Rigid Body class definition
%
% A body holds all data and information about geometry/kinematics, dynamics
% properties of the body.
%
% Geometric/kinematic parameters are based on the Khalil and Dombre (2002)
% formalism that use most of the time, the modified DH parameters from
% Craig (1986). Since the notations are not the same, functions able to
% present in a readable form the modified DH parameters will print the two
% systems of notation.
%
% Methods:
%     TODO: remplir l'aide mBody/methods
%
% Properties (Read/Write):
%
%     name      name of the body
%     comment   comments about the body
%
%     parent    joint type: parent id of the current body, default is the world (0).
%     mu        joint type: [1]/0, 0 if the joint is not actuated, 1 if it is.
%     sigma     joint type: [0]/1, 0 if revolute, 1 if prismatic
%
%     alpha     geo/kine: twist from j-1 to j body, around x_j-1        (Craig's alpha)
%     d         geo/kine: distance between x_j-1 and x_j, along z_j-1   (Craig's a)
%     theta     geo/kine: angular joint variable theta, if revolute     (Craig's theta)
%     r         geo/kine: joint variable theta, if prismatic            (Craig's d)
%
%     m         dyn: body mass
%     r         dyn: centre of mass
%     I         dyn: interia matrix
%     M         dyn: first moments (related to mass and cog)
%     Fc        dyn: Coulomb friction components
%     Fv        dyn: viscous friction components
%     Ia        dyn: motor inertia
%
%     vrml      struct of faces and points data for an triangular
%               representation
%     plotopt   additional plot option (cf. mArticulatedBody.plot help).
%
% References:
% - "Modeling and Control of Manipulator", Khalil and Dombre, 2002
% - Khalil's teaching at IRCCyN, Ecole Centrale de Nantes during EMARO/ASP
%   Master (2010/2012).
% - "Robotics, Vision and Control", Peter Cork, Springer 2011
%
% See also mArticulatedBody


classdef mBody < hgsetget
    
    properties % Read/Write
        
        % Readable parameters
        name    % name that you give to the body
        comment % comment about options and/or param
        
        % Geometric/Kinematic parameters
        parent  % parent id of the current body
        mu      % 0 if the joint is not actuated (i.e. passive), 1 if it is.
        sigma   % 0 if revolute, 1 if prismatic
        alpha   % body twist around x_j-1
        d       % body distance along z_j-1
        theta   % body angle along z_j
        r       % body distance alond z_j
        offset  % body offset
        qlim    % joint limit
        
        %TODO: Rob parallele : gamma et b, HT 6 param�tres et refonte du DGM.
        
        % Dynamics properties
        m       % body mass (g)
        cg      % centre of gravity
        I       % inertia matrix ( [Ixx, Iyy, Izz, Ixy, Ixz, Iyz] )
        MS      % first moments ( [MX MY MZ] )
        Fc      % Coulomb friction components
        Fv      % Visquous friction components
        Ia      % Motor inertia
        k       % Stiffness
        
        % Plot options
        vrml    % struct of faces and vertex data for a mesh representation
        plotopt % cell for optional plot options
        
    end % properties (public)
    
    properties (SetAccess=public, Hidden=true)
        
    end % prop (private, hidden)
    
    methods
        
        function b = mBody(parent, mdh, varargin)
            %mBoby.mBody Body class constructor
            % This function constructt a Body object which contains all data
            % about the geometry, kinematic and dynamics parameters.
            %
            % b = mBody() create a body with defaut parameters (all set to
            % zero) attached to the default world frame.
            %
            % b = mBody(parent, [alpha, d, theta, r])
            
            % default parameters
            b.parent = 0 ;
            b.mu    = true ;
            b.sigma = false ;
            b.name  = 'B' ;
            
            b.alpha = 0 ;
            b.d     = 0 ;
            b.theta = 0 ;
            b.r     = 0 ;
            b.offset = 0 ;
            b.qlim  = [-Inf; +Inf] ;
            
            b.m  = 0 ;
            b.I  = zeros(3) ;
            b.cg = zeros(3,1) ;
            b.MS = zeros(3,1) ;
            b.Fv = 0 ;
            b.Fc = 0 ;
            b.Ia = 0 ;
            
            b.vrml = struct('faces', [], 'points', []) ;
            b.plotopt = {'EdgeColor', 'none'} ;
            
            % fn corpus
            switch nargin ... in fn of number of input arg
                case 0, ... b = mBody(), returns default param
                    return
                
                case 1, ... b = mBody( another_body ): make a copy of the input FIXME!
                        if isa(parent, 'mBody'),
                        b = copy(parent) ;
                        end
                        
                otherwise, ... % b = mBody(parent, mdh): regular call,
                        ... but could have some param in the varargin input
                        b.parent = parent ;
                    b.alpha = mdh(1) ;
                    b.d = mdh(2) ;
                    b.theta = mdh(3) ;
                    b.r = mdh(4) ;
                    
                    for i=1:2:length(varargin)
                        pn = varargin{i} ;
                        pv = varargin{i+1} ;
                        if isprop(b,pn),
                            set(b,pn,pv)
                        end
                    end
                    
                    b.offset = not(b.sigma)*b.theta  + b.sigma*b.r ;
                    
            end %switch nargin
        end % mBody()
        
        
        function s = RP(bb)
            %mBody.RP Return the string states of body's sigma property.
            s = '' ;
            for b=bb,
                s = strcat(s,char('R'*not(b.sigma) + 'P'*b.sigma)) ;
            end
        end % RP()
        
        function s = char(bb)
            %mBody.char Return a string that contains parameters of the modified DH
            % parameters of the body.
            s = '' ;
            for b=bb
                if b.sigma,
                    sr = sprintf('q+%.4g',b.offset) ;
                    st = sprintf('%.4g', b.theta) ;
                else
                    st = sprintf('q+%.4g',b.offset) ;
                    sr = sprintf('%.4g', b.r) ;
                end
                
                s = strcat(s,sprintf( '\n %s, alpha=%.4g, d=%.4g, theta=%s, r=%s, %s\n', ...
                    'R'*~b.sigma+'P'*b.sigma, ...
                    b.alpha, ...
                    b.d, ...
                    st, sr, b.name)) ;
            end
            
        end % char()
        
        function display(b)
            %mBody.display Display parameters
            %
            % mBody.display() displays the link parameters in compact single line
            % format.
            %
            % Notes:
            % - This method is invoked implicitly at the command line when the result
            %   of an expression is a Link object and the command has no trailing
            %   semicolon.
            %
            % See also mBody.char
            
            disp([inputname(1), ' = ']) ;
            disp( char(b) );
        end % display()
        
        function p = dyn_parms(bb)
            p = [] ;
            for b=bb
                p = [p b.I (b.cg).' b.m] ;
            end
        end
        
    end % methods
    
end % classdef

% mBody class private functions
