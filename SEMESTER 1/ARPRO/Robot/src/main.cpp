#include <iostream>
#include <math.h>
#include <cmath>
#include <robot.h>
#include <envir.h>
#include <sensor.h>
//#include <sensor_range.h>
//#include <sensor_bearing.h>

using namespace std;
using namespace arpro;



int main()
{

    Environment envir;   // default environment with moving target
    Sensor::setEnvironment(envir);//sensors gets measurements from this environment

    Robot robot("R2D2", 0,0,0);  //init robot at (0,0,0) //(name of robot, X, Y, THETA)
        robot.initWheels(0.3, 0.07, 10);
        //RangeSensor front(robot,0.1,0,0)
        envir.addRobot(robot);
        Robot initWheels();
    Robot robot2("ROBOT2", 0, 0, 0);
        robot2.initWheels(0.05, 0.07, 10);
        envir.addRobot(robot2);
        //SensorBearing sb(robot2, 0.1, 0, 0);

    for(unsigned int i=0;i<10000;++i)
    {
        cout << "---------------------" << endl;
        // update target position
        envir.updateTarget();        
        // try to follow target
        robot.goTo(envir.target);
        robot2.moveWithSensor(Twist(0.4, 0, 0));

    }
    // plot trajectory
    envir.plot();
    
}
