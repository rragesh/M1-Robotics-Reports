%mArticulatedBody.plot Plot the robot in Matlab Graphics
% Plot the robot under options knowing its current configuration Q
% Default behavior will create matlab graphics object with respect to the
% graphics current axis (gca) and store into the graphic handle.
% Next call of this function will update the graphics.
%
% obj.plot( q[nx1] ) will plot the configuration q of the robot in world
% space.
%
% obj.plot( q[nxM] ) will plot an animation of the robot.
%
% obj.plot(..., OPTIONS ) accepts additionnal options as defined below.
%
% List of available option and default values:
%
%   loop      [F]/T   plays animation for ever. To stop with Crtl+C.
%   delay     [.05]   delay between frame
%   timevect  []      time vector to be specified, for real time render
%
%   maguser   [1.0]   modify the size of object displayed automatically
%   workspace []      define the workspace of figure, will be detected
%                     automatically if empty
%   name      name    display the name of the robot. Set to '' to clear.
%T
%   base      [T]/F   display the base frame
%   baselabel 'xyz'   default string letters to display near axis
%   baseopt           additionnal options for lines of the frame
%
%   tool      [T]/F   display the tool frame
%   toollabel 'xyz'   default string letters to display near axis
%   toolopt           additionnal options for lines of the frame
%
%   tcp       [F]/T   display the tcp frame
%   tcplabel  'xyz'   default string letters to display near axis
%   tcpopt            additionnal options for lines of the frame
%
%   Vectors for bodies :
%   frame     [T]/F   boolean VECTOR to display the frame for each body
%   jaxis     [T]/F   boolean VECTOR to display a special line over z-axis of the body
%   model     [T]/F   boolean VECTOR to display model of the body
%   modelvrml [F]/T   boolean VECTOR to display mesh instead of model
%   vrml      empty   vrml data structure, faces and vertex
%
% Notes on VRML data: (1) you need to set 'model' and 'modelvrml' to true
% is you want to display to mesh data. Keeping 'model' to true and setting
% 'modelvrml' to false will display a simple model (cylinder or rectangle
% in function of joints type).
% (2) a VRML data empty structure is defined as
% vrml(i) = struct('faces', [], 'points', []) ;
% (3) specifing VRML through varargin plot options is supposed to be
% a vector of empty structure with 'faces' and 'points' fields.
%
% See also mArticulatedBody.animate SerialLink.plot

% Last Changes :
% 20130410 Sylvain V. : Changement du type de conteneur pour les mod�les
% dans la structure h. Avant liste, h.model est devenu une cell. Ce qui
% permet de switcher entre cylindre ou le mesh.


function rc = plot(ab, q, varargin)

% local vars
nq = numcol(q) ;
n  = ab.n ;

% error raiser
if numrow(q)~=n,
    error('Insufficient values in q for each configuration') ;
end

% users option process
if nargin > 2 && isstruct( varargin{1} )
    % means the user passed one additional input argument and this argument
    % is already a struct containing all options data.
    options = varargin{1} ;
else
    % otherwise, users specfied option as regular calls such as f(...,
    % 'opt1', val1, ...) and all additionnal input args needs to be stored in
    % a struct.
    options = plot_options(ab, varargin) ;
end

% part I. ab graphic handle/window creation
% check if ab graphics already exist in gcf (graphic current frame)
handles = findobj('Tag', ab.name) ;

if isempty(handles)
    % If theres no handle with a tag corresponding to ab.name OR window has
    % been freshly created and theres no graphic handle at all in the fig,
    % then create stuff...
    
    if isempty( get(gcf, 'Children')), newplot() ; end % matlab builtin function
    handle = create_new_graphical_ab(ab, options) ;
    
    % Store all graphical data in one of the graphic object that we just
    % created and tag it with the robot name. By this way, all graphical data
    % are already store in the gcf structure and not in the workspace memory
    % of matlab. This method of recover is much faster than using matlab
    % workspace memory.
    % The field used to transport ab's graphical data is 'UserData'. Ones
    % needs to select an object that does not use already the 'UserData'
    % field. Next we will work only starting from this particular handle.
    
    set(handle.dummy,'Tag', ab.name) ;
    set(handle.dummy,'UserData', handle) ;
    handles = handle.dummy ;
    
