function OUT = slk_trajectory_task(t)

global Ti;
global Tf;

T = Trajectorytask(Ti,Tf,t);

global robot;
OUT = robot.igm(T);

end