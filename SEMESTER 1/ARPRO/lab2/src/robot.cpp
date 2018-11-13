

#include <iostream>
#include <math.h>
#include <robot.h>
#include <sensor.h>

using namespace arpro;
using namespace std;

Environment* Sensor::envir_ = NULL;

Robot::Robot(string _name, double _x, double _y, double _theta)
{    
    pose_.x = _x;
    pose_.y = _y;
    pose_.theta = _theta;

    name_ = _name;

    // init position history
    x_history_.push_back(_x);
    y_history_.push_back(_y);

    // default sampling time: 1/100 s
    dt_ = .01;

}


void Robot::initWheels(double b, double r, double wmax)
{
    this->r = r;
    this->b = b;
    this->wmax = wmax;
}

void Robot::moveXYT(double _vx, double _vy, double _omega)
{
    //We don't need this function to be available for external use after moveVW() is defined.
    // We can move it to the protected section of the Robot class.
    // update position
    pose_.x += _vx*dt_;
    pose_.y += _vy*dt_;
    pose_.theta += _omega*dt_;

    // store position history
    x_history_.push_back(pose_.x);
    y_history_.push_back(pose_.y);
}



void Robot::rotateWheels(double _left, double _right)
{
    // to fill up after defining an initWheel method
    bool wheels_init;
    if((r <= 0) && (b <= 0))
        wheels_init = 0;
    else
        wheels_init = 1;


    if(wheels_init)
    {
        double a;

        if((fabs(_left) > fabs(wmax)) || (fabs(_right) > fabs(wmax)))
            a = max(fabs(_left/wmax), fabs(_right/wmax));

        if(a < 1)
            a = 1;

        _left /= a;
        _right /= a;
        double v = r * (_left + _right) / 2;
        double w = r * (_left - _right) / (2 * b);

        Twist twist;
        twist.vx = v * cos(pose_.theta);
        twist.vy = v * sin(pose_.theta);
        twist.w = w;

        moveXYT(twist.vx, twist.vy, twist.w);
    }
}


// move robot with linear and angular velocities
void Robot::moveVW(double _v, double _omega)
{
    // to fill up

    double wl = (_v  + b * _omega)/r;
    double wr = (_v  - b * _omega)/r;

    rotateWheels(wl, wr);

}




// try to go to a given x-y position
void Robot::goTo(const Pose &_p)
{
    // error in robot frame
    Pose error = _p.transformInverse(pose_);

    // try to do a straight line with sensor constraints
    moveWithSensor(Twist(error.x, error.y, 0));
}


void Robot::moveWithSensor(Twist _twist)
{
    // to fill up, sensor measurement and twist checking


    // uses X-Y motion (perfect but impossible in practice)
    //moveXYT(_twist.vx, _twist.vy,_twist.w);

    // to fill up, use V-W motion when defined


    for(auto & sensor : sensors_)
    sensor->checkRobotTwist(_twist);



    double alpha = 20;
    double v = _twist.vx;
    double w = alpha * _twist.vy + _twist.w;

    for(auto & sensor : sensors_)
    sensor->updateFromRobotPose(pose_);


    moveVW(v, w);

}


void Robot::printPosition()
{
    cout << "Current position: " << pose_.x << ", " << pose_.y << endl;
}

