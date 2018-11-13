
%   Theta Solve differential equations with a non-adaptive method.
%   Y = Theta(THETAFUN,TSPAN,Y0,theta,preci,nmax) with TSPAN = [T1, T2, T3, ... TN] integrates 
%   the system of differential equations y' = f(t,y) by stepping from T0 to 
%   T1 to TN. Function THETAFUN(T,Y) must return f(t,y) in a column vector.
%   The vector Y0 is the initial conditions at T0. Each row in the solution 
%   array Y corresponds to a time specified in TSPAN. 
%
%   This is a non-adaptive solver. The step sequence is determined by TSPAN
%   but the derivative function THETAFUN is evaluated multiple times per step
%   with the function Precision(THETAFUN,TSPAN,i,Y1,theta,preci,nmax) .   
%


function [T,Y,Preci,J] = theta_method(thetafun,tspan,y0,theta,preci,nmax)

if ~isnumeric(tspan)
  error('TSPAN should be a vector of integration steps.');
end

if ~isnumeric(y0)
  error('Y0 should be a vector of initial conditions.');
end

h = diff(tspan);
if any(sign(h(1))*h <= 0)
  error('Entries of TSPAN are not in order.') 
end  

try
  f0 = feval(thetafun,tspan(1),y0);
catch %#ok
  msg = ['Unable to evaluate the thetafun at t0,y0. ',lasterr];%#ok
  error(msg);  
end  

y0 = y0(:);   % Make a column vector.
if ~isequal(size(y0),size(f0))
  error('Inconsistent sizes of Y0 and f(t0,y0).');
end  

T   = tspan; 
neq = length(y0);
N   = length(tspan);
Y   = zeros(neq,N);
Preci = zeros(2,N);
J=zeros(1,N);

Y(:,1) = y0;
for i = 2:N-1
  
  y1=Y(:,i);
  
  [y,errorp1,errorp2,j]=Precision(thetafun,h(i),T(i),T(i+1),y1,theta,preci,nmax); 
  
  Y(:,i+1) = y;
  Preci(:,i+1)=[errorp1;errorp2];
  J(i+1)=j;

end
Y = Y.';


end
    
function [y,errorp1,errorp2,j]=Precision(thetafun,h,T1,T2,y1,theta,preci,nmax)
    

    neq = length(y1);
    j=0;
    
    y2=y1+h*((1-theta)*feval(thetafun,T1,y1)+theta*feval(thetafun,T2,y1));
    
    y3=y1;
    
    errorp1 = norm(y2(1:neq/2)-y1(1:neq/2),2);
    errorp2 = norm(y2(neq/2+1:neq)-y1(neq/2+1:neq),2);
    
    while (errorp1 > preci) && (errorp2 > preci) && (j < nmax)
        
        j=j+1;
        
        y1=y2;
        
        y2=y3+h*((1-theta)*feval(thetafun,T1,y3)+theta*feval(thetafun,T2,y1));
        
        if mod(neq,2)==0
             errorp1 = norm(y2(1:neq/2)-y1(1:neq/2),2);
             errorp2 = norm(y2(neq/2+1:neq)-y1(neq/2+1:neq),2);
        else
            error('size of y is not correct')
        end
        
    end
    
    y = y2;
    

end 