end

if ishold(gcf) && isempty( findobj(gca, 'Tag', ab.name) )
    % if hold set is true and there's no graphic handle with a tag
    % corresponding to the ab chain, it means the figure contains already a
    % robot but the one that we were interrested in. Need to create the
    % handles and make it available as said sooner.
    
    handle = create_new_graphical_ab(ab, options) ;
    set(handle.dummy,'Tag', ab.name) ;
    set(handle.dummy,'UserData', handle) ;
    handles = handle.dummy ;
    
end

% part II. Ok, now the graphical ab should exist. It's time to update the
% graphics as we want.
while true
    
    if( isempty(options.timevect) )
        
        % perform all configuration
        for i=1:nq
          
            ab.animate( q(:,i), handles ) ;          
            
            if options.delay > 0, pause(options.delay) ; end
            % allow users to perform an additionnal lost of time in the graphical
            % updates.
        end
        
    else
        
        % plot configuration wrt the time vector
        
        awt = 0 ; % animation wall time       
        while awt < options.timevect(end)
            
            idx = find( awt < options.timevect, 1 ) ;
            
            ticPlot = tic ; 
            ab.animate( q(:,idx), handles ) ;
            drawnow()  ;
            awt = awt + toc(ticPlot) ; 
            
        end
        
        
    end
    
    if ~options.loop,
        % when the loop opt is true, means that the animation will loop
        % again and again.
        break ;
    end
end

rc = 0 ;

end % plot()

function o = plot_options(ab, optin)
% get options specified by users in varargin cell array and turn them into
% a struct.

% default options: animation control
o.loop = false ;
o.delay = .05 ;
o.timevect = [] ;

% default options: workspace and display control
o.maguser = 1 ;
o.mag = 1 ;
o.perspective = 1 ;

% if isempty( get(gcf, 'CurrentAxes') ) || length(axis)~=6,
%   o.workspace = [] ;
% else
%   o.workspace = axis ;
% end
o.workspace = [] ;

% default options: ab elem to display
% for ab
o.tool = true ;       % tool frame
o.toollabel = 'xyz' ;
o.toolopt = {'Linewidth', 4} ;
o.base  = true ;      % base frame
o.baselabel = 'xyz' ;
o.baseopt = {'Linewidth', 4} ;
o.name  = true ;
o.tcp = false ;       % tcp frame
o.tcplabel = 'xyz' ;
o.tcpopt = {'Linewidth', 4} ;

% for bodies
o.frame = true(1,ab.n) ;  % frame is the frame placed at origin of bodies
o.jaxis = true(1,ab.n) ;  % jaxis is the z-axis of the joint
o.model = true(1,ab.n) ;  % model to display for each link
o.modelvrml = false(1,ab.n) ; % vrml to display instead of simple model
o.vrml(ab.n) = struct('faces', [], 'points', []); % vrml data
o.modelcolor =  [0 0 .7] ; % dark blue

% parse plot options in mBody
for i=1:numel(ab.body)
    % check and update if there is already vrml data specified in mBody
    % declaration
    if ~isempty(ab.body(i).vrml.faces),
        o.vrml(i)      = ab.body(i).vrml ;
        o.modelvrml(i) = true ;
    end
    
    if ~isempty(ab.body(i).plotopt)
        for j = 1:2:length(ab.body(i).plotopt)
            switch ab.body(i).plotopt{j}
                case 'modelvrml'
                    o.modelvrml(i) = ab.body(i).plotopt{j+1} ;
                case 'jaxis'
                    o.jaxis(i) = ab.body(i).plotopt{j+1} ;
                case 'frame'
                    o.frame(i) = ab.body(i).plotopt{j+1} ;
                otherwise
                    % do nothing
            end
        end
    end
end

% queuing the plot options already specified in ab declaration
% the ab option has to be in cell syntax such as {'nameoption', valueoption}
optin = [optin ab.plotopt] ;

