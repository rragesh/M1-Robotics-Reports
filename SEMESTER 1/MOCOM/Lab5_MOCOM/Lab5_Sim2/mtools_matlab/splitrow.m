%SPLITROW Split the object into rows
% Return n float/vector of float and place them into specified output vars,
% where n is number of rows of the object.
%
% Example :
% obj = [3, 4, 5] ; a = splitrow(obj)
% % a = [3, 4, 5]
% 
% obj = [ 3, 4, 5 ; 
%         6, 7, 8] ; 
% [a, b] = splitrow(obj)
% % a = [3, 4, 5] ;
% % b = [6, 7, 8] ;
%
% splitrow(obj) % <=> error.
%
% See Also splitrow

function varargout = splitrow(obj)

if numrow(obj)~=nargout, 
  error('splitrow: you specified a %d rows vector/matrix and %d outputs arguments.', ...
    numrow(obj), nargout) ;
end
for i=1:nargout, varargout{i} = obj(i,:) ; end

return

%% Test func
obj = [3, 4, 5] ; a = splitrow(obj)
% a = [3, 4, 5]

obj = [ 3, 4, 5 ; 
        6, 7, 8] ; 
[a, b] = splitrow(obj)
% a = [3, 4, 5] ;
% b = [6, 7, 8] ;

splitrow(obj) % <=> error.