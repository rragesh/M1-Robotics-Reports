#include <iostream>
#include <math.h>
#include <cmath>

#include <robot.h>
#include <envir.h>
#include <sensor.h>
#include <sensor_range.h>
#include <sensor_bearing.h>

using namespace std;
using namespace arpro;



int main()
{
    // default environment with moving target
    Environment envir;
    // sensors gets measurements from this environment
    Sensor::setEnvironment(envir);

    // init robot at (0,0,0)
    // Robot::robot is a parametrized constructor that takes 4 arguments, _name, _x, _y, _theta.
    // They should be passed in the same order and be of the same datatype, when being invoked.
    // It's signature is therefore, (std::string _name, double _x, double _y, double _theta).
    // The passed arguments i.e. the signature of the function cannot be modified while defining a new robot, only the values passed may differ.

    Robot robot("R2D2", 0,0,0);

    //init wheels
    robot.initWheels(0.3, 0.07, 10);
    RangeSensor front(robot, 0.1, 0, 0);

    envir.addRobot(robot);

    Robot robot2("ROBOT2", 0, 0, 0);
    robot2.initWheels(0.05, 0.07, 10);
    envir.addRobot(robot2);

    SensorBearing sb(robot2, 0.1, 0, 0);

    for(unsigned int i=0;i<10000;++i)
    {
        cout << "---------------------" << endl;

        // target is an object of type Pose, declared in the Environment structure inside envir.h
        // The target motion is defined in envir.cpp
        // update target position
        robot2.moveWithSensor(Twist(0.4, 0, 0));

        envir.updateTarget();

        // try to follow target
        robot.goTo(envir.target);


    }

    // plot trajectory
    envir.plot();
    
}