% parse the options (nice stuff need to think about it for later!)
% TODO: make func to parse options in varargin
if ~isempty(optin)
    optleft = true(1,numel(optin)) ;
    while true
        toproc = find(optleft,1) ;
        if isempty(toproc), break ; end
        if isfield(o, optin{toproc})
            o = setfield(o, optin{toproc}, optin{toproc+1}) ; %#ok
            optleft(toproc:toproc+1) = false ;
        else
            error('Unknown option ''%s.''', optin{toproc}) ;
        end
    end
end



% heuristic from P. Cork to get the size of the workspace.
% TODO : take into account the size of the mesh volume
if isempty(o.workspace)
    B = ab.body ;
    r = 0 ;
    for b=B, r = r + abs(b.d) + abs(b.r) ; end
    if r==0, r = 1 ; end % if it is not about plotting a robot
    o.workspace = [-r r -r r -r r] ;
    o.mag = r/10  ;
else
    [xm, xM, ym, yM, zm, zM] = splitcol(o.workspace) ;
    dx = xM - xm ;
    dy = yM - ym ;
    dz = zM - zm ;
    r = min(abs([dx dy dz])) ;
end
o.mag = o.maguser * r/10 ;

end % plot_options()

%mArticulatedBody.plot.create_new_graphical_ab
%
%  h = create_new_graphical_ab(ab, opt)
%
% Create graphic handle of the current ab.
% Return a struct of handle such as the following:
%
% h.name        name of the ab
% h.base.x      x-axis of the base frame
%       .y      y-axis of the base frame
%       .z      z-axis of the base frame
% h.base.xt     x-axis text of the base frame
%       .yt     y-axis text of the base frame
%       .zt     z-axis text of the base frame
% h.baselabel   label for the base
%
% h.tool.x      x-axis of the tool frame
%       .y      y-axis of the tool frame
%       .z      z-axis of the tool frame
% h.tool.xt     x-axis text of the tool frame
%       .yt     y-axis text of the tool frame
%       .zt     z-axis text of the tool frame
% h.toollabel   label for the tool frame
%
% h.tcp.x      x-axis of the tcp frame
%       .y      y-axis of the tcp frame
%       .z      z-axis of the tcp frame
% h.tcp.xt     x-axis text of the tcp frame
%       .yt     y-axis text of the tcp frame
%       .zt     z-axis text of the tcp frame
% h.tcplabel   label for the tcp frame
%
% h.jaxis(i)    line for z-axis of ith frame
% h.jlabel(i)    line for z-axis of ith frame
% h.frame(i).x  x-axis of the ith frame
%           .y  y-axis of the ith frame
%           .z  z-axis of the ith frame
% h.model(i)    surface model of the ith body

function h = create_new_graphical_ab(ab, opt)

% make it available later
h.opt = opt ;
h.ab  = ab ;
h.dummy = line('Visible', 'off') ;

% prepare the figure
h.mag = opt.mag ;

% if hold is off, overwrite the current workspace
axis equal ;
axis(opt.workspace) ;
xlabel('X(m)') ;
ylabel('Y(m)') ;
zlabel('Z(m)') ;
grid on ;

% creates graphics object
if opt.name, % text the name of the ab
    [x, y, z] = splitrow(ab.Z(1:3,4)) ;
    text(x, y-opt.mag, z, [' ' ab.name], ...
        'FontAngle', 'italic', 'FontWeight', 'bold') ;
end % if opt.name

