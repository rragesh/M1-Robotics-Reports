%SPLITCOL Split Columns of an object
% Return columns of an input object through each specified output parameters. 
% Calling SPLITCOL without ouptuts parameters will produce an error.
%
% Example :
% obj = [3, 4, 5] ; [a, b, c] = splitcol(obj)
% % a = 3, b = 4, c = 5
% 
% obj = [obj; obj] ; [a, b, c] = splitcol(obj)
% % a = [3;  b = [4;  c =[5; 
% %      3];      4];     5];
%
% splitcol(obj) % <=> error.
%
% See Also splitrow

function varargout = splitcol(obj)

if numcol(obj)~=nargout, 
  error('splitcol: you specified a %d columns vector/matrix and %d outputs arguments.', ...
    numcol(obj), nargout) ;
end


for i=1:nargout, varargout{i} = obj(:,i) ; end

return

%% Test func
obj = [4, 4, 5]
[a, b, c] = splitcol(obj)

obj = [obj; obj]
[a, b, c] = splitcol(obj)

splitcol(obj)