% Set the parameters which have the "Determined by student" comment to tune
% the Kalman filter. Do not modify anything else in this file.

global Pinit Qgamma Qbeta mahaThreshold ;

% Uncertainty on initial position of the robot.

sigmaX     = 2;           % Determined by student
sigmaY     = 2;           % Determined by student
sigmaTheta = 2*pi/180;     % Determined by student
sigmaRR    = 0 ;            % Determined by student
sigmaRL    = sigmaRR ;
Pinit = diag( [ sigmaX^2 sigmaY^2 sigmaTheta^2 ...
                sigmaRR^2 sigmaRL^2 ] ) ;


% Measurement noise.

sigmaXmeasurement = 20/sqrt(12) ;  % Determined by student
sigmaYmeasurement = 10/sqrt(12) ;  % Determined by student
Qgamma = diag( [sigmaXmeasurement^2 sigmaYmeasurement^2] ) ;


% Input noise

sigmaWheels = 0.2;   % Determined by student
Qwheels = sigmaWheels^2 * eye(2) ;
Qbeta   = Qwheels ; 

% State noise
 
Qalpha = zeros(5) ;   % Determined by student

% Mahalanobis distance threshold

mahaThreshold = chi2inv(0.9,2)  ;  % Determined by student