if opt.base % plot the base frame of robot
    h.base.x = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'r', 'Linewidth', 2) ;
    h.base.y = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'g', 'Linewidth', 2) ;
    h.base.z = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'b', 'Linewidth', 2) ;
    h.base.xt = text(0,0, opt.baselabel(1), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.base.yt = text(0,0, opt.baselabel(2), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.base.zt = text(0,0, opt.baselabel(3), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
end % if opt.base

if opt.tool % plot the tool frame of robot
    h.tool.x = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'r', 'Linewidth', 2) ;
    h.tool.y = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'g', 'Linewidth', 2) ;
    h.tool.z = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'b', 'Linewidth', 2) ;
    h.tool.xt = text(0,0, opt.toollabel(1), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.tool.yt = text(0,0, opt.toollabel(2), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.tool.zt = text(0,0, opt.toollabel(3), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
end % if opt.tool

if opt.tcp % plot the tcp frame of robot
    h.tcp.x = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'r', 'Linewidth', 2) ;
    h.tcp.y = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'g', 'Linewidth', 2) ;
    h.tcp.z = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'b', 'Linewidth', 2) ;
    h.tcp.xt = text(0,0, opt.tcplabel(1), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.tcp.yt = text(0,0, opt.tcplabel(2), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
    h.tcp.zt = text(0,0, opt.tcplabel(3), 'FontWeight', 'bold', 'HorizontalAlignment', 'Center');
end % if opt.tcp

for i=1:ab.n % elements for each body
    if opt.frame(i)
        h.frame(i).x = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'r') ;
        h.frame(i).y = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'g') ;
        h.frame(i).z = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'b') ;
    end % frame(i)
    
    if opt.jaxis(i)
        h.jaxis(i) = line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], 'color', 'b', 'linestyle', ':') ;
        h.jlabel(i) = text(0, 0, 0, num2str(i), 'HorizontalAlignment', 'Center');
    end % jaxis(i)
    
    if opt.model(i)
        
        if ~opt.modelvrml(i)
            % If there's no vrml data to plot, display standard cylinder or
            % polyedre in fn of sigma
            N = 4 + ~ab.body(i).sigma*12 ;
            [xc, yc, zc] = cylinder(opt.mag/4, N) ;
            zc(zc==0) = -opt.mag/2 ;
            zc(zc==1) =  opt.mag/2 ;
            
            % color data
            cdata = zeros(size(zc)) ;
            for j=1:3, cdata(:,:,j) = opt.modelcolor(j) ; end
            
            % render the surface
            h.model{i} = surface(xc, yc, zc, cdata) ;
            
            % additionnal opts
            set(h.model{i}, 'FaceColor', 'inter', 'EdgeColor', 'none', ...
                'FaceAlpha', .4 ) ;
            
            % store the initial configuration of the graphical object in
            % 'UserData' field to allow us transforming it in animate.
            xyz = [xc(:)'; yc(:)'; zc(:)'];
            xyz(4,:) = 1 ;
            set(h.model{i}, 'UserData', xyz) ;
            
        else
            % if opt.modelvrml(i) is true, means users choose to plot mesh data
            % instead of simple model
            tr = TriRep(opt.vrml(i).faces,opt.vrml(i).points') ;
            
            % render the surface
            hold on ;
            h.model{i}.mesh = trisurf(tr);
            
            % display options
            % FIXME: Cannot set color to 'inter' because animate when updating
            % graphics wants the CData field.
            set(h.model{i}.mesh, 'FaceColor', opt.modelcolor, 'FaceAlpha', .5, ...
                'EdgeColor', 'none', ab.body(i).plotopt{:}) ;
            
            % get sharp edges from tri rep
            fe = tr.featureEdges(pi/6)' ;
            [x, y, z] = splitcol(tr.X) ;
            h.model{i}.edge = plot3(x(fe), y(fe), z(fe), 'k') ;
            
            % store initial triangular representation in handle, such as
            % previously.
            xc  = get(h.model{i}.mesh, 'xdata') ;
            yc  = get(h.model{i}.mesh, 'ydata') ;
            zc  = get(h.model{i}.mesh, 'zdata') ;
            xyz = [xc(:)'; yc(:)'; zc(:)'];
            xyz(4,:) = 1 ;
            set(h.model{i}.mesh, 'UserData', xyz ) ;
            
            for j=1:numel(h.model{i}.edge)
                xc = get(h.model{i}.edge(j), 'xdata') ;
                yc = get(h.model{i}.edge(j), 'ydata') ;
                zc = get(h.model{i}.edge(j), 'zdata') ;
                clear xyz
                xyz = [xc(:)'; yc(:)'; zc(:)'];
                xyz(4,:) = 1 ;
                set(h.model{i}.edge(j), 'UserData', xyz ) ;
            end
            
            
        end
        
    else
        % if user choose not to draw anything about body i, an empty cell is
        % stored
        h.model{i} = [] ;
    end % model(i)
    
end % for

end % create_new_graphical_ab()