
classdef mTrajectory < hgsetget
    
    properties
        n_dof % num dof
        n_q_traj % num point to follow
        kv % max vel
        ka % max acc
        
        q
        qd
        qdd
        
        D
        nu
        lambda
        h
        T
        t
        
        k
        cycle_time
        time_start
        done
        
        last_q
        
        name
        displayed
        
    end % properties
    
    methods
        function tr = mTrajectory(q_traj, kv, ka, varargin)
            
            if nargin==0, return ; end
            
            % parse input
            for i=1:2:length(varargin)
                pn = varargin{i} ;
                pv = varargin{i+1} ;
                if isprop(tr,pn),
                    set(tr,pn,pv)
                end
            end
            
            if(isempty(tr.name)), tr.name = 'Trajectory' ; end ;
            tr.displayed = false ;
            
            tr.done = false ;
            
            tr.n_dof = size(q_traj, 1) ;
            tr.n_q_traj = size(q_traj, 2) ;
            
            tr.q  = q_traj ;
            tr.qd = zeros(tr.n_dof, tr.n_q_traj) ;
            tr.D  = zeros(tr.n_dof, tr.n_q_traj) ;
            tr.lambda = zeros(tr.n_dof, tr.n_q_traj) ;
            tr.nu = zeros(tr.n_dof, tr.n_q_traj) ;
            tr.h  = zeros(tr.n_dof, tr.n_q_traj-1) ;
            tr.T  = zeros(tr.n_dof, tr.n_q_traj) ;
            tr.t  = zeros(1,tr.n_q_traj) ;
            
            for k=1:tr.n_q_traj-1
                for j=1:tr.n_dof
                    tr.D(j,k) = tr.q(j,k+1) - tr.q(j,k) ;
                end
                
                for j=1:tr.n_dof
                    tr.lambda(j,k) = 1 ;
                    tr.nu(j,k) = 1 ;
                    for i=1:tr.n_dof,
                        tr.lambda(j,k) = min([tr.lambda(j,k) kv(i)*abs(tr.D(j,k))/kv(j)/abs(tr.D(i,k))]) ;
                        tr.nu(j,k) = min([tr.nu(j,k) ka(i)*abs(tr.D(j,k))/ka(j)/abs(tr.D(i,k))]) ;
                    end ; % eq [13.34], adapted for all j
                    tr.qd(j,k) = tr.lambda(j,k)*kv(j)*sign(tr.D(j,k)) ; % eq [13.58]
                end
                
            end
            
            %             D
            %             lambda
            %             nu
            %             qd
            
            for k=1:tr.n_q_traj,
                
                for j=1:tr.n_dof,
                    if( k<tr.n_q_traj ), tr.h(j,k) = tr.D(j,k)/tr.qd(j,k) ;   end
                    
                    if( k==1 ),
                        tr.T(j,k) = 3/4*tr.lambda(j)*kv(j)/tr.nu(j)/ka(j) ;            % temps 1er blend            eq [13.60]
                    elseif( k==tr.n_q_traj ),
                        tr.T(j,k) = 3/4*tr.lambda(j)*kv(j)/tr.nu(j)/ka(j) ;  % temps dernier blend
                    else
                        tr.T(j,k) = 3/4*abs( tr.qd(j,k)-tr.qd(j,k-1) )/ka(j) ;          % temps blend intermediaire
                    end
                end
            end
            
            %             h
            %             T
            
            % notes (sylvain, 20141106) : when there is only one dof, the
            % line 'tr.T = max(tr.T) ;' would not work as expected, need to
            % add artificially one dummy row to make this working properly.
            if tr.n_dof==1, tr.T(2,:) = 0, tr.h(2,:) = 0 ; end
            
            tr.h = max(tr.h) ;
            tr.T = max(tr.T) ;
            
            %             h
            %             T
            
            for k=1:tr.n_q_traj
                if( k==1 ), tr.t(k) = 0 ; continue ; end
                tr.t(k) = tr.T(1) - tr.T(k) + sum(tr.h(1:k-1)) ; % eq [13.63]
            end
            
            tr.k = 1 ;
            tr.time_start = -1 ;
            
        end % mTrajectory
        
        function [q, qd, qdd] = update(tr, tiiime)
            
            if(~tr.displayed),
                buf = sprintf('[%2.4f] %s: starting at t=%2.4f', tiiime, tr.name, tiiime) ;
                disp(buf) ;
                tr.displayed = true ;
            end
            
            if(tr.done)
                q = tr.last_q ;
                qd = zeros(tr.n_dof,1) ;
                qdd = zeros(tr.n_dof,1) ;
            else
                
                if(tr.time_start<0), tr.time_start = tiiime ; end
                time = tiiime - tr.time_start ;
                
                if( tr.k<tr.n_q_traj )
                    if( time>=tr.t(tr.k+1) )
                        tr.k = tr.k+1 ;
                        buf = sprintf('[%2.4f] %s: point reached, going to k=%d/%d, t=%2.4f', tiiime, tr.name, tr.k, tr.n_q_traj, tiiime) ;
                        disp(buf) ;
                    end
                end
                
                
                switch tr.k
                    case 1 % first point
                        if( time<=2*tr.T(tr.k) ) % first blend at start
                            q   = tr.q(:,1) -1/16/tr.T(1)^3 *(time - tr.t(1))^3 *(time - tr.t(1) - 4*tr.T(1)) *( tr.qd(:,1) - 0 ) + (time-tr.t(1)-tr.T(1))*0 ; % eq [13.65]
                            qd  =           -1/4/tr.T(1)^3  *(time - tr.t(1))^2 *(time - tr.t(1) - 3*tr.T(1)) *( tr.qd(:,1) - 0 )  ;
                            qdd =           -3/4/tr.T(1)^3  *(time - tr.t(1))   *(time - tr.t(1) - 2*tr.T(1)) *( tr.qd(:,1) - 0 ) ;
                        elseif( 2*tr.T(1)< time && time <=tr.t(2) ) % linear traj after blend, going to next point
                            q   = (time-tr.t(1)-tr.T(1))*tr.qd(:,1)+tr.q(:,1) ;
                            qd  = tr.qd(:,1) ;
                            qdd = zeros(tr.n_dof,1) ;
                        end
                        
                    case tr.n_q_traj % last point
                        %if( time<=tr.t(tr.k)+2*tr.T(tr.k) )
                        q   = tr.q(:,tr.k)    -1/16/tr.T(tr.k)^3 *(time - tr.t(tr.k))^3 *(time - tr.t(tr.k) - 4*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) ) + (time-tr.t(tr.k)-tr.T(tr.k))*tr.qd(:,tr.k-1) ; % eq [13.65]
                        qd  = tr.qd(:,tr.k-1) -1/4/tr.T(tr.k)^3  *(time - tr.t(tr.k))^2 *(time - tr.t(tr.k) - 3*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) ) ;
                        qdd =                 -3/4/tr.T(tr.k)^3  *(time - tr.t(tr.k))   *(time - tr.t(tr.k) - 2*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) ) ;
                        %end
                        
                        tr.last_q = q;
                        
                        if( time>tr.t(tr.k)+2*tr.T(tr.k) ), tr.done = true ; end
                        
                    otherwise % others
                        if( time<=tr.t(tr.k)+2*tr.T(tr.k) ) % blend around tr.k^th point
                            q   = tr.q(:,tr.k)    -1/16/tr.T(tr.k)^3 *(time - tr.t(tr.k))^3 *(time - tr.t(tr.k) - 4*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) ) + (time-tr.t(tr.k)-tr.T(tr.k))*tr.qd(:,tr.k-1) ; % eq [13.65]
                            qd  = tr.qd(:,tr.k-1) -1/4/tr.T(tr.k)^3  *(time - tr.t(tr.k))^2 *(time - tr.t(tr.k) - 3*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) )  ;
                            qdd =                 -3/4/tr.T(tr.k)^3  *(time - tr.t(tr.k))   *(time - tr.t(tr.k) - 2*tr.T(tr.k)) *( tr.qd(:,tr.k)-tr.qd(:,tr.k-1) ) ;
                            
                        elseif( tr.t(tr.k)+2*tr.T(tr.k) < time && time <= tr.t(tr.k+1) ) % linear traj after blend, going to next point
                            q  = (time-tr.t(tr.k)-tr.T(tr.k))*tr.qd(:,tr.k)+tr.q(:,tr.k) ;
                            qd  = tr.qd(:,tr.k) ;
                            qdd  = zeros(tr.n_dof,1) ;
                        end
                end
            end
        end % update
        
        function init(ttr)
            for tr =ttr
                tr.k = 1 ;
                tr.time_start = -1 ;
                tr.done = false ;
            end
            
        end % init
        
        function te = getEndTime(ttr)
            te = [] ;
            for tr=ttr
                te =  [te tr.t(end)+2*tr.T(end)] ;
            end
        end
        
        function b = isDone(tr), b = tr.done ; end
        
    end % methods
    
end % classdef