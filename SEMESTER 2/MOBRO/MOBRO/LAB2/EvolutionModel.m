% Implements the evolution model of the system. Here, this model is simply
% the equations of odometry.

function Xnew = EvolutionModel( Xold , U )

% X=(x,y,theta,rR,rL)  U=(qRdot,qLdot)

global trackGauge period ;

v = 0.5*( X(4)*U(1) + X(5)*U(2) )             ;
w = X(4)/trackGauge*U(1) - X(5)/trackGauge*U(2) ;
    
Xnew = [Xold(1)+v*period*cos(X(3));
        Xold(2)+v*period*sin(X(3));
        Xold(3)+w*period             ;
        Xold(4);
        Xold(5)] ;
          
return          
