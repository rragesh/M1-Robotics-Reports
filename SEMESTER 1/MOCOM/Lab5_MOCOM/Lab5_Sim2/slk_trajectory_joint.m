function OUT = slk_trajectory(t)

global traj 

[q, qd, qdd] = traj.update(t) ;

OUT = [q; qd; qdd] ;

end
