%mArticulatedBody.animate   Update an articulated body animation
%
% ab.animate(q) updates an existing animation for the mAB object.
% This will have been created using object.plot().
% Updates graphical instances of this robot in all figures.
%
% See also SerialLink.plot SerialLink.animate mArticulatedBody.plot

% Last Changes :
% 20130412, Syl : The update for bodies was not suitable for parallel or
% open chain structure. Has been fixed. Major drawback is homogeneous
% matrixes are recalculated several times, not good for perf.

function animate(ab, q, handles)

if nargin < 3
  handles = findobj('Tag', ab.name);
end

for handle=handles'     % for each graphical robot instance
  h = get(handle, 'UserData');
  animate2( h, q);
end
end % animate()

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

function animate2(h, q)

ab = h.ab;
n = ab.n;
B = ab.body;

mag = h.mag;
T = ab.Z ;

% base update
if isfield(h, 'base')
  [x, y, z] = splitrow( T(1:3,4) )  ;
  vx = T*[mag;0;0;1] ;
  vy = T*[0;mag;0;1] ;
  vz = T*[0;0;mag;1] ;
  
  set(h.base.x, 'xdata', [x vx(1)], 'ydata', [y vx(2)], 'zdata', [z vx(3)]) ;
  set(h.base.y, 'xdata', [x vy(1)], 'ydata', [y vy(2)], 'zdata', [z vy(3)]) ;
  set(h.base.z, 'xdata', [x vz(1)], 'ydata', [y vz(2)], 'zdata', [z vz(3)]) ;
  
  set(h.base.xt, 'Position', vx(1:3) ) ;
  set(h.base.yt, 'Position', vy(1:3) ) ;
  set(h.base.zt, 'Position', vz(1:3) ) ;
end % base

% bodies update
jaxis_line = [0 0 ; 0 0 ; -2*mag 2*mag ; 1 1] ;

for i=1:n

  T = ab.Z*ab.T(0,i,q) ; 
  % T = T*B(i).T(q(i)) ;
  
  if isfield(h, 'jaxis')
    [x, y, z, ~] = splitrow( T*jaxis_line ) ;
    set(h.jaxis(i), 'xdata', x, 'ydata', y, 'zdata', z) ;
    set(h.jlabel(i), 'Position', [x(1); y(1); z(1)]) ;
  end % jaxis/jlabel
  
  if isfield(h, 'frame')
    [x, y, z] = splitrow(T(1:3, 4))  ;
    vx = T*[mag;0;0;1] ;
    vy = T*[0;mag;0;1] ;
    vz = T*[0;0;mag;1] ;
    set(h.frame(i).x, 'xdata', [x vx(1)], 'ydata', [y vx(2)], 'zdata', [z vx(3)]) ;
    set(h.frame(i).y, 'xdata', [x vy(1)], 'ydata', [y vy(2)], 'zdata', [z vy(3)]) ;
    set(h.frame(i).z, 'xdata', [x vz(1)], 'ydata', [y vz(2)], 'zdata', [z vz(3)]) ;
  end % frame
  
  if isfield(h, 'model')
    
    % the model part could be 3 different things 
    %   1) simple cylinder/rectangular shape -> in this case, 'model' field
    %   contains only matrix of points
    %   2) struct containing mesh vertex data and sharp edges points
    %   3) empty thing means users choose not to display anything about
    %   this body -> since model is the last thing to draw for a body we
    %   can skip all the rest of the 'for' loop using 'continue'
    if isempty(h.model{i}), continue, end ;
    
    if ~isa( h.model{i}, 'struct' )
      xyz = get(h.model{i}, 'UserData') ;
      
      xyz = T*xyz ;
      ncols = numcol(xyz)/2 ;
      x = reshape(xyz(1,:), 2, ncols) ;
      y = reshape(xyz(2,:), 2, ncols) ;
      z = reshape(xyz(3,:), 2, ncols) ;
      set(h.model{i}, 'xdata', x, 'ydata', y, 'zdata', z) ;
    else
      
      % if it is faces & vertex data
      % first, mesh rep
      xyz = get(h.model{i}.mesh, 'UserData') ;
      xyz = T*xyz ;
      ncols = numcol(xyz)/3 ;
      x = reshape(xyz(1,:), 3, ncols) ;
      y = reshape(xyz(2,:), 3, ncols) ;
      z = reshape(xyz(3,:), 3, ncols) ;
      set(h.model{i}.mesh, 'xdata', x, 'ydata', y, 'zdata', z) ;
      
      % second, sharp edge
      for j=1:numel(h.model{i}.edge)
        xyz = get(h.model{i}.edge(j), 'Userdata') ;
        xyz = T*xyz ;
        ncols = numcol(xyz)/2 ;
        x = reshape(xyz(1,:), 2, ncols) ;
        y = reshape(xyz(2,:), 2, ncols) ;
        z = reshape(xyz(3,:), 2, ncols) ;
        set(h.model{i}.edge(j), 'xdata', x, 'ydata', y, 'zdata', z) ;
      end % for
      
    end % if
  end % model
  
end % for

% tool update
if isfield(h, 'tool')
  Te = ab.Z*ab.T(0,ab.n,q)*ab.E ;
  [x, y, z] = splitrow(Te(1:3, 4))  ;
  vx = Te*[mag;0;0;1] ;
  vy = Te*[0;mag;0;1] ;
  vz = Te*[0;0;mag;1] ;
  
  set(h.tool.x, 'xdata', [x vx(1)], 'ydata', [y vx(2)], 'zdata', [z vx(3)]) ;
  set(h.tool.y, 'xdata', [x vy(1)], 'ydata', [y vy(2)], 'zdata', [z vy(3)]) ;
  set(h.tool.z, 'xdata', [x vz(1)], 'ydata', [y vz(2)], 'zdata', [z vz(3)]) ;
    
  set(h.tool.xt, 'Position', vx(1:3) ) ;
  set(h.tool.yt, 'Position', vy(1:3) ) ;
  set(h.tool.zt, 'Position', vz(1:3) ) ;
end % tool

% tcp update
if isfield(h, 'tcp')
  Ttcp = ab.Z*ab.T(0,ab.n,q)*ab.TCP ;
  [x, y, z] = splitrow(Ttcp(1:3, 4))  ;
  vx = Ttcp*[mag;0;0;1] ;
  vy = Ttcp*[0;mag;0;1] ;
  vz = Ttcp*[0;0;mag;1] ;
  
  set(h.tcp.x, 'xdata', [x vx(1)], 'ydata', [y vx(2)], 'zdata', [z vx(3)]) ;
  set(h.tcp.y, 'xdata', [x vy(1)], 'ydata', [y vy(2)], 'zdata', [z vy(3)]) ;
  set(h.tcp.z, 'xdata', [x vz(1)], 'ydata', [y vz(2)], 'zdata', [z vz(3)]) ;
    
  set(h.tcp.xt, 'Position', vx(1:3) ) ;
  set(h.tcp.yt, 'Position', vy(1:3) ) ;
  set(h.tcp.zt, 'Position', vz(1:3) ) ;
end % tcp

end
